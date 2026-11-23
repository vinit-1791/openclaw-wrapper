FROM docker.io/openclaw/openclaw:2026.6.34
USER root

# Tools for the YouTube pipelines in /data/workspace (rebuilt into the image so
# they survive redeploys; the container filesystem outside /data is not persistent).
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python3-pip ffmpeg fonts-dejavu-core fonts-liberation \
 && rm -rf /var/lib/apt/lists/*

# Debian 12 marks system Python as externally managed, hence --break-system-packages.
# Versions mirror /data/workspace/automated-youtube/requirements.txt.
RUN pip3 install --no-cache-dir --break-system-packages \
      "anthropic>=0.40.0" \
      "openai>=1.0.0" \
      "Pillow>=10.0.0" \
      "yt-dlp>=2024.1.0" \
      "edge-tts>=6.1.0" \
      "requests>=2.31.0" \
      "python-dotenv>=1.0.0" \
      "google-api-python-client>=2.100.0" \
      "google-auth-httplib2>=0.1.1" \
      "google-auth-oauthlib>=1.1.0"
