`timescale 1ns/1ps

module FSM_tb;

  
  logic data_valid_s, start_s, clock_s, resetb_s, cipher_valid_s, end_s, enable_round_s, initA_s, initB_s, en_cipher_s, en_tag_s,init_block_s,enable_block_s,enable_data_s,en_xor_key_b_s,en_xor_data_b_s,
en_xor_key_e_s,en_xor_lsb_e_s,en_reg_state_s;

logic [3:0] round_s;
  logic [1:0] block_s;


  FSM DUT (
    .start_i(start_s),
    .data_valid_i(data_valid_s),
    .round_i(round_s),
    .block_i(block_s),
    .clock_i(clock_s),
    .resetb_i(resetb_s),
    .init_a_o(initA_s),
    .init_b_o(initB_s),
    .enable_round_o(enable_round_s),
    .init_block_o(init_block_s),
    .enable_block_o(enable_block_s),
    .enable_data_o(enable_data_s),
    .en_xor_key_b_o(en_xor_key_b_s),
    .en_xor_data_b_o(en_xor_data_b_s),
    .en_xor_key_e_o(en_xor_key_e_s),
    .en_xor_lsb_e_o(en_xor_lsb_e_s),
    .en_reg_state_o(en_reg_state_s),
    .en_tag_o(en_tag_s),
    .en_cipher_o(en_cipher_s),
    .end_o(end_s),
    .cipher_valid_o(cipher_valid_s)
  );


compteur_double_init CDI(
    .clock_i(clock_s),
    .resetb_i(resetb_s),
    .en_i(enable_round_s),
    .init_a_i(initA_s),
    .init_b_i(initB_s),
    .data_o(round_s)  
);

compteur_simple_init CB (
    .clock_i(clock_s),
    .resetb_i(resetb_s),
    .en_i(en_cipher_s),
    .init_a_i(initA_s),
    .data_o(block_s)   
);


initial 
	begin 
		clock_s = 0;
		forever #50 clock_s = ~clock_s;
	end


initial
begin
	resetb_s = 0;
	#25
	resetb_s = 1;
end

initial 
	begin 
		data_valid_s = 0;
		start_s = 0;
		#100
		start_s = 1;
		#1800
		data_valid_s = 1;
		start_s = 0;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
	end

endmodule

