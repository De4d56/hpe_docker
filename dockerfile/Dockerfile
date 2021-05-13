FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel

LABEL maintainer filip.zoric@fer.hr

# Set arguments 
ARG USER=developer 
ARG UID=1000
ARG GID=1000 
ARG PW=developer

# Install necessary software packages 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    build-essential \
    feh \ 
    git \
    nano \
    python \
    python-pip \
    python3 \
    python3-pip \
    software-properties-common \ 
    sudo \ 
    wget \
    curl
RUN sudo apt install --only-upgrade python3


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
#RUN git clone https://github.com/microsoft/human-pose-estimation.pytorch.git

# Add pycharm for faster development and testing 
ENV version 2020.2.3
#RUN wget -O /home/developer/pycharm.tar.gz "https://download.jetbrains.com/python/pycharm-community-$version.tar.gz"
#RUN tar -xvf /home/developer/pycharm.tar.gz && rm -rf /home/developer/pycharm.tar.gz 
#RUN echo 'alias pycharm=/home/developer/pycharm-community-$version/bin/pycharm.sh' >> /home/developer/.bashrc 

#Install dependencies, fix broken ones from requirements.txt
RUN pip install -r human-pose-estimation.pytorch/requirements.txt
RUN apt install -y libsm6
RUN apt install -y libxrender1
RUN pip install easydict
#RUN sudo apt install -y python3-opencv
RUN pip install opencv-python
RUN pip install json_tricks
RUN pip install scipy
RUN pip install nms
RUN pip install cython
RUN apt install libgl1-mesa-glx
RUN sudo apt install python-scipy

#Make libs
RUN make -C human-pose-estimation.pytorch/lib/ 

#Install COCOAPI
RUN git clone https://github.com/cocodataset/cocoapi.git
RUN make install -C cocoapi/PythonAPI

#Disable cudnn for batch_norm (github instructions)
#RUN sed -i "1254s/torch\.backends\.cudnn\.enabled/False/g" /opt/conda/lib/python3.6/site-packages/torch/nn/functional.py

# Install ROS
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
RUN sudo apt update
RUN sudo apt install ros-melodic-desktop
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN sudo apt install python-rosdep
RUN sudo rosdep init
RUN rosdep update

CMD ["bash"]
