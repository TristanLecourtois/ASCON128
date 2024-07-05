`timescale 1ns/1ps
import ascon_pack::*;

module substitution_tb
(
);

type_state psout_s, psin_s;

substitution DUT(
	.sub_o(psout_s),
	.sub_i(psin_s)
);

initial 
	begin
		psin_s[0] = 64'h80400c0600000000;
		psin_s[1] = 64'h8a55114d1cb6a9a2;
		psin_s[2] = 64'hbe263d4d7aecaa0f;
		psin_s[3] = 64'h4ed0ec0b98c529b7;
		psin_s[4] = 64'hc8cddf37bcd0284a;

		#10;
	end
endmodule : substitution_tb
