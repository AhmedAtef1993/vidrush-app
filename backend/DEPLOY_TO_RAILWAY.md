# Deploy VidRush Backend to Railway

## Alternative Deployment Option

### 1. Prepare Your Repository
Make sure your backend files are in a GitHub repository:
- `main.py`
- `requirements.txt`
- `railway.json` (optional, for automatic deployment)

### 2. Deploy to Railway

#### Option A: Using Railway Dashboard

1. **Go to Railway Dashboard**
   - Visit: https://railway.app
   - Sign up/Login with your GitHub account

2. **Create New Project**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository

3. **Configure the Service**
   - Railway will automatically detect it's a Python app
   - The `railway.json` file will configure the deployment
   - Or manually set:
     - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`

4. **Deploy**
   - Railway will automatically build and deploy
   - Wait for deployment (usually 1-3 minutes)

#### Option B: Using Railway CLI

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   ```

2. **Login and Deploy**
   ```bash
   railway login
   railway init
   railway up
   ```

### 3. Get Your API URL

After successful deployment, you'll get a URL like:
```
https://vidrush-backend-production.up.railway.app
```

### 4. Test Your API

Test the health endpoint:
```bash
curl https://vidrush-backend-production.up.railway.app/health
```

### 5. Update Flutter App

Update your Flutter app's API configuration:

In `lib/config/api_config.dart`:
```dart
// Change from localhost to your Railway URL
static const String deployedUrl = 'https://vidrush-backend-production.up.railway.app';
```

### 6. Environment Variables (if needed)

If you need to add environment variables in Railway:
- Go to your project dashboard
- Navigate to "Variables" tab
- Add any required variables

### Troubleshooting

**Common Issues:**
1. **Build fails**: Check that all dependencies are in `requirements.txt`
2. **Service crashes**: Check logs in Railway dashboard
3. **CORS issues**: The API already includes CORS middleware for all origins

**Logs**: Check deployment logs in Railway dashboard for any errors.

### API Endpoints Available

- `GET /health` - Health check
- `POST /api/video/info` - Get video metadata
- `POST /api/video/download` - Start download
- `GET /api/download/{id}` - Get download status
- `GET /api/downloads` - List all downloads
- `DELETE /api/download/{id}` - Delete download

### Cost

- **Free Plan**: $0/month (with limitations)
- **Paid Plans**: Start from $5/month for more resources

The free plan is sufficient for testing and moderate usage.

### Railway vs Render

**Railway Advantages:**
- Faster deployments
- Better developer experience
- More generous free tier

**Render Advantages:**
- More established platform
- Better documentation
- More configuration options

Both platforms work well for this use case. 