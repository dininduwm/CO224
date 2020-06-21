1. Compile
      iverilog -o testbenchCPU.out testbenchCPU.v

2. Run
      vvp testbenchCPU.out

3. Open with gtkwave tool (without formating)
      gtkwave cpu_wavedata.vcd

4. Open with gtkwave tool (with formating)
      gtkwave format.gtkw


Code Shown In the testbenchCPU

loadi 0 0xFA
sll 1 0 0x02
srl 1 0 0x02
sra 1 0 0x02
ror 1 0 0x02
loadi 2 0x05
loadi 3 0x0A
mul 4 2 3
loadi 0 0x0A
swi 0 0X03
lwi 1 0X03
loadi 2 0X03
loadi 3 0xAA
swd 3 2
lwd 4 2

Note:
I have resubmitted this module because in the last lab session we have to change the ALU module because of the triggering issue
