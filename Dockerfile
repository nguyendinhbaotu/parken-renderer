# Origin docker image
FROM ubuntu

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# Install dependencies
RUN apt-get update && \
    apt-get --assume-yes install git wget zip cmake make gcc g++ cmake-curses-gui mesa-common-dev freeglut3-dev libosmesa6-dev ftgl-dev xorg-dev nodejs npm mongodb && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    wget http://www.vtk.org/files/release/5.10/vtk-5.10.1.zip &&\
    unzip vtk-5.10.1.zip &&\
    mkdir VTK5.10.1_build &&\
    cd VTK5.10.1_build &&\
    cmake ../VTK5.10.1 -DBUILD_SHARED_LIBS=ON -DCMAKE_C_FLAGS=-DGLX_GLXEXT_LEGACY -DCMAKE_CXX_FLAGS=-DGLX_GLXEXT_LEGACY -Wno-dev &&\
    make install

RUN npm install

# Bundle app source
COPY . .

# Expose port
EXPOSE 8080

# Run nodejs application
CMD [ "npm", "start" ]
