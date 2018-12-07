#!/bin/bash



dp[1]=0.0005
dp[2]=0.2
dp[3]=0.2
dp[4]=0.2
dp[5]=0.1

minval[1]=0.00001
minval[2]=1.15
minval[3]=0
minval[4]=0
minval[5]=0

for i in `seq 1 ${#dp[@]}`; do
  dpinit[$i]=${dp[$i]}
done


prec=1000000

nproc=16

npars=${#dp[@]}

declare -A pars

#count the number of peaks to evaluate
let nextr=1
while read l a b c d e ; do
    if [[  $l == "p"  ]]; then
      pars[$nextr,1]=$a
      pars[$nextr,2]=$b
      pars[$nextr,3]=$c
      pars[$nextr,4]=$d
      pars[$nextr,5]=$e
      let nextr=$nextr+1
    fi
done < pars4grad.in
  
let nextr=$nextr-1
  
rm -rf *-par.val
  
let run=0

for order in `seq 1 $nextr`; do
  for i in `seq 1 $npars` ; do
    initval=${pars[$order,$i]}
    let go=0
    while [[ $go < 1 ]] ; do
      while [[ $run -le $nproc ]] ; do
        pars[$order,$i]=`echo "scale=16; $initval+${dp[$i]}" | bc`
        let run=$run+1
        values2run[$run]=${pars[$order,$i]}
        if [[ $run == 1 ]]; then
          echo "p" ${pars[$order,1]} ${pars[$order,2]} ${pars[$order,3]}  ${pars[$order,4]} ${pars[$order,5]} > vals.in
        else
          echo "p" ${pars[$order,1]} ${pars[$order,2]} ${pars[$order,3]}  ${pars[$order,4]} ${pars[$order,5]} >> vals.in
        fi

        pars[$order,$i]=$initval
        
        if (( $(echo " `echo "scale=16;  $initval-${dp[$i]}" | bc ` > ${minval[$i]}" |bc -l) )); then
          
          pars[$order,$i]=`echo "scale=16; $initval-${dp[$i]}" | bc`
          echo "p" ${pars[$order,1]} ${pars[$order,2]} ${pars[$order,3]}  ${pars[$order,4]} ${pars[$order,5]} >> vals.in
          let run=$run+1
          values2run[$run]=${pars[$order,$i]}
          pars[$order,$i]=$initval
        fi
  

        dp[$i]=`echo "scale=16; ${dp[$i]}*0.90" | bc`
        if (( $(echo " `echo "scale=16; ${dp[$i]}*$prec" | bc ` < 1.0" |bc -l) )); then
          let go=2
        fi
    done
    
    
    ./rundru.sh  
      
    case $i in 
        1)
         name="alpha"
          ;;
        2)
          name="n"
          ;;
        3)
          name="ths"
          ;;
        4)
         name="Ks"
          ;;
        5)
         name="Ss"
          ;;
      esac
      
      let z=1
      
      while read -r line results[$z]
      do
        let z=$z+1
      done < drutes.vals
      
      for j in `seq 1 $run` ; do
        echo  ${values2run[$j]} ${results[$j]} >> $name-$order-par.val
      done
      
      let run=0
      
    done
  done
  for i in `seq 1 $npars`; do
    dp[$i]=${dpinit[$i]}
  done
done 
 
    

