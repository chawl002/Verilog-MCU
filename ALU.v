`ifndef _ALU_v_
`define _ALU_v_
module ALU(ALUK, SR2select, REGISTER1, REGISTER2, DATA, ADDRESS, GATEALU, ANSWER, SR1OUT, SR2OUT);
	input[1:0] ALUK;
	input[1:0] SR2select;//01 for data, 10 for address, 00 for register
	input[2:0] REGISTER1;
	input[2:0] REGISTER2;
	input[7:0] DATA;
	input[6:0] ADDRESS;
	input GATEALU;
	output[15:0] ANSWER;
	output[15:0] SR1OUT;
	output[15:0] SR2OUT;
	reg[15:0] R1;
	//reg C_i;
	//reg C_o;
initial
   begin
    if(ALUK == 2'b11 && GATEALU == 1) 
	begin
	//ADD
	if(SR2select == 2'b01) 
	   begin
		//REGBANK regbank_0(REGISTER1, 0, 0, 1, 0, 0);
		//CSA16 csa16_1(SR1OUT, DATA, 0, ANSWER, 0); 
		R1 <= 8'b0 + DATA;
	   end
	if(SR2select == 2'b10)
	   begin
		//REGBANK regbank_1(REGISTER1, 0, ADDRESS, 1, 0, 0);
		//CSA16 csa16_2(SR1OUT, ADDRESS, 0, ANSWER, 0);
		R1 <= 9'b0 + ADDRESS;
	   end
        if(SR2select == 2'b00)
	   begin
		//REGBANK regbank_2(REGISTER1, REGISTER2, 0, 1, 0, 0);
		//CSA16 csa16_3(SR1OUT, SR2OUT, 0, ANSWER, 0);
		R1 <= SR1OUT;
	   end
     end
end
REGBANK inst0(.REGISTER1(REGISTER1), .REGISTER2(REGISTER2), .ADDRESS(ADDRESS), .LDREGF(1'b1), .SR1OUT(0), .SR2OUT(0));
CSA16 inst1(.A(SR1OUT), .B(R1), .Ci(1'b0), .So(ANSWER), .Co(1'b0));
endmodule
`endif