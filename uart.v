// file:  uart.v - author: jok date 25-feb-2024

module uart (input clock,  input reset_n, output  tx, input  [7:0] tx_data, input write_new_tx_data, 
  input  [7:0] control_register, output  [7:0] status_register, input rx,  output reg [7:0] rx_data, 
  input read_last_rx_data);

// Note: signal "write_new_tx_data" must to be set during 
// write cyle to tx_data register and reset otherwise 

localparam CLOCK_FREQUENCY =  50000000 ;
   localparam BAUDRATE  = 9600 ;   // for production
// localparam BAUDRATE  = 9600000 ;  // for  simulation
localparam  BAUDRATEDIVIDER = ( CLOCK_FREQUENCY /  BAUDRATE ) ;
//TX
  reg [9:0]  tx_shift_register = 10'h3FF; 
  reg [15:0] baudrate_prescaler = 16'd0; 
  reg [3:0] tx_bitcount = 4'd0; 
  wire tbit_clock_enable; 
  wire tx_enable ; 
  reg tx_busy = 1'b0; 
  reg [1:0] tx_state = 2'b00;
  localparam TX_IDLE_STATE = 3'b00;  
  localparam TX_LOAD_STATE = 3'b01;
  localparam TX_SHIFT_STATE = 3'b11;
  
//RX
  reg rx_busy = 1'b0; 
  reg rx_full = 1'b0; 
  reg [15:0] rx_baud_prescaler = 16'd0;
  reg [3:0] rx_bitcount = 4'd0;
  reg [9:0] rx_shift_register = 10'h000; 
  wire rx_enable ;
  wire rx_Tbit_clock_enable;

//TX
  assign tbit_clock_enable  = 
      (baudrate_prescaler == ( BAUDRATEDIVIDER - 1)) ? 1'b1 : 1'b0; 
  assign tx =  tx_shift_register[0] ; 
  assign tx_enable = control_register[0]; 
  assign  status_register = { 5'b00000, rx_busy, rx_full, tx_busy}; 
  
  always @ (posedge clock)  
  begin   
    baudrate_prescaler <= 
       ( baudrate_prescaler +  tx_enable ) % BAUDRATEDIVIDER  ; 
    case ( tx_state )  
    	TX_IDLE_STATE : 
    		if(  write_new_tx_data &  tx_enable) begin 
    			tx_state <= TX_LOAD_STATE ; 
         		tx_bitcount  <= 4'd0;  
         		tx_busy  <= 1'b1; 
         		baudrate_prescaler <= 16'd0; 
        	end
    	TX_LOAD_STATE : 
    		begin
    			tx_state <= TX_SHIFT_STATE ;
    	        	tx_shift_register <= {1'b1,tx_data,1'b0}; 
    		end
    	TX_SHIFT_STATE : begin 
		if   ( tbit_clock_enable && ( tx_bitcount < 10 ) ) begin
         		tx_bitcount  <=   tx_bitcount  + 1;
        		tx_shift_register <=  {1'b1,  tx_shift_register [9:1]};
      		end
		else if   ( tbit_clock_enable && ( tx_bitcount >= 10 ) ) begin
        		tx_busy  <= 1'b0; 
    			tx_state <= TX_IDLE_STATE ; 
 		end
 	end
 	default : tx_state <= TX_IDLE_STATE;
    endcase
  end
  //RX
	assign rx_enable = control_register[1]; 
	assign rx_Tbit_clock_enable  =  (rx_baud_prescaler == (BAUDRATEDIVIDER) / 2); 
	// rx_Tbit_clock_enable is active at the middle of T-bit 

  	always @ (posedge clock)  
  	begin
		rx_baud_prescaler <= ( rx_baud_prescaler + rx_enable ) % BAUDRATEDIVIDER; 
		if (read_last_rx_data) begin //must be set during read cycle of rx_data
			rx_full <= 1'b0; // last rx_data has been read
		end 
        	if (( ~  rx) & rx_enable & (~  rx_busy) & (~ rx_full)) begin
           		 rx_baud_prescaler <= 16'd0;
          		 rx_busy <= 1'b1; 
            		rx_bitcount <= 4'b0;
			rx_shift_register <= 10'h000; 
       		 end
        	if (rx_busy && rx_Tbit_clock_enable) begin
        		rx_bitcount <= rx_bitcount + 1;
           		rx_shift_register <= {rx, rx_shift_register[9:1]};   
           	end	
            	if (rx_bitcount == 4'd10) begin    
            		rx_busy <= 1'b0;
                	rx_data <= rx_shift_register[8:1]; 
                	rx_full <= 1'b1; // rx_data ready to be read. 
                	rx_bitcount <= 4'd0;
            	end
 	    	if (~reset_n) begin
        		rx_busy <= 1'b0;
        		rx_full <= 1'b0; 
    	   	end 
    	end
endmodule
