module timer #(parameter CLOCK_FREQUENCY = 50000000) 
(input clock, input [7:0] control_register, output reg [31:0] millisec_counter );

localparam CLOCK_PER_MS = CLOCK_FREQUENCY/1000;   

reg [15:0] ms_prescaler = 16'd0;

wire timer_enable; 
wire timer_reset; 
wire  ms_timer_enable ; 

assign timer_enable = control_register[0]; 
assign timer_reset = control_register[1]; 

assign ms_timer_enable = ( ms_prescaler == (CLOCK_PER_MS - 1)   )  ? 1 : 0; 
always @(posedge clock) 
	ms_prescaler = timer_reset? 0 : (ms_prescaler + timer_enable) % CLOCK_PER_MS; 
always @(posedge clock) 
	millisec_counter = timer_reset? 0 : (millisec_counter + ms_timer_enable) ; 

endmodule
