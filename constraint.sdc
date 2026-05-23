create_clock -name clk -period 10 [get_ports clk]

set_clock_transition 0.1 [get_clocks clk]

set_clock_uncertainty 0.01 [get_clocks clk]

set_input_delay 1.0 -clock clk [get_ports A]
set_input_delay 1.0 -clock clk [get_ports B]
set_input_delay 1.0 -clock clk [get_ports opcode]

set_output_delay 1.0 -clock clk [get_ports result]
set_output_delay 1.0 -clock clk [get_ports carry]
set_output_delay 1.0 -clock clk [get_ports zero]
