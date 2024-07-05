
`timescale 1 ns /1 ps
import ascon_pack::*;


module sbox_tb();

	logic[0:4] sbox_i_s;
	logic[0:4] sbox_o_s;

	sbox sbox_DUT(
		.sbox_i(sbox_i_s),
		.sbox_o(sbox_o_s) );

initial
begin
	sbox_i_s = 8'h1F;
	#10;
end 

endmodule : sbox_tb
