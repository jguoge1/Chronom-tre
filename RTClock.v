`define CLKFREQ 50000000
module RTClock (
    input wire clk,       // Horloge 50MHz
    input wire wr,	// write enable
    input [31:0] hhmmss, // 24 bit : HH (8bit) MM (8 bit) SS(8 bit)
    output reg [7:0] seconds,
    output reg [7:0] minutes,
    output reg [7:0] hours
);

    reg [25:0] counter ; // Compteur pour générer une seconde (50MHz / 1Hz)
 
    always @(posedge clk) begin 
    	if (wr)	begin {hours,minutes,seconds} = hhmmss ; counter <= 32'd0; end
    	else begin
    		counter <= (counter + 1) % `CLKFREQ; 
    		if (counter == `CLKFREQ - 1) begin
    			seconds <= (seconds + 1) % 60;
    			if (seconds == 59) begin 
    				minutes <= (minutes + 1) % 60;
    				if(minutes == 59)  
    					hours <= (hours + 1) % 24;
    			end
    		end
    	end
    end				
endmodule

