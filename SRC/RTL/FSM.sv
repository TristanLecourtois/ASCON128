`timescale 1ns/1ps

import ascon_pack::*;


module FSM( // FSM Moore 
	input logic start_i,
	input logic data_valid_i,
	input logic [3:0] round_i,
	input logic [1:0] block_i,
	input logic clock_i,
	input logic resetb_i,

	output logic init_a_o,
	output logic init_b_o,
	output logic enable_round_o,

	output logic init_block_o,
	output logic enable_block_o,
	output logic enable_data_o,

	output logic en_xor_key_b_o,
	output logic en_xor_data_b_o,
	output logic en_xor_key_e_o,
	output logic en_xor_lsb_e_o,

	

	output logic en_reg_state_o,
	output logic en_tag_o,
	output logic en_cipher_o,

	output logic end_o,
	output logic cipher_valid_o 
	);


typedef enum {idle,conf_init,start_init,init,end_init,wait_da,conf_da,da,end_da,idle_cipher,conf_cipher,cipher,
end_cipher,conf_tag,tag,end_tag} state_t ;

state_t current_state, next_state;


always_ff @(posedge clock_i or negedge resetb_i)
		begin : seq_0
			if (resetb_i == 1'b0) begin
				current_state <= idle;
			end
			else begin
				current_state <= next_state;
			end
		end : seq_0



// Comb1


always_comb begin : comb0
                 case (current_state)
                   idle:
                   if (start_i == 1'b1) next_state <= conf_init;
                   else next_state <= idle;

		   
                   conf_init: next_state <= start_init;
		
                   start_init: next_state <= init;

		   init: 
		    if (round_i == 1'hA) next_state <= end_init;
			else next_state <= init;

		  end_init: next_state <= wait_da;
		
		  wait_da:
			if (data_valid_i == 1'b1) next_state <= conf_da;
			else next_state <= wait_da;

                   conf_da:next_state <= da;

	           da: 
			if (round_i == 1'hA) next_state <= end_da;
			else next_state <= da;

		end_da: next_state <= idle_cipher;

		idle_cipher: 
			if (data_valid_i == 1'b1) next_state <= conf_cipher;
			else next_state <= idle_cipher;

		conf_cipher: next_state <= cipher;

		cipher : 
			if (round_i == 1'hB) next_state <= end_cipher;
			else next_state <= cipher;

		end_cipher:
			if (block_i == 1'h2) next_state <= conf_tag;
			else next_state <= idle_cipher;
		
		conf_tag:next_state <= tag;

		tag: 
		if (round_i == 1'hB) next_state <= end_tag;
			else next_state <= tag;

		end_tag: next_state <= idle;


                   default: next_state <= idle;
                 endcase ; // case (current_state)
end : comb0

always_comb
begin : comb_1
	case (current_state)
	idle:begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end
	conf_init:begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	start_init:begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	init:begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	end_init:begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b1;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	wait_da:begin 
		init_a_o=1'b0;
		init_b_o=1'b1;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	conf_da: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b1;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end
	
	da: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end
		
	end_da: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b1;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	idle_cipher: begin // TODO
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	conf_cipher: begin
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b1;
		enable_block_o=1'b1;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b1;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b1;
		end_o=1'b0;
		cipher_valid_o=1'b1;
		end

	cipher: begin
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b1;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	end_cipher: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end

	conf_tag: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b1;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b1;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b1;
		end_o=1'b0;
		cipher_valid_o=1'b1;
		end

	tag: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b1;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b1;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b1;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b1;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end
	
	end_tag: begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b0;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b1;
		en_tag_o=1'b0;
		en_cipher_o=1'b0;
		end_o=1'b1;
		cipher_valid_o=1'b0;
		end

	default : begin 
		init_a_o=1'b0;
		init_b_o=1'b0;
		enable_round_o=1'b0;
		init_block_o=1'b0;
		enable_block_o=1'b0;
		en_xor_key_b_o=1'b0;
		enable_data_o =1'b0;
		en_xor_data_b_o=1'b1;
		en_xor_key_e_o=1'b0;
		en_xor_lsb_e_o=1'b0;
		en_reg_state_o=1'b0;
		en_tag_o=1'b1;
		en_cipher_o=1'b0;
		end_o=1'b0;
		cipher_valid_o=1'b0;
		end
endcase ;
end : comb_1

endmodule : FSM







