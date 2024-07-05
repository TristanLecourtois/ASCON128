`timescale 1ns/1ps

import ascon_pack::*;

module substitution(
	input type_state sub_i, 
	output type_state sub_o
);


genvar i;
generate
	for (i=0 ; i < 64 ; i++)
		begin: label1
			sbox s(
			.sbox_i({sub_i[0][i],sub_i[1][i],sub_i[2][i],sub_i[3][i],sub_i[4][i]}),
			.sbox_o({sub_o[0][i],sub_o[1][i],sub_o[2][i],sub_o[3][i],sub_o[4][i]})
			);
		end
endgenerate

endmodule : substitution
