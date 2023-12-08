module Digitron_NumDisplay
(
	CLK, RSTn, Data, Digitron_Out, DigitronCS_Out
);
	input CLK, RSTn;
	input [9:0]Data;
	
	output [7:0]Digitron_Out; 
	output [5:0]DigitronCS_Out;

	wire [23:0]Hex_SixNum;	
	assign Hex_SixNum = {14'b0,Data[9:0]};
		
   parameter T100MS = 16'd200;
	reg [7:0]Count;
	reg [3:0]SingleNum;
	reg [7:0]W_Digitron_Out;
	reg [7:0]W_DigitronCS_Out;
	parameter _0 = 8'b1100_0000, _1 = 8'b1111_1001, _2 = 8'b1010_0100,
			 	 _3 = 8'b1011_0000, _4 = 8'b1001_1001, _5 = 8'b1001_0010,
			 	 _6 = 8'b1000_0010, _7 = 8'b1111_1000, _8 = 8'b1000_0000,
				 _9 = 8'b1001_0000, _A = 8'b1000_1000, _B = 8'b1000_0011,
				 _C = 8'b1100_0110, _D = 8'b1010_0001, _E = 8'b1000_0110,
				 _F = 8'b1000_1110;
				 
	
	always @ ( posedge CLK or negedge RSTn )
		begin
			if( !RSTn )	
				Count <= 23'd0;
			else if( Count == T100MS )
				begin
					Count <= 23'd0;					 
					W_DigitronCS_Out = {W_DigitronCS_Out[0],W_DigitronCS_Out[5:1]};
					
					if(W_DigitronCS_Out==6'd0) 
						W_DigitronCS_Out = 6'b11_1110;
					 
					case(W_DigitronCS_Out)
						6'b11_1110: SingleNum = Hex_SixNum[3:0];
						6'b11_1101: SingleNum = Hex_SixNum[7:4];
						6'b11_1011: SingleNum = Hex_SixNum[11:8];
						6'b11_0111: SingleNum = Hex_SixNum[15:12];
						6'b10_1111: SingleNum = Hex_SixNum[19:16];
						6'b01_1111: SingleNum = Hex_SixNum[23:20];
					endcase
					 
					case(SingleNum)
						0:  W_Digitron_Out = _0;
						1:  W_Digitron_Out = _1;
						2:  W_Digitron_Out = _2;
						3:  W_Digitron_Out = _3;
						4:  W_Digitron_Out = _4;
						5:  W_Digitron_Out = _5;
						6:  W_Digitron_Out = _6;
						7:  W_Digitron_Out = _7;
						8:  W_Digitron_Out = _8;
						9:  W_Digitron_Out = _9;
						10: W_Digitron_Out = _A;
						11: W_Digitron_Out = _B;
						12: W_Digitron_Out = _C;
						13: W_Digitron_Out = _D;
						14: W_Digitron_Out = _E;
						15: W_Digitron_Out = _F;
					endcase
					
				end
			else
				Count <= Count + 1'b1;
	end
	
	
	assign Digitron_Out = ~W_Digitron_Out;
	assign DigitronCS_Out = W_DigitronCS_Out;
endmodule