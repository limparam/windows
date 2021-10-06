#!/bin/bash
echo "https://www.facebook.com/live/create"
echo "Paste streaming key:"
read key

ffmpeg -rtsp_transport tcp -y -i rtsp://login:password@camera_ip:554/axis-media/media.amp -t 18000 -c:a copy -ac 1 -ar 44100 -b:a 128k -c:v libx264 -pix_fmt yuv420p -r 30 -g 60 -vb 2048k -minrate 2000k -maxrate 4000k -bufsize 4096k -threads 4 -f flv rtmp://rtmp-api.facebook.com:80/rtmp/$key
exit 0
