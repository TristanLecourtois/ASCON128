`timescale 1ns/1ps

import ascon_pack::*;


module P(
    	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	input logic select_i,
	input logic [3:0] round_i,
	input logic en_tag_i,
	input logic en_cipher_i,
	input logic [63 : 0] data_i,
//XOR begin
	input logic en_xor_key_b_i, 
	input logic en_xor_data_b_i,
//XOR end
	input logic en_xor_key_e_i,
	input logic en_xor_lsb_e_i,
//clé
	input logic [127 : 0] key_i, 
	input type_state state_i,

output logic [63 : 0] cipher_o,
output logic [127 : 0] tag_o,
output type_state state_o

	);

// signal intermédiaire
type_state pcout_s, psout_s,muxout_s,plout_s;
type_state  output_state_register_s;
type_state output_xor_begin_s;
type_state output_xor_end_s;

mux_state m(
	.data1_i(state_i),
	.data2_i(state_o),
	.sel_i(select_i),
	.data_o(muxout_s)
);


Pc pc(
	  .Pc_in_i(output_xor_begin_s),
	  .round_i(round_i),
	  .Pc_out_o(pcout_s)
);

substitution ps(
	  .sub_i(pcout_s),
	  .sub_o(psout_s)
);


Pl pl(
	  .Pl_i(psout_s),
	  .Pl_o(plout_s)
);


xor_end_perm xor_end
(
	.en_xor_lsb_i(en_xor_data_b_i),
    	.en_xor_key_i(en_xor_key_b_i),
	.key_i(key_i),
	.state_i(plout_s),
	.state_o(output_xor_end_s)
	

);

xor_begin_perm xor_begin(
    .en_xor_data_i(en_xor_data_b_i),
    .en_xor_key_i(en_xor_key_b_i),
    .key_i(key_i),
    .data_i(data_i),
    .state_i(muxout_s),
    .state_o(output_xor_begin_s)
    );

state_register_w_en state_register(
	.clock_i(clock_i), 
	.resetb_i(resetb_i),
	.en_i(enable_i),
	.data_i(output_xor_end_s),
	.data_o(state_o) 
);


register_w_en #(64) cipher_register(
	.clock_i(clock_i), 
	.resetb_i(resetb_i),
	.en_i(en_cipher_i),
	.data_i(output_xor_begin_s[0]),
	.data_o(cipher_o) 
);

register_w_en #(128) tag_register(
	.clock_i(clock_i), 
	.resetb_i(resetb_i),
	.en_i(en_tag_i),
	.data_i({plout_s[3],plout_s[4]}),
	.data_o(tag_o) 
);


endmodule : P
