# min_sys_riscv
Minimal system with RISC-V picorv32 : asm startup + c example + verilog system + testbench + Makefile

Includes intel-FPGA (quartus17) project and files for synthesis on DE10lite FPGA Board.

Status : 

simulation : ok 

synthesis : ok

Design for education purpose. 
From JOKlein, Dept GEii-1,IUT Cachan, Univ Paris-Saclay. 

# INSTRUCTIONS:
1. Install RISCV dev tools
   
   from  https://github.com/YosysHQ/picorv32
   
2. Install intel fpga quartus LITE edition
   
   from https://www.intel.com/content/www/us/en/software-kit/825278/intel-quartus-prime-lite-edition-design-software-version-23-1-1-for-windows.html
   
3. Check tools path in the makefile
   
   e.g. CC := /opt/riscv32i/bin/riscv32-unknown-elf-gcc
   
4. Compile the project
 
   > make clean
   
   > make
   
5. run intel-fpga quartus
    
   > ~/intelFPGA_lite/23.1std/quartus/bin/quartus &
   
  with quartus:
  
     File > open_project "quartus_mini_sys_riscv.qpf"
     
     Processing > Start_Compilation
     
   Connect the DE10Lite board to PC USB and connect FTDI USB-serial cable
   
     TX(FPGA) at GPIO35 to RX(PC) yellow, RX(FPGA) at ARDUINO_IO11 to TX(PC) orange, gnd to gnd (black). 
     
   launch Pragrammer and Start programming the device
   
   In a terminal :
   
   > sudo screen /dev/ttyUSB0

   try typing some things ...
   
   Leds count number of chars, Hex display their ASCII code and terminal should echo chars
   
   if not install the FTDI tools https://ftdichip.com/drivers
