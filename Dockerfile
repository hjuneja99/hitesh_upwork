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

# Copy the rest of the application code.
COPY . /app

# Copy and make the startup script executable
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Debug: List permissions for start.sh to verify it's executable
RUN ls -l /app/start.sh

# Expose the ports: 8000 for HTTP and 9083 for WebSocket.
EXPOSE 8000 9083

# Use the startup script as the container's entrypoint.
CMD ["/bin/bash", "/app/start.sh"]
