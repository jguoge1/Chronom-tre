//tb_sys_picorv32.v

`timescale 1 ns / 100 ps
`define FCLOCK 50000000
`define BAUDRATE 9600
`define TCLOCKPERTBIT (`FCLOCK/`BAUDRATE)

module tb_sys_picorv32;
	reg clk = 1;
	reg resetn = 0;
	wire  [7:0] LEDR;
    reg   [7:0] SW = 8'h00; 

    wire [6:0]hex0; 
    wire [6:0]hex1; 
    wire [6:0]hex2; 
    wire [6:0]hex3; 
    wire [6:0]hex4; 
    wire [6:0]hex5; 
    reg rx = 1'b1;;
    wire tx ;
    reg [8*16-1:0] message_buffer = "Hello, World!   ";
    integer bytenum, bitnum;
    
	system_picorv32 dutsys (
		. sys_clk  (clk        ),
		.sys_resetn      (resetn     ), 
		. LEDR (LEDR) ,
		.SW (SW),
		.hex0(hex0),
		.hex1(hex1),
		.hex2(hex2),
		.hex3(hex3),
		.hex4(hex4),
		.hex5(hex5),
		.tx(tx), 
		.rx(rx)
	);
	
	always #10 clk = ~clk; // 50MHz system clock

	initial begin
		$dumpfile("tb_sys_picorv32.vcd");
		$dumpvars(0, tb_sys_picorv32 );
		resetn <= 1;
		repeat (2) @(posedge clk);
		resetn <= 0;
		repeat (2) @(posedge clk);
		resetn <= 1;
		repeat (`TCLOCKPERTBIT) @(posedge clk);
/*
		for (bytenum = 15; bytenum >0; bytenum = bytenum - 1)  begin
			rx <= 1'b0; //start 
			repeat (`TCLOCKPERTBIT) @(posedge clk);
			for (bitnum = 0; bitnum<8; bitnum = bitnum+1) begin
				rx <= message_buffer[bytenum*8+bitnum]; 
				repeat (`TCLOCKPERTBIT) @(posedge clk);
			end
			rx <= 1'b1; //stop 
			repeat (2*`TCLOCKPERTBIT) @(posedge clk);
			repeat (8*`TCLOCKPERTBIT) @(posedge clk);
		end 	
*/	
	$finish;
	end
	
	always @(posedge clk) begin
		if (dutsys.cpu_rw_cycle && dutsys.sys_rw_is_done) begin
			if (dutsys.cpu_instr_fetch)
				$display("ifetch 0x%08x: 0x%08x", dutsys.cpu_address, dutsys.cpu_read_data);
			else if (dutsys.cpu_write_strobe)
				$display("write  0x%08x: 0x%08x (wstrb=%b)",dutsys.cpu_address,dutsys.cpu_write_data, dutsys.cpu_write_strobe);
			else
				$display("read   0x%08x: 0x%08x", dutsys.cpu_address, dutsys.cpu_read_data);
		end
	end
endmodule
