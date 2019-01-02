#!/bin/bash

for i in `cat denses.in` ; do 
  sed -e 's/!R/'$i'/g' lukas-test.in > lukas-testme.in
  /home/dr/Bin/T3d  -d 10 -i lukas-testme.in -o lukas-testme.mesh -y 2 -x lukas-testme.vrml
  cat lukas-testme.mesh | head -2 | tail -1 > /tmp/ll
  read a b c d e f g h < /tmp/ll
  echo $i $a >> denses
  echo "running $i"
done
