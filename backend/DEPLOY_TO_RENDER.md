# Deploy VidRush Backend to Render

## Step-by-Step Deployment Guide

### 1. Prepare Your Repository
Make sure your backend files are in a GitHub repository:
- `main.py`
- `requirements.txt`
- `render.yaml` (optional, for automatic deployment)

### 2. Deploy to Render

#### Option A: Using Render Dashboard (Recommended)

1. **Go to Render Dashboard**
   - Visit: https://dashboard.render.com
   - Sign up/Login with your GitHub account

2. **Create New Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select the repository containing your backend

3. **Configure the Service**
   - **Name**: `vidrush-backend`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`
   - **Plan**: Free

4. **Environment Variables** (if needed)
   - Add any required environment variables in the dashboard

5. **Deploy**
   - Click "Create Web Service"
   - Wait for build and deployment (usually 2-5 minutes)

#### Option B: Using render.yaml (Automatic)

If you have the `render.yaml` file in your repository:
1. Connect your GitHub repo to Render
2. Render will automatically detect and deploy using the configuration

### 3. Get Your API URL

After successful deployment, you'll get a URL like:
```
https://vidrush-backend.onrender.com
```

### 4. Test Your API

Test the health endpoint:
```bash
curl https://vidrush-backend.onrender.com/health
```

### 5. Update Flutter App

Update your Flutter app's API configuration:

In `lib/config/api_config.dart`:
```dart
// Change from localhost to your Render URL
static const String deployedUrl = 'https://vidrush-backend.onrender.com';
```

### 6. Environment Variables (if needed)

If you need to add environment variables in Render:
- Go to your service dashboard
- Navigate to "Environment" tab
- Add any required variables

### Troubleshooting

**Common Issues:**
1. **Build fails**: Check that all dependencies are in `requirements.txt`
2. **Service crashes**: Check logs in Render dashboard
3. **CORS issues**: The API already includes CORS middleware for all origins

**Logs**: Check deployment logs in Render dashboard for any errors.

### API Endpoints Available

- `GET /health` - Health check
- `POST /api/video/info` - Get video metadata
- `POST /api/video/download` - Start download
- `GET /api/download/{id}` - Get download status
- `GET /api/downloads` - List all downloads
- `DELETE /api/download/{id}` - Delete download

### Cost

- **Free Plan**: $0/month (with limitations)
- **Paid Plans**: Start from $7/month for more resources

The free plan is sufficient for testing and moderate usage. 