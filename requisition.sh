apt-get update
apt-get install git wget zip cmake make gcc g++ cmake-curses-gui mesa-common-dev freeglut3-dev libosmesa6-dev ftgl-dev xorg-dev nodejs mongodb

ln -s /usr/bin/nodejs /usr/bin/node

wget http://www.vtk.org/files/release/5.10/vtk-5.10.1.zip
unzip vtk-5.10.1.zip
mkdir VTK5.10.1_build
cd VTK5.10.1_build
cmake ../VTK5.10.1 -DBUILD_SHARED_LIBS=ON
make install
cd ..

git clone https://github.com/tpaviot/oce.git
cd oce
git checkout 13965711913c4590549de562e55c922fb0889d24
cd ..

mkdir oce_build
cd oce_build
cmake ../oce
make install
cd ..
