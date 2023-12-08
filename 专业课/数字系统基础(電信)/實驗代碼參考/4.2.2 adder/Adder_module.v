module Adder_module
(
	a, b, c_in, s, c_out
);

	 input wire a;
	 input wire b;
	 input wire c_in;
	 output wire s;
	 output wire c_out;

	assign s =  c_in ^ a ^ b ;
	assign c_out = (a & b) | (c_in & (a ^ b));

endmodule 