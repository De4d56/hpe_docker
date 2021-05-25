#!/usr/bin/bash 

# export DATA_PATH=$PWD in correct folder /home/Work/data
#docker run -it --network host --privileged --gpus all \
#       -e DISPLAY=$DISPLAY \
#       -v /dev:/dev \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v $DATA_PATH:/home/developer/data \
#       --name hpe_cont hpe

# Kod -v staviti put do models i data direktorija koji su instalirani prema github instrukcijama
sudo docker run -it --network host --privileged --gpus all -e DISPLAY=$DISPLAY -v /media/denis/Data/LINUX/docker/models:/home/developer/hpe_ros/models -v /media/denis/Data/LINUX/docker/data:/home/developer/hpe_ros/data -v /dev:/dev  --shm-size 12G --name hpe_1 hpe


