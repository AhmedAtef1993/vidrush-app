# VidRush Backend API

A FastAPI backend for the VidRush video downloader app, powered by yt-dlp.

## Features

- Extract video information from various platforms (YouTube, TikTok, Instagram, etc.)
- Download videos in different formats and qualities
- Background download processing
- RESTful API with automatic documentation
- CORS support for frontend integration

## API Endpoints

### Health Check
- `GET /` - API status
- `GET /health` - Health check

### Video Information
- `POST /api/video/info` - Extract video information and available formats

### Downloads
- `POST /api/video/download` - Start video download
- `GET /api/download/{download_id}` - Get download status
- `GET /api/downloads` - List all downloads
- `DELETE /api/download/{download_id}` - Delete download

## Local Development

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd backend
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the application**
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

5. **Access API documentation**
   - Swagger UI: http://localhost:8000/docs
   - ReDoc: http://localhost:8000/redoc

## Docker Development

1. **Build the image**
   ```bash
   docker build -t vidrush-backend .
   ```

2. **Run the container**
   ```bash
   docker run -p 8000:8000 vidrush-backend
   ```

## Environment Variables

- `PORT` - Server port (default: 8000)
- `HOST` - Server host (default: 0.0.0.0)
- `CORS_ORIGINS` - Allowed CORS origins (default: "*")

## Supported Platforms

- YouTube
- TikTok
- Instagram
- Facebook
- Twitter/X
- LinkedIn
- And many more (via yt-dlp)

## Notes

- Downloads are stored in memory (not persistent)
- For production, consider adding a database
- File storage is temporary (files are deleted when container restarts) 