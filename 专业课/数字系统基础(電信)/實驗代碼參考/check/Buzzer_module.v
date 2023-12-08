module Buzzer_module
(
	CLK, RSTn, Buzzer_Out, Key_In, LED_Out
);
	input CLK;
	input RSTn;
	output Buzzer_Out;
	input [7:0]Key_In;
	output [7:0]LED_Out;
	
	//50M 各音调的频率
	parameter Do = 17'd95419, Re = 17'd85034, Mi = 17'd75757, Fa = 17'd71633, Sol = 17'd63775 , La = 17'd56818, Si = 17'd50607;
	
   reg [22:0]Count1;
   reg [22:0]Pulse_x;
	reg [6:0]R_Key;
	reg W_buzzer;
	
   always @ ( posedge CLK )
		begin
			if( (Pulse_x == Do) | (Pulse_x == Re) | (Pulse_x == Mi) | (Pulse_x == Fa) | (Pulse_x == Sol) | (Pulse_x == La) | (Pulse_x == Si) )
				begin
					if( Count1 == Pulse_x )
						begin
							Count1 <= 23'd0;
							W_buzzer <= ~W_buzzer;
						end
					else 
						Count1 <= Count1 + 1'b1;
				end
			else 
				begin
					W_buzzer <= 1'b1;
					Count1 <= 23'd0;
				end
				
			case(Key_In)
				8'b1111_1110: Pulse_x <= Do;
				8'b1111_1101: Pulse_x <= Re;
				8'b1111_1011: Pulse_x <= Mi;
				8'b1111_0111: Pulse_x <= Fa;
				8'b1110_1111: Pulse_x <= Sol;
				8'b1101_1111: Pulse_x <= La;
				8'b1011_1111: Pulse_x <= Si;
				default: Pulse_x <= 20000;
			endcase
		end	
		
	assign Buzzer_Out = W_buzzer;
	//assign R_Key = Key_In;
	assign LED_Out = {Key_In};
	
endmodule