#!/bin/bash

dsim design/calc.sv design/fsm.sv design/fib.sv tb/tb.sv -sv_seed random +acc+b -waves waves.mxd 
