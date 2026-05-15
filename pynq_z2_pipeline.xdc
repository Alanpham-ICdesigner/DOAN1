## ============================================================
## PYNQ-Z2 XDC for top_pynq_pipeline
##
## Top ports:
##   input  sysclk
##   input  btn[3:0]
##   output led[3:0]
## ============================================================


## ============================================================
## Clock 125 MHz - PYNQ-Z2 sysclk
## ============================================================

set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { sysclk }]
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0 4} [get_ports { sysclk }]


## ============================================================
## Push Buttons
##
## BTN0: reset
## BTN1: CPU input i_io_sw[0]
## BTN2: CPU input i_io_sw[1]
## BTN3: CPU input i_io_sw[2]
## ============================================================

set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]
set_property -dict { PACKAGE_PIN L20 IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]
set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]


## ============================================================
## User LEDs
##
## led[0] <- o_io_ledr[0]
## led[1] <- o_io_ledr[1]
## led[2] <- o_io_ledr[2]
## led[3] <- o_io_ledr[3]
## ============================================================

set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports { led[0] }]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { led[1] }]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { led[2] }]
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { led[3] }]