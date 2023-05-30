#!/bin/bash
source vivado_version.sh

xvlog -sv design/calc.sv design/fsm.sv design/fib.sv tb/tb.sv
xelab -s fib tb -timescale 1ns/1ps
xsim fib -runall 

