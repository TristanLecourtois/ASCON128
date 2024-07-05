`timescale 1ns/1ps

import ascon_pack::*;

module ascon (
	// input of ASCON
	input logic[63:0] data_i,
	input logic[127:0] key_i, 
	input logic [127:0] nonce_i,
	input logic start_i, 
	input logic data_valid_i, 
	input logic clock_i, 
	input logic resetb_i,
	// output of ASCON
	output logic end_o, 
	output logic cipher_valid_o,
	output logic[63:0] cipher_o,
	output logic[127:0] tag_o

);
// internal signals declaration
logic[1:0] block_s;
logic[3:0] round_s;
logic en_cipher_o_s;
logic en_tag_o_s;
logic enable_round_s;
logic init_a_s;
logic init_b_s;
logic selectData_s;
logic enable_state_register_s;
logic xor_data_i_begin_o_s;
logic xor_key_i_begin_o_s;
logic xor_key_i_end_o_s;
logic xor_ext_i_end_o_s;
type_state permutation_input_s;
type_state permutation_output_s;


FSM UB(
	.start_i(start_i),
	.data_valid_i(data_valid_i),
	.round_i(round_s),
	.block_i(block_s),
	.clock_i(clock_i),
	.resetb_i(resetb_i),

	.init_a_o(init_round_p12_s),
	.init_b_o(init_round_p6_s),
	.enable_round_o(enable_round_s),

	.init_block_o(init_block_s),
	.enable_block_o(enable_block_s),
	.enable_data_o(selectData_s), 
	
	.en_xor_key_b_o(xor_key_i_begin_o_s),
	.en_xor_data_b_o(xor_data_i_begin_o_s),
	.en_xor_key_e_o(xor_key_i_end_o_s),
	.en_xor_lsb_e_o(xor_ext_i_end_o_s),

	.en_reg_state_o(enable_state_register_s),
	.en_tag_o(en_tag_o_s),
	.en_cipher_o(en_cipher_o_s),

	.end_o(end_o),
	.cipher_valid_o(cipher_valid_o) 


);



compteur_simple_init U1 (
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(enable_block_s),
	.init_a_i(init_round_p12_s),
	.data_o(block_s)
);

compteur_double_init U2 (
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(enable_round_s),
	.init_a_i(init_a_s),
	.init_b_i(init_b_s),
	.data_o(round_s)
);


P U3(
	.data_i(data_i),
	.key_i(key_i),
	.state_i(permutation_input_s),
	.state_o(permutation_output_s),
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_round_s),
	.select_i(selectData_s),
	.round_i(round_s),
	.en_xor_key_b_i(xor_key_i_begin_o_s), 
	.en_xor_data_b_i(xor_data_i_begin_o_s),
	.en_xor_key_e_i(xor_key_i_end_o_s),
	.en_xor_lsb_e_i(xor_ext_i_end_o_s),
	.en_tag_i(en_tag_o_s),
	.en_cipher_i(en_cipher_o_s),
	.cipher_o(cipher_o),
	.tag_o(tag_o)
);



endmodule 







