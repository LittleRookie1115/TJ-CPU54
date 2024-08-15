@echo off
set xv_path=F:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 506e5326c25d4aa9b9fc87187288b92c -m64 --debug typical --relax --mt 2 -L dist_mem_gen_v8_0_10 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot CPU_tb_behav xil_defaultlib.CPU_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
