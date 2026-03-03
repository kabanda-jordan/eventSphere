# 📹 How to Add Your Demo Video

## Quick Steps

### 1. Create Demo Folder
In your project root directory, create a folder called `demo`:

```bash
mkdir demo
```

Or manually:
- Right-click in your project folder
- Select "New" → "Folder"
- Name it `demo`

### 2. Copy Your Video
Copy your demo video file into the `demo` folder and rename it to:

```
EventSphere-Demo.mp4
```

**Full path should be:**
```
C:\Users\kaban\Music\event-management-system\demo\EventSphere-Demo.mp4
```

### 3. Verify the Setup
Your project structure should now look like:

```
event-management-system/
├── demo/
│   └── EventSphere-Demo.mp4    ← Your video here
├── src/
├── database/
├── pom.xml
├── README.md
└── ...
```

### 4. Commit to Git (Optional)

**⚠️ WARNING:** Video files can be large!

#### Option A: Include Video in Git (if small < 50MB)
```bash
git add demo/EventSphere-Demo.mp4
git add README.md
git commit -m "Add demo video and update README"
git push
```

#### Option B: Use Git LFS (for large videos)
```bash
# Install Git LFS first
git lfs install
git lfs track "*.mp4"
git add .gitattributes
git add demo/EventSphere-Demo.mp4
git add README.md
git commit -m "Add demo video with Git LFS"
git push
```

#### Option C: Upload to Cloud (Recommended for large files)
Instead of including the video in Git, upload it to:
- **YouTube** (unlisted or public)
- **Google Drive** (with public link)
- **Dropbox** (with public link)
- **OneDrive** (with public link)

Then update README.md with the link:
```markdown
## 🎥 Demo Video

Watch the full demonstration: [EventSphere Demo Video](YOUR_LINK_HERE)
```

## 🎬 Video Recommendations

### What to Show in Your Demo:
1. **Login Page** (0:00-0:30)
   - Show CAPTCHA verification
   - Enter credentials
   - Successful login

2. **Dashboard** (0:30-1:00)
   - Overview of stats
   - Quick actions
   - Theme toggle (dark/light)

3. **Event Management** (1:00-2:00)
   - Browse events
   - Create new event
   - Edit event
   - Delete event
   - Search functionality

4. **Student Management** (2:00-2:30)
   - View students list
   - Add new student
   - Edit student
   - Search students

5. **Chat System** (2:30-3:00)
   - Send messages
   - View message history
   - Real-time updates

6. **Settings** (3:00-3:30)
   - Profile settings
   - 2FA setup
   - Theme preferences

7. **Two-Factor Authentication** (3:30-4:00)
   - Logout
   - Login with 2FA enabled
   - Enter OTP code
   - Successful verification

### Video Tips:
- **Duration:** 3-5 minutes ideal
- **Resolution:** 1080p (1920x1080) recommended
- **Format:** MP4 (H.264 codec)
- **Audio:** Clear narration or background music
- **Editing:** Cut out mistakes, add transitions
- **Text overlays:** Highlight key features

### Recording Tools:
- **Windows:** OBS Studio (free), Camtasia
- **Screen Recording:** Windows Game Bar (Win + G)
- **Video Editing:** DaVinci Resolve (free), Adobe Premiere

## 📊 File Size Considerations

### GitHub Limits:
- **Single file:** Max 100MB
- **Repository:** Max 1GB recommended
- **Push:** Max 2GB

### If Your Video is Too Large:

#### Compress the Video:
Use **HandBrake** (free) to compress:
1. Download HandBrake
2. Open your video
3. Select "Fast 1080p30" preset
4. Click "Start Encode"
5. Result: Much smaller file size

#### Or Split into Clips:
- Part 1: Login & Dashboard
- Part 2: Event Management
- Part 3: Student Management & Chat

## 🌐 Alternative: Upload to YouTube

### Steps:
1. Upload video to YouTube
2. Set visibility to "Unlisted" (not public, but accessible via link)
3. Copy the video URL
4. Update README.md:

```markdown
## 🎥 Demo Video

[![EventSphere Demo](https://img.youtube.com/vi/YOUR_VIDEO_ID/maxresdefault.jpg)](https://www.youtube.com/watch?v=YOUR_VIDEO_ID)

Click the image above to watch the full demonstration on YouTube.
```

### Benefits of YouTube:
- ✅ No file size limits
- ✅ Automatic video player
- ✅ Thumbnail preview
- ✅ Mobile-friendly
- ✅ Doesn't bloat your Git repository

## ✅ Current Status

Your README.md has been updated with:
- 🎥 Demo Video section at the top
- 📹 Video location reference
- 📝 List of features shown in demo
- 🔗 Link to local video file

**Next Step:** Copy your video to `demo/EventSphere-Demo.mp4`

## 🎓 For Your Teacher

When presenting:
1. Show the README with video link
2. Play the video (either from local file or YouTube)
3. Then do a live demo if time permits
4. Highlight the security features (CAPTCHA, 2FA, BCrypt)
5. Show the modern UI (theme toggle, animations)
6. Demonstrate CRUD operations

**Good luck with your presentation! 🚀**
