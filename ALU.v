`ifndef _ALU_v_
`define _ALU_v_

`include "ZeroExtender.v"

module ALU(ALUK, SR2select, REGISTER1, REGISTER2, DATA, ADDRESS, GATEALU, ANSWER, SR1OUT, SR2OUT);
	input[1:0] ALUK;
	input[1:0] SR2select;//01 for data, 10 for address, 00 for register, 11 for indirect register
	input[2:0] REGISTER1;
	input[2:0] REGISTER2;
	input[7:0] DATA;
	input[6:0] ADDRESS;
	reg[15:0] ADDRESS_DATA;
	input GATEALU;
	output[15:0] ANSWER;
	output reg[15:0] SR1OUT;
	output reg[15:0] SR2OUT;
	reg[15:0] zero_extend_REG1;
	reg[15:0] zero_extend_REG2;
	reg[15:0] zero_extend_indirect;
	reg indirect_register;
always@(*)
   begin
    if(ALUK == 2'b11 && GATEALU == 1) 
	begin
	indirect_register = 1'b0;
	casez(SR2select)
	2'b01: //ADD Reg1 + data
	   begin
		zero_extend_REG1 = extend3(REGISTER1); //zero extend reg1 
		SR2OUT = extend8(DATA);//no need to pull from memory, so put value in SR2.
	   end
	2'b10://REG1 and ADDRESS
	   begin
		zero_extend_REG1 = extend3(REGISTER1);
		zero_extend_REG2 = extend7(ADDRESS);
	   end
        2'b00: //REGISTER1 and REGISTER2
	   begin
		zero_extend_REG1 = extend3(REGISTER1);
		zero_extend_REG2 = extend3(REGISTER2);
	   end
	2'b11: //REGISTER1 + @Ri
	   begin
		zero_extend_REG1 = extend3(REGISTER1); //put in finite state machine?
		zero_extend_REG2 = extend2(REGISTER2); //put in finite state machine?
		indirect_register = 1'b1;
	   end
	endcase
     end
   end
ROM inst5(.MAR(zero_extend_REG1), .LDMAR(1'b1), .MDR(SR1OUT));//pull info from memory and put into SR1
ROM inst6(.MAR(zero_extend_REG2), .LDMAR(1'b1), .MDR(SR2OUT));

initial
begin
	if(indirect_register == 1'b0)
	begin
		assign zero_extend_indirect = SR2OUT;
	end
end
ROM inst7(.MAR(zero_extend_indirect), .LDMAR(1'b1), .MDR(SR2OUT));
assign ANSWER[15:0] = SR2OUT[15:0] + SR1OUT[15:0];
endmodule
`endif
