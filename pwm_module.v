module pwm_module (input clock , input [7:0] pwm_control_register, input [15:0] pwm_period, input [15:0] pwm_pulse_width, output pwm_out);
	reg [15:0] counter = 16'd0;
	wire pwm_enable = pwm_control_register[0]; 
	always @ (posedge clock)
		counter <= (counter + pwm_enable) % pwm_period;
	assign pwm_out = pwm_enable & (pwm_pulse_width > counter )	;
endmodule

