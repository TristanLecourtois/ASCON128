`timescale 1ns/1ps
import ascon_pack::*;

module Pl_tb (
);



type_state Plin_s, Plout_so;

Pl DUT (
	.Pl_i(Plin_s),
	.Pl_o(Plout_so)
	);

	initial
		begin
			Plin_s[0] = 64'h78e2cc41faabaa1a;
			Plin_s[1] = 64'hbc7a2e775aababf7;
			Plin_s[2] = 64'h4b81c0cbbdb5fc1a;
			Plin_s[3] = 64'hb22e133e424f0250;
			Plin_s[4] = 64'h044d33702433805d;
			
		end
endmodule : Pl_tb

