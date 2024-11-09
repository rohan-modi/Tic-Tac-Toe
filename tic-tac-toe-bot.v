// Tic Tac Toe Comment

// module TicTacToe(SW, KEY, playerWon, computerWon, gameDraw, LEDR, HEX5, HEX4, HEX3);

module TicTacToe(SW, KEY, LEDR, HEX5, HEX4, HEX3, CLOCK_50);
	input [8:0] SW;
	input [1:0] KEY;
	input CLOCK_50;

//	input [3:0] userSquare;
//	input squareEntered;
	
//	output playerWon, computerWon, gameDraw;
	output reg [8:0] LEDR;
	output [6:0] HEX5, HEX4, HEX3;

	wire [3:0] computerMove;
	reg [8:0] XSpots = 9'b000000000;
	reg [8:0] OSpots = 9'b000000000;
	
//	wire [8:0] state;
	
	wire playerWon;
	wire computerWon;
	wire gameDraw;
	
//	always@(posedge squareEntered) begin
//		XSpots[userSquare] <= 1;
//	end
//		
	moveMaker bot(XSpots, OSpots, KEY[0], computerMove, playerWon, computerWon, gameDraw/*, state*/, CLOCK_50);
	
	always@ (KEY[0]) begin
		XSpots <= SW;
	
	end
	
	always@(computerMove) begin
		OSpots[computerMove] <= 1;
		LEDR <= OSpots;
	end
	
	hex_decoder playerDisplay(playerWon, HEX5);
	hex_decoder computerDisplay(computerWon, HEX4);
	hex_decoder tieGameDisplay(gameDraw, HEX3);


endmodule


module moveMaker(Xs, Os, userMoved, computerMove, playerWon, computerWon, gameDraw/*, currentState*/, clock);
    input userMoved;
    input [8:0] Xs, Os;
	 input clock;

	 output reg playerWon = 0;
	 output reg computerWon = 0;
	 output reg gameDraw = 0;
	 
    output reg [3:0] computerMove;

    localparam  BOARD_EMPTY = 4'b0000,
                PLAYER_WON = 4'b0001,
                COMPUTER_WON = 4'b0010,
                MOVE_RANDOM = 4'b0011,
                END0 = 4'b0100,
                END1 = 4'b0101,
                END2 = 4'b0110,
                END3 = 4'b0111,
                END4 = 4'b1000,
                END5 = 4'b1001,
                END6 = 4'b1010,
                END7 = 4'b1011,
                END8 = 4'b1100,
                USER_MOVE = 4'b1101,
                GAME_DRAW = 4'b1110;
					 
	 /*output*/ reg [8:0] currentState;
	 reg [8:0] nextState;

    always@ (*) begin
        if (( Xs[8] && Xs[7] && Xs[6] ) || ( Xs[5] && Xs[4] && Xs[3] ) || ( Xs[2] && Xs[1] && Xs[0] ) || ( Xs[8] && Xs[5] && Xs[2] ) || ( Xs[7] && Xs[4] && Xs[1] ) || ( Xs[6] && Xs[3] && Xs[0] ) || ( Xs[8] && Xs[4] && Xs[0] ) || ( Xs[6] && Xs[4] && Xs[2] ))
            nextState <= PLAYER_WON;
        else if ( ( Os[8] && Os[7] && Os[6] ) || ( Os[5] && Os[4] && Os[3] ) || ( Os[2] && Os[1] && Os[0] ) || ( Os[8] && Os[5] && Os[2] ) || ( Os[7] && Os[4] && Os[1] ) || ( Os[6] && Os[3] && Os[0] ) || ( Os[8] && Os[4] && Os[0] ) || ( Os[6] && Os[4] && Os[2] ))
            nextState <= COMPUTER_WON;
        else if ( (Xs[0] || Os[0]) && (Xs[1] || Os[1]) && (Xs[2] || Os[2]) && (Xs[3] || Os[3]) && (Xs[4] || Os[4]) && (Xs[5] || Os[5]) && (Xs[6] || Os[6]) && (Xs[7] || Os[7]) && (Xs[8] || Os[8]) )
            nextState <= GAME_DRAW;
        else if ( (( Os[7] && Os[6] ) || ( Os[5] && Os[2] ) || ( Os[4] && Os[0] )) && !Os[8] && !Xs[8] ) // Corner
            nextState <= END0;
        else if ( (( Os[8] && Os[6] ) || ( Os[1] && Os[4] )) && !Os[7] && !Xs[7] ) // Edge
            nextState <= END1;
        else if ( (( Os[7] && Os[8] ) || ( Os[0] && Os[3] ) || ( Os[4] && Os[2] )) && !Os[6] && !Xs[6] )
            nextState <= END2;
        else if ( (( Os[8] && Os[2] ) || ( Os[3] && Os[4] )) && !Os[5] && !Xs[5] )
            nextState <= END3;
        else if ( (( Os[8] && Os[0] ) || ( Os[2] && Os[6] ) || ( Os[5] && Os[3] ) || ( Os[1] && Os[7] )) && !Os[4] && !Xs[4] )
            nextState <= END4;
        else if ( (( Os[0] && Os[6] ) || ( Os[5] && Os[4] )) && !Os[3] && !Xs[3] )
            nextState <= END5;
        else if ( (( Os[5] && Os[8] ) || ( Os[1] && Os[0] ) || ( Os[4] && Os[6] )) && !Os[2] && !Xs[2] )
            nextState <= END6;
        else if ( (( Os[2] && Os[0] ) || ( Os[7] && Os[4] )) && !Os[1] && !Xs[1] )
            nextState <= END7;
        else if ( (( Os[2] && Os[1] ) || ( Os[3] && Os[6] ) || ( Os[4] && Os[8] )) && !Os[0] && !Xs[0] )
            nextState <= END8;
        else if ( (( Xs[7] && Xs[6] ) || ( Xs[5] && Xs[2] ) || ( Xs[4] && Xs[0] )) && !Xs[8] ) // Switch symbol
            nextState <= END0;
        else if ( (( Xs[8] && Xs[6] ) || ( Xs[1] && Xs[4] )) && !Xs[7] && !Os[7] )
            nextState <= END1;
        else if ( (( Xs[7] && Xs[8] ) || ( Xs[0] && Xs[3] ) || ( Xs[4] && Xs[2] )) && !Xs[6] && !Os[6] )
            nextState <= END2;
        else if ( (( Xs[8] && Xs[2] ) || ( Xs[3] && Xs[4] )) && !Xs[5] && !Os[5] )
            nextState <= END3;
        else if ( (( Xs[8] && Xs[0] ) || ( Xs[2] && Xs[6] ) || ( Xs[5] && Xs[3] ) || ( Xs[1] && Xs[7] )) && !Xs[4] && !Os[4] )
            nextState <= END4;
        else if ( (( Xs[0] && Xs[6] ) || ( Xs[5] && Xs[4] )) && !Xs[3] && !Os[3] )
            nextState <= END5;
        else if ( (( Xs[5] && Xs[8] ) || ( Xs[1] && Xs[0] ) || ( Xs[4] && Xs[6] )) && !Xs[2] && !Os[2] )
            nextState <= END6;
        else if ( (( Xs[2] && Xs[0] ) || ( Xs[7] && Xs[4] )) && !Xs[1] && !Os[1] )
            nextState <= END7;
        else if ( (( Xs[2] && Xs[1] ) || ( Xs[3] && Xs[6] ) || ( Xs[4] && Xs[8] )) && !Xs[0] && !Os[0] )
            nextState <= END8;
        else if (Xs == 9'b0 && Os == 9'b0)
            nextState <= BOARD_EMPTY;
        else
            nextState <= MOVE_RANDOM;
//    end
//	 
//    always@ (*) begin
        case(currentState)
            BOARD_EMPTY: begin
					nextState <= USER_MOVE;
				end
            PLAYER_WON: begin
                playerWon <= 1;
                nextState <= PLAYER_WON;
            end
            COMPUTER_WON: begin
                computerWon <= 1;
                nextState <= COMPUTER_WON;
            end
            MOVE_RANDOM: begin
                if ( Xs[0] == 0 && Os[0] == 0 ) begin
							computerMove <= 4'b0000;
					 end
                else if ( !Xs[1] && !Os[1] ) begin
                    computerMove <= 4'b0001;
					 end
                else if ( !Xs[2] && !Os[2] ) begin
                    computerMove <= 4'b0010;
                end else if ( !Xs[3] && !Os[3] ) begin
                    computerMove <= 4'b0011;
                end else if ( !Xs[4] && !Os[4] ) begin
                    computerMove <= 4'b0100;
                end else if ( !Xs[5] && !Os[5] ) begin
                    computerMove <= 4'b0101;
                end else if ( !Xs[6] && !Os[6] ) begin
                    computerMove <= 4'b0110;
                end else if ( !Xs[7] && !Os[7] ) begin
                    computerMove <= 4'b0111;
                end else if ( !Xs[8] && !Os[8] ) begin
                    computerMove <= 4'b1000;
					 end
                nextState <= USER_MOVE;
            end
            END0: begin
					 computerMove <= 4'b1000;
                if ( (Os[5] && Os[2]) || (Os[6] && Os[7]) || (Os[4] && Os[0]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END1: begin
					 computerMove <= 4'b0111;
                if ( (Os[8] && Os[6]) || (Os[4] && Os[1]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END2: begin
					 computerMove <= 4'b0110;
                if ( (Os[8] && Os[7]) || (Os[2] && Os[4]) || (Os[0] && Os[3]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END3: begin
					 computerMove <= 4'b0101;
                if ( (Os[8] && Os[2]) || (Os[4] && Os[3]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END4: begin
					 computerMove <= 4'b0101;
                if ( (Os[8] && Os[0]) || (Os[2] && Os[6]) || (Os[3] && Os[5]) || (Os[7] && Os[1]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END5: begin
					 computerMove <= 4'b0011;
                if ( (Os[0] && Os[6]) || (Os[4] && Os[5]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END6: begin
					 computerMove <= 4'b0010;
                if ( (Os[4] && Os[6]) || (Os[8] && Os[5]) || (Os[1] && Os[0]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END7: begin
					 computerMove <= 4'b0001;
                if ( (Os[2] && Os[0]) || (Os[4] && Os[7]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            END8: begin
					 computerMove <= 4'b0000;
                if ( (Os[4] && Os[8]) || (Os[2] && Os[1]) || (Os[3] && Os[6]) )
                    nextState <= COMPUTER_WON;
                else
                    nextState <= USER_MOVE;
            end
            USER_MOVE: nextState <= USER_MOVE;
            GAME_DRAW: begin
                gameDraw <= 1;
                nextState <= GAME_DRAW;
            end
            default: nextState <= MOVE_RANDOM;
        endcase
    end
	 
	 always@ (posedge clock) begin
		currentState <= nextState;
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
