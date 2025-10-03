#!/bin/bash

iverilog -o tb_test.o -s tb -g2005-sv tb/tb.sv design/calc.sv design/fsm.sv design/fib.sv
vvp tb_test.o 
