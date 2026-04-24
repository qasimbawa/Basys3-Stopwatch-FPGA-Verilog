## CLOCK
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## SWITCHES
## mode[1:0] -> SW0, SW1
set_property PACKAGE_PIN V17 [get_ports {mode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode[0]}]

set_property PACKAGE_PIN V16 [get_ports {mode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode[1]}]

## preset[7:0] -> SW2 ... SW9
set_property PACKAGE_PIN V2 [get_ports {preset[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[0]}]

set_property PACKAGE_PIN T3 [get_ports {preset[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[1]}]

set_property PACKAGE_PIN T2 [get_ports {preset[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[2]}]

set_property PACKAGE_PIN R3 [get_ports {preset[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[3]}]

set_property PACKAGE_PIN W2 [get_ports {preset[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[4]}]

set_property PACKAGE_PIN U1 [get_ports {preset[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[5]}]

set_property PACKAGE_PIN T1 [get_ports {preset[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[6]}]

set_property PACKAGE_PIN R2 [get_ports {preset[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {preset[7]}]

## BUTTONS
## start_stop -> btnU
set_property PACKAGE_PIN T18 [get_ports start_stop]
set_property IOSTANDARD LVCMOS33 [get_ports start_stop]

## reset -> btnC
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## 7-SEGMENT SEGMENTS
## Your hexto7segment module uses:
## sseg[6]=a, sseg[5]=b, sseg[4]=c, sseg[3]=d, sseg[2]=e, sseg[1]=f, sseg[0]=g

set_property PACKAGE_PIN W7 [get_ports {sseg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[6]}]

set_property PACKAGE_PIN W6 [get_ports {sseg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[5]}]

set_property PACKAGE_PIN U8 [get_ports {sseg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[4]}]

set_property PACKAGE_PIN V8 [get_ports {sseg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[3]}]

set_property PACKAGE_PIN U5 [get_ports {sseg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[2]}]

set_property PACKAGE_PIN V5 [get_ports {sseg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[1]}]

set_property PACKAGE_PIN U7 [get_ports {sseg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[0]}]

## 7-SEGMENT ENABLES
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]

set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]

set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

## Decimal Point
set_property PACKAGE_PIN V7 [get_ports dp]
set_property IOSTANDARD LVCMOS33 [get_ports dp]
