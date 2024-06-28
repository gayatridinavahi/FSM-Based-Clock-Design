vlib work
vdel -all
vlib work

vlog -f $1 +acc -sv
vsim work.tb
#add wave -r * //uncomment for first time simulation.
do wave.do  //comment for first-time simulation.
run -all
