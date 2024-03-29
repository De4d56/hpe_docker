FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel

LABEL maintainer filip.zoric@fer.hr

# Set arguments 
ARG USER=developer 
ARG UID=1000
ARG GID=1000 
ARG PW=developer
ARG TZ=Europe/Zagreb

# Install necessary software packages 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    build-essential \
    feh \ 
    git \
    nano \
    python \
    python-pip \
    software-properties-common \ 
    sudo \ 
    wget \
    curl \
    apt-utils
RUN sudo apt install --only-upgrade python3
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone


# Add developer user / remove neccessity to type password for sudo command
RUN adduser --disabled-password \
    --gecos '' ${USER}
RUN adduser ${USER} sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

# Install packages neccessary for training and testing neural networks
#RUN conda install -c anaconda \
#                     scipy \
#                     configargparse \
#                     cython

#RUN conda install -c conda-forge \
#                     progress \
#                     json_tricks \
#                     tensorboardx \
#                     easydict \
#                     opencv \
#                     pycocotools

# Clone human pose estimation from microsoft
WORKDIR /home/${USER}
RUN mkdir catkin_ws
RUN mkdir catkin_ws/src
RUN git clone https://github.com/De4d56/hpe_ros_package.git /home/developer/catkin_ws/src

# Add pycharm for faster development and testing 
ENV version 2020.2.3
#RUN wget -O /home/developer/pycharm.tar.gz "https://download.jetbrains.com/python/pycharm-community-$version.tar.gz"
#RUN tar -xvf /home/developer/pycharm.tar.gz && rm -rf /home/developer/pycharm.tar.gz 
#RUN echo 'alias pycharm=/home/developer/pycharm-community-$version/bin/pycharm.sh' >> /home/developer/.bashrc 

#Install dependencies, fix broken ones from requirements.txt
RUN pip install setuptools
RUN pip install -r catkin_ws/src/hpe/src/requirements.txt
RUN apt install -y libsm6
RUN apt install -y libxrender1
RUN pip install easydict
RUN pip install opencv-python
RUN pip install json_tricks
RUN pip install scipy
RUN pip install nms
RUN pip install cython
RUN apt install -y libgl1-mesa-glx
RUN sudo apt -y install python-scipy

#Make libs
#RUN make -C hpe_ros/lib/ 

#Install COCOAPI
RUN git clone https://github.com/cocodataset/cocoapi.git
#RUN make install -C cocoapi/PythonAPI

#Disable cudnn for batch_norm (github instructions)
#RUN sed -i "1254s/torch\.backends\.cudnn\.enabled/False/g" /opt/conda/lib/python3.6/site-packages/torch/nn/functional.py

# Install ROS
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
RUN sudo apt update
RUN sudo apt -y install ros-melodic-desktop
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /home/developer/catkin_ws/devel/setup.bash" >> ~/.bashrc
#RUN DODATI SETUP IZ CATKIN_DEVEL FOLDERA
RUN sudo apt -y install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN sudo rosdep init
RUN rosdep update
RUN pip install rospkg
RUN export PYTHONPATH=/opt/ros/melodic/lib/python2.7/dist-packages:/opt/conda/lib/python3.7/site-packages


# Camera setup
RUN apt install -y ros-melodic-camera-info-manager
RUN apt install -y ros-melodic-image-view
RUN git clone https://github.com/ros-drivers/usb_cam.git
RUN mv usb_cam catkin_ws/src
#RUN catkin_make /home/developer/catkin_ws

# Download pretrained model(if it doesn't work download from here: https://drive.google.com/drive/folders/13_wJ6nC7my1KKouMkQMqyr9r1ZnLnukP?usp=sharing) => pose_mpii/pose_resnet_50_384x384
RUN wget -O pose_resnet_50_384x384.pth.tar https://dlmheg.ch.files.1drv.com/y4mYOUGDIPflgOb8vVvmeVFBY0nQzGtCXVGDL_PYmpE4SN58SdM2qiux4_AQC0EcAbRnkX6ijCzjfXli5tOAIQM2RT-E-l7WjZMt7oEs9QK1Mrt9JslIsy_cZ2wQGWY5CdwC-y2aulJCQBE-5aEE_2SON0ZI2bwb8Hiy6sBx51Q6m4I-o185LqFhs9Bd6EzUG9QWbXCCfXoXGzJHhXwPGhs-Q
RUN mkdir catkin_ws/src/hpe/src/models
RUN mv pose_resnet_50_384x384.pth.tar catkin_ws/src/hpe/src/models/



CMD ["bash"]
