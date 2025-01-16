#!/bin/bash
Xvfb :0 -screen 0 1980x1024x24 &
# fluxbox &
/root/.vnc/xstart &
# /easy-novnc --addr :8080 --host localhost --port 5900 --no-url-password --novnc-params resize=remote
exec /usr/bin/supervisord -c /etc/supervisor/supervisor.conf
# /easy-novnc --no-url-password