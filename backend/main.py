from fastapi import FastAPI, HTTPException, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List
import yt_dlp
import os
import json
import asyncio
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="VidRush API",
    description="Backend API for VidRush video downloader app",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your frontend domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class VideoInfo(BaseModel):
    url: str
    title: Optional[str] = None
    uploader: Optional[str] = None
    thumbnail: Optional[str] = None
    duration: Optional[int] = None
    formats: Optional[List[dict]] = None

class DownloadRequest(BaseModel):
    url: str
    format_id: Optional[str] = None
    quality: Optional[str] = None

class DownloadResponse(BaseModel):
    status: str
    message: str
    download_url: Optional[str] = None
    filename: Optional[str] = None

# In-memory storage for downloads (in production, use a database)
downloads = {}

@app.get("/")
async def root():
    return {"message": "VidRush API is running!", "version": "1.0.0"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "timestamp": datetime.now().isoformat()}

@app.post("/api/video/info", response_model=VideoInfo)
async def get_video_info(video_info: VideoInfo):
    """Extract video information from URL"""
    try:
        ydl_opts = {
            'quiet': True,
            'no_warnings': True,
            'extract_flat': False,
        }
        
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(video_info.url, download=False)
            
            # Extract available formats
            formats = []
            if 'formats' in info:
                for fmt in info['formats']:
                    if fmt.get('height') and fmt.get('ext'):
                        formats.append({
                            'format_id': fmt.get('format_id'),
                            'ext': fmt.get('ext'),
                            'height': fmt.get('height'),
                            'filesize': fmt.get('filesize'),
                            'url': fmt.get('url'),
                        })
            
            return VideoInfo(
                url=video_info.url,
                title=info.get('title'),
                uploader=info.get('uploader'),
                thumbnail=info.get('thumbnail'),
                duration=info.get('duration'),
                formats=formats
            )
    
    except Exception as e:
        logger.error(f"Error extracting video info: {str(e)}")
        raise HTTPException(status_code=400, detail=f"Failed to extract video info: {str(e)}")

@app.post("/api/video/download", response_model=DownloadResponse)
async def download_video(download_req: DownloadRequest, background_tasks: BackgroundTasks):
    """Download video with specified format"""
    try:
        # Generate unique download ID
        download_id = f"download_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        # Configure yt-dlp options
        ydl_opts = {
            'outtmpl': f'downloads/{download_id}.%(ext)s',
            'format': download_req.format_id if download_req.format_id else 'best',
        }
        
        # Add download to background tasks
        background_tasks.add_task(process_download, download_req.url, ydl_opts, download_id)
        
        downloads[download_id] = {
            'status': 'pending',
            'url': download_req.url,
            'created_at': datetime.now().isoformat()
        }
        
        return DownloadResponse(
            status="started",
            message="Download started successfully",
            download_url=f"/api/download/{download_id}"
        )
    
    except Exception as e:
        logger.error(f"Error starting download: {str(e)}")
        raise HTTPException(status_code=400, detail=f"Failed to start download: {str(e)}")

async def process_download(url: str, ydl_opts: dict, download_id: str):
    """Background task to process video download"""
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            
            # Update download status
            downloads[download_id].update({
                'status': 'completed',
                'filename': info.get('_filename'),
                'title': info.get('title'),
                'completed_at': datetime.now().isoformat()
            })
            
            logger.info(f"Download completed: {download_id}")
    
    except Exception as e:
        logger.error(f"Download failed for {download_id}: {str(e)}")
        downloads[download_id].update({
            'status': 'failed',
            'error': str(e),
            'failed_at': datetime.now().isoformat()
        })

@app.get("/api/download/{download_id}")
async def get_download_status(download_id: str):
    """Get download status"""
    if download_id not in downloads:
        raise HTTPException(status_code=404, detail="Download not found")
    
    return downloads[download_id]

@app.get("/api/downloads")
async def list_downloads():
    """List all downloads"""
    return {"downloads": downloads}

@app.delete("/api/download/{download_id}")
async def delete_download(download_id: str):
    """Delete a download"""
    if download_id not in downloads:
        raise HTTPException(status_code=404, detail="Download not found")
    
    # Remove file if it exists
    download_info = downloads[download_id]
    if download_info.get('filename') and os.path.exists(download_info['filename']):
        os.remove(download_info['filename'])
    
    del downloads[download_id]
    return {"message": "Download deleted successfully"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 