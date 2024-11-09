// The final comment?

//module keyboard(PS2_DAT, PS2_CLK, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, CLOCK_50);
//    input PS2_DAT, PS2_CLK, CLOCK_50;
//	 input [1:0] KEY;
//    output reg [9:0] LEDR;
//    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//
////    localparam	W = 8'b00011101,
////					A = 8'b00011100,
////					S = 8'b00011011,
////               D = 8'b00100011,
////               X = 8'b00100010,
////					STOP = 8'b11110000;
//	
//	 localparam	W = 8'b00010111,
//					A = 8'b00000111,
//					S = 8'b00011011,
//               D = 8'b10001000,
//               X = 8'b10011000,
//					STOP = 8'b11110001;
//    
//    reg [10:0] data = 11'b00000000000;
//    reg [7:0] keyData;
//	 reg [3:0] counter = 4'b0000;
//	 reg buttonJustReleased = 0;
//	 reg [7:0] signal = 8'b00000000;
//	 reg otherSignal = 0;
//	 reg [7:0] jump;
//	 reg [7:0] stopSignal = 8'b00000000;
//	 reg executeCaseBlock = 1;
//	 reg stop;
//	 
//    always@(negedge PS2_CLK) begin
//        data <= data << 1;
//        data[0] <= PS2_DAT;
//		  counter <= counter + 1;
//		  if (counter == 4'b1011) begin
//				counter <= 4'b0001;
//		  end
//    end
//
//    hex_decoder display1(keyData[7:4], HEX0);
//    hex_decoder display2(keyData[3:0], HEX1);
//	 hex_decoder display3(data[9:6], HEX2);
//    hex_decoder display4(data[5:2], HEX3);
//	 hex_decoder display5(data[7:4], HEX4);
//    hex_decoder display6(data[3:0], HEX5);
//
//    always@(*) begin
////		  jump <= counter;
////		  if (KEY[0] == 1) begin
////				LEDR[0] <= 0;
////				LEDR[1] <= 0;
////				LEDR[2] <= 0;
////				LEDR[3] <= 0;
////				LEDR[4] <= 0;
////		  end
//		  if (counter == 4'b1011) begin
////				signal <= signal + 1;
////				if (buttonJustReleased == 0) begin
////					keyData <= data[8:1];
////					executeCaseBlock <= 1;
////				end
////				else begin
////					buttonJustReleased <= 0;
////					executeCaseBlock <= 0;
////				end
//				keyData <= data[8:1];
//		  end
////		  if (executeCaseBlock) begin
//			  case(keyData)
////					W: begin
////						LEDR[3] <= 1;
////					end
////					A: begin
////						 LEDR[2] <= 1;
////					end
//					S: begin
////						 LEDR[1] <= 1;
//						 LEDR[0] <= 0;
//						 LEDR[1] <= 0;
//						 LEDR[2] <= 0;
//						 LEDR[3] <= 0;
//						 LEDR[4] <= 0;
//					end
////					D: begin
////						 LEDR[0] <= 1;
////					end
////					X: begin
////						 LEDR[4] <= 1;
////						 LEDR[5] <= 0;
////					end
//					STOP: begin
//						 LEDR[0] <= 0;
//						 LEDR[1] <= 0;
//						 LEDR[2] <= 0;
//						 LEDR[3] <= 0;
//						 LEDR[4] <= 0;
//						 LEDR[5] <= 1;
//						 LEDR[7:0] <= keyData;
//					end
//					default: begin
//						 LEDR[9] <= 1;
//						 LEDR[0] <= 0;
//						 LEDR[1] <= 0;
//						 LEDR[2] <= 0;
//						 LEDR[3] <= 0;
//						 LEDR[4] <= 0;
//					end
//			  endcase
////		  end
////    end
////	 
////	 always@(*) begin
////		if (KEY[0] == 0) begin
////			 LEDR[0] <= 0;
////			 LEDR[1] <= 0;
////			 LEDR[2] <= 0;
////			 LEDR[3] <= 0;
////			 LEDR[4] <= 0;
////		end
//	 end
//
//endmodule


module finalProject(CLOCK_50, PS2_DAT, PS2_CLK, KEY, LEDR, HEX0, HEX1);
    inout PS2_DAT, PS2_CLK;
	 input [1:0] KEY;
	 input CLOCK_50;
	 output reg [9:0] LEDR;
	 
	 output [6:0] HEX0, HEX1;
	 
    reg up, down, left, right, select, test, test2, test3;
    

    localparam	W = 8'b00011101,
					A = 8'b00011100,
					S = 8'b00011011,
               D = 8'b00100011,
               X = 8'b00100010,
					STOP = 8'b11110000;
    
    wire [7:0] data;
    wire [15:0] keyData;
	 reg [13:0] counter = 0;
	 reg justReleasedKey = 0;
	 reg enableSignal = 0;
	 reg commandSignal = 0;
	 
	 wire enableThing;
	 wire commandThing;
	 
	 reg [7:0] previousData;
	 reg stopFlag;
	 	 
	 //assign LEDR[8] = test3;
	 //assign LEDR[7] = test2;p
	 //assign LEDR[6] = test;
	 //assign LEDR[5] = up;
	 //assign LEDR[4] = down;
	 //assign LEDR[3] = left;
	 //assign LEDR[2] = right;
	 //assign LEDR[1] = select;
//	 assign LEDR[0] = 1;
	 
		 PS2_Controller uo(
	.CLOCK_50(CLOCK_50),
	.reset(~KEY[0]),

	.PS2_DAT(PS2_DAT),
	.PS2_CLK(PS2_CLK),

	.received_data(data),

	.received_data_en(enableThing),
	.command_was_sent(commandThing)
	);
	 
    shiftRegister storage(CLOCK_50, ~KEY[0], data, keyData);
	 
	 /*
	 always@ (negedge PS2_CLK) begin
		counter <= counter + 1;
		if (counter == 16384) begin
			test <= ~test;
			counter <= 0;
		end
	 end
	 
	 
	 always@ (negedge PS2_CLK) begin
			test2 <= 1;
	 end
	 
	 always@ (negedge PS2_CLK) begin
			test3 <= 0;
	 end
	 */
	 
    always@ (*) begin
        //keyData = data[8:1];
//		  if (enableThing || commandThing)
//				justReleasedKey <= 0;
//			if (enableThing)
//				enableSignal <= 0;
//			if (commandThing)
//				commandSignal <= 0;
//        case(keyData[15:8])
        case(data)
				W: begin
					LEDR[5] <= 1;
            end
            A: begin
					LEDR[3] <= 1;
            end
            S: begin
					LEDR[4] <= 1;
            end
            D: begin
					LEDR[2] <= 1;
				end
            X: begin
					LEDR[1] <= 1;
            end
				STOP: begin
					 LEDR[1] <= 0;
					 LEDR[2] <= 0;
					 LEDR[3] <= 0;
					 LEDR[4] <= 0;
					 LEDR[5] <= 0;
//					 justReleasedKey <= 1;
					 previousData <= STOP;
//					 stopFlag  <= 1;
				end
            default: begin
					 LEDR[1] <= 0;
					 LEDR[2] <= 0;
					 LEDR[3] <= 0;
					 LEDR[4] <= 0;
					 LEDR[5] <= 0;
					 justReleasedKey <= 1;
					 enableSignal <= 1;
					 commandSignal <= 1;
				end
        endcase
    end
	 
	 hex_decoder display1(data[7:4], HEX1);
	 hex_decoder display2(data[3:0], HEX0);
//	 hex_decoder display3(previousData[7:4], HEX3);
//	 hex_decoder display4(previousData[3:0], HEX2);

endmodule



module shiftRegister(clock, reset, dataIn, dataOut);
    input clock;
	 input reset;
	 input [7:0] dataIn;
	 
    output reg [15:0] dataOut;

    always@ (posedge clock) begin
        if(reset)
		      dataOut <= 16'h0000;
		  else
		      dataOut <= {dataOut[7:0], dataIn};
        //dataOut[0] <= dataIn;
    end

endmodule


module hex_decoder(c, display);
    input [3:0] c;
    output [6:0] display;
	 
    assign display[0] = !((c[3] | c[2] | c[1] | !c[0]) & (!c[3] | !c[2] | c[1] | !c[0]) & (!c[3] | c[2] | !c[1] | !c[0]) & (c[3] | !c[2] | c[1] | c[0]));
    assign display[1] = !((c[3] | !c[2] | c[1] | !c[0]) & (c[3] | !c[2] | !c[1] | c[0]) & (!c[3] | c[2] | !c[1] | !c[0]) & (!c[3] | !c[2] | c[1] | c[0])& (!c[3] | !c[2] | !c[1] | c[0])& (!c[3] | !c[2] | !c[1] | !c[0]));
    assign display[2] = !((c[3] | c[2] | !c[1] | c[0]) & (!c[3] | !c[2] | c[1] | c[0]) & (!c[3] | !c[2] | !c[1] | c[0]) & (!c[3] | !c[2]  | !c[1] | !c[0]));
    assign display[3] = !((c[3] | c[2] | c[1] | !c[0]) & (c[3] | !c[2] | c[1] | c[0]) & (c[3] | !c[2] | !c[1]  | !c[0]) & (!c[3] | c[2] | !c[1] | c[0]) & (!c[3] | !c[2] | !c[1] | !c[0]));
    assign display[4] = !((c[3] | c[2] | c[1] | !c[0]) & (c[3] | c[2] | !c[1] | !c[0]) & (c[3] | !c[2] | c[1] | c[0]) & (c[3] | !c[2] | c[1] | !c[0]) & (c[3] | !c[2] | !c[1] | !c[0]) & (!c[3] | c[2] | c[1] | !c[0]));
    assign display[5] = !((c[3] | c[2] | c[1] | !c[0]) & (c[3] | c[2] | !c[1] | !c[0]) & (c[3] | !c[2] | !c[1] | !c[0]) & (!c[3] | !c[2] | c[1] | !c[0]) & (c[3] | c[2] | !c[1] | c[0]));
    assign display[6] = !((c[3] | c[2] | c[1] | c[0]) & (c[3] | c[2] | c[1] | !c[0]) & (c[3] | !c[2] | !c[1] | !c[0]) & (!c[3] | !c[2] | c[1] | c[0]));
   
endmodule
