#!/bin/bash

rsync -avzhP --delete --rsh='ssh -p 2112' ~/Developer/Uni/flutter_assistant/build/web/ root@156.236.31.192:/var/www/main;

ssh root@156.236.31.192 -p 2112 'systemctl restart nginx';