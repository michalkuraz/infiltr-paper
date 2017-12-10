#!/bin/bash

function run_drutes {


  machname=`hostname`

  if [ -d $7 ]; then
    cd $7
  else
    echo "working directory on remote machine $machname does not exist"
    exit 1
  fi
    

  rm -rf $1

  mkdir $1

  cp -a drutemp/* $1

  cd $1
  
  a=$2
  n=$3
  ths=$4
  Ks=$5
  Ss=$6

  m=`echo "scale=12; 1.0-1.0/$n" | bc`
   
  sed -e 's/!A/'$a'/g' -e 's/!N/'$n'/g' -e 's/!M/'$m'/g' -e 's/!K/'$Ks'/g' -e 's/!T/'$ths'/g' -e 's/!S/'$Ss'/g' drutes.conf/water.conf/matrix.conf.temp > drutes.conf/water.conf/matrix.conf
  
   bin/drutes > /dev/null
   
  
   Rscript ../evol.R > objfnc.val
   

  cd ..
    
}

machines[1]=neptun01
machines[2]=nostromo.fsv.cvut.cz
machines[3]=neptun02
machines[4]=drutes.org


procpmach[1]=20
procpmach[2]=6
procpmach[3]=20
procpmach[4]=8

nmach=${#machines[@]}

declare -A procsdone

for i in `seq 1 ${#machines[@]} ` ; do
  totdone[$i]=0
  for j in `seq 1 ${procpmach[$i]}`; do
    procsdone[$i,$j]=0
  done
done


rm -f drutes.vals

if [[ ${#machines[@]} -ne ${#procpmach[@]} ]]; then
  echo "each machine must have its number of processes defined"
  exit 1
fi

wdir=/home/miguel/skola/infiltr/optim3

rm -f drutes.vals       
let nproc=0
while read l a b c d e
  do
    if [[  $l == "p"  ]]; then
      let nproc=$nproc+1
    fi
  done < pars.in
  
let z=0
for i in `seq 1 ${#procpmach[@]}`
  do
    let z=$z+${procpmach[$i]}
  done

if [[ $z -ne $nproc ]] ; then
  echo "number of processes ( $z ) differ from the number of input data ( $nproc )"
  exit 1
fi



let z=0
let mach=1
let minit=0
while read l a b c d e
  do
    if [[  $l == "p"  ]]; then
      let z=z+1
      let testmach=z-$minit
      if [[ $testmach -gt ${procpmach[$mach]} ]] ; then
	let minit=${procpmach[$mach]}
        let mach=$mach+1
      fi
      
      if [[ $z -lt $nproc ]] ; then
        typeset -f | ssh ${machines[$mach]} "$(cat); run_drutes $z $a $b $c $d $e $wdir &" &
      else
        typeset -f | ssh ${machines[$mach]} "$(cat); run_drutes $z $a $b $c $d $e $wdir " 
      fi
    fi
  done < pars.in
 

let kk=0



while [[ $kk -lt $nmach ]] ; do 
  
  for mach in `seq 1 $nmach`; do
    if [[ ${totdone[$mach]} == 0 ]] ; then
      for i in `seq 1 ${procpmach[$mach]}` ; do
        FILE="$wdir/$i/objfnc.val"
        if ( ssh -t ${machines[$mach]} "[ -f $FILE ]" ); then
          let procsdone[$mach,$i]=1
        fi
      done

      let z=0 
      for i in  `seq 1 ${procpmach[$mach]}` ; do
        let z=z+${procsdone[$mach,$i]}
      done
      if [[ $z ==  ${procpmach[$mach]} ]] ; then
        let totdone[$mach]=1
      fi
    fi
  done


  let k=0
  for  i in `seq 1 ${#machines[@]} ` ; do
    let k=$k+${totdone[$i]}
    if [[ $k == ${#machines[@]} ]] ; then
      let kk=$k
    fi
  done
done

let z=0

for mach in `seq 1 $nmach`; do
  for i in `seq 1 ${procpmach[$mach]}` ; do
    let z=$z+1
    FILE="$wdir/$i/objfnc.val"  
    ssh -t ${machines[$mach]} "echo $cat $FILE | grep "vals" " >> drutes.vals
  done
done

