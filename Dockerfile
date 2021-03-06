FROM ubuntu:16.04

# Install apt-getable dependencies
RUN \
 apt-get -y update && apt-get -y upgrade
 
 RUN apt-get update \
     && apt-get install -y \
         build-essential \
         cmake \
         git \
         software-properties-common \
         libatlas-base-dev \
         libboost-python-dev \
         libeigen3-dev \
         libgoogle-glog-dev \
         libopencv-dev \
         libsuitesparse-dev \
         python3 \
         python-numpy \
         python-opencv \
         python-pip \
         python-pyexiv2 \
         python-pyproj \
         python-scipy \
         python-yaml \
         wget \
     && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

 # Install python requirements
 RUN \
     pip install exifread==2.1.2 \
                 gpxpy==1.1.2 \
                 networkx==1.11 \
                 numpy \
                 pyproj==1.9.5.1 \
                 pytest==3.0.7 \
                 python-dateutil==2.6.0 \
                 PyYAML==3.12 \
                 scipy \
                 xmltodict==0.10.2 \
                 cloudpickle==0.4.0 \
                 loky==1.2.1
                 
 #INSTALL wormhole
 RUN \
   pip install magic-wormhole

#install openmvs
RUN \
 mkdir ~/building && \
 apt-get update -qq &&  apt-get install -qq && \
 apt-get -y install build-essential git mercurial cmake libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev libxmu-dev libxi-dev && \
 cd ~/building && \
 hg clone https://bitbucket.org/eigen/eigen#3.2 && \
 mkdir eigen_build && cd eigen_build && \
 cmake . ../eigen && \
 make &&  make install && \
 cd ~/building && \
 apt-get -y install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev && \
 apt-get -y install libopencv-dev && \
 apt-get -y install libcgal-dev libcgal-qt5-dev && \
 git clone https://github.com/cdcseacave/VCG.git vcglib && \
 apt-get -y install libatlas-base-dev libsuitesparse-dev && \
 git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver && \
 mkdir ceres_build && cd ceres_build && \
 cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
 make -j4 && make install && \
 cd ~/building && \
 apt-get -y install freeglut3-dev libglew-dev libglfw3-dev && \
 git clone https://github.com/cdcseacave/openMVS.git openMVS && \
 mkdir openMVS_build && cd openMVS_build && \
 cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT="~/building/vcglib" && \
 make -j4 &&  make install



 #install openmvg from source
RUN \
  cd ~/ && \
  apt-get install -y libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev && \
  apt-get install -y graphviz

RUN \
  cd ~/ && \
  git clone --recursive https://github.com/openMVG/openMVG.git && \
  mkdir openMVG_Build && cd openMVG_Build && \
  cmake -DCMAKE_BUILD_TYPE=RELEASE ../openMVG/src/ && \
  cmake --build . --target install

  RUN rm -rf ~/building
  RUN echo "set completion-ignore-case-On" >> ~/.inputrc
  RUN echo "export PATH=$PATH:/usr/local/bin/OpenMVS" >> ~/.bashrc
