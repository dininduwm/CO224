1. Compile
      iverilog -o testbenchCPU.out testbenchCPU.v

2. Run
      vvp testbenchCPU.out

3. Open with gtkwave tool (without formating)
      gtkwave cpu_wavedata.vcd

4. Open with gtkwave tool (with formating)
      gtkwave format.gtkw


Code Shown In the testbenchCPU

loadi 0 0x0A
loadi 3 0x1E
loadi 1 0x05
add 0 0 1
beq 0x01 0 3
j 0xFD