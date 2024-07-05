`timescale 1 ns/ 1 ps

module P_tb import ascon_pack::*;
   (
    ) ;

   type_state state_in_s;
   type_state state_out_s;

   logic       resetb_s;
   logic       clock_s =1'b0;
   logic       data_sel_s;
   logic       en_reg_state_s;
   logic       en_xor_key_s;
   logic       en_xor_key_end_s;
   logic       en_xor_lsb_s;
   logic       en_xor_data_s;

   logic [127:0] key_s;
   logic [63:0]  data_s;
   logic [3:0] round_s;
   logic [63:0] cipher_s;  
   logic [127:0] tag_s;

   logic en_cipher_s;
   logic en_tag_s;
   
   
  
   
   
   P DUT (
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.select_i(data_sel_s),
	.enable_i(en_reg_state_s),
	.en_xor_key_b_i(en_xor_key_s),
	.en_xor_lsb_e_i(en_xor_lsb_s),
	.en_xor_data_b_i(en_xor_data_s),
	.en_xor_key_e_i(en_xor_key_end_s),
	.key_i(key_s),
	.data_i(data_s),
	.round_i(round_s),
	.state_i(state_in_s),
	.en_tag_i(en_tag_s),
	.en_cipher_i(en_cipher_s),
	.state_o(state_out_s),
	.cipher_o(cipher_s),
	.tag_o(tag_s)
);
   
   always  begin
       assign  clock_s = ~clock_s;
      #10;
      
   end
   
   initial begin
      int i;
      data_s ='0;
      key_s	 = 128'h000102030405060708090A0B0C0D0E0F;
      
      state_in_s[0] = 64'h80400c0600000000; 
      state_in_s[1] = 64'h8a55114d1cb6a9a2; 
      state_in_s[2] = 64'hbe263d4d7aecaaff; 
      state_in_s[3] = 64'h4ed0ec0b98c529b7; 
      state_in_s[4] = 64'hc8cddf37bcd0284a;
      	
      en_cipher_s = 0;
      en_tag_s = 0;
      resetb_s   = 1'b0;
      data_sel_s = 1'b0;
      en_xor_data_s      = 1'b0;
      en_xor_key_s  = 1'b0;
      en_xor_lsb_s       = 1'b0;
      en_xor_key_end_s = 1'b0;
      en_reg_state_s     = 1'b1;
      round_s    = 4'b0000;

      #105;
      resetb_s   = 1'b1;
      #20;
      data_sel_s = 1'b1;
      round_s = 4'b0001;
      #20;
      round_s = 4'b0010;
      
      #20;
      round_s = 4'b0011;
      
      #20;
      round_s = 4'b0100;
      
      #20;
      round_s = 4'b0101;
      
      #20;
      round_s = 4'b0110;
      
      #20;
      round_s = 4'b0111;
      
      #20;
      round_s = 4'b1000;
      
      #20;
      round_s = 4'b1001;
      
      #20;
      round_s = 4'b1010;
      
      #20;
      round_s = 4'b1011;
      en_xor_key_s = 1'b1;
      #20;
      
   end
endmodule: P_tb
 











