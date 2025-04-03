# Use an official lightweight Python image.
FROM python:3.10-slim

# Prevent Python from buffering stdout/stderr.
ENV PYTHONUNBUFFERED=1

# Install system dependencies (ffmpeg is needed for pydub)
RUN apt-get update && apt-get install -y ffmpeg

# Set the working directory.
WORKDIR /app

# Copy dependency file and install Python packages.
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy all application code into the container.
COPY . /app

# Ensure the startup script is executable.
RUN chmod +x start.sh

# Expose the port used by your application (HTTP + WebSocket via reverse proxy)
EXPOSE 8000

# Use the startup script as the container's entrypoint.
CMD ["./start.sh"]
