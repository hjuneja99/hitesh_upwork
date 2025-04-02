# Use an official lightweight Python image.
FROM python:3.10-slim

# Prevent Python from buffering stdout/stderr.
ENV PYTHONUNBUFFERED=1

# Install system dependencies: ffmpeg, nginx, and supervisor.
RUN apt-get update && apt-get install -y ffmpeg nginx supervisor

# Set the working directory.
WORKDIR /app

# Copy dependency file and install Python packages.
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy all application files into /app.
COPY . /app

# Expose port 8000 (the public port on Koyeb).
EXPOSE 8000

# Use supervisord to run both processes.
CMD ["/usr/bin/supervisord", "-c", "/app/supervisord.conf"]
