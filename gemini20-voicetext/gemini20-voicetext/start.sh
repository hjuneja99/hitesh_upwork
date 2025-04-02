#!/bin/bash

# Start the HTTP server to serve static files (e.g., index.html) on port 8000
python3 -m http.server 8000 &

echo "HTTP server started on port 8000, serving static files."

# Start the WebSocket server (this will run in the foreground)
python main.py
