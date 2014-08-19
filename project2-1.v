`include "CSA16.v"
`include "FSM.v"
`include "ALU.v"
`include "IR.v"
`include "PC.v"
`include "memory.v"
`include "REGBANK.v"
//http://www.ece.umd.edu/courses/enee359a/verilog_tutorial.pdf
//need to create clock generator function
//always begin
//#5 clock = ~clock //toggle every 5 ticks
//end

 //ANDC function for 16bits
module AND16(A, B, C);
	input[15:0] A;
	input[15:0] B;
	output[15:0] C;
	reg[15:0] test = 0000000000000000;
	integer i = 0;
initial 
   begin
	for(i = 0; i < 16; i = i+1) begin
		if(A[i] & B[i]) test[i] = 1;
		else test[i] = 0;
        end
	
   end
assign C = test;
endmodule

//PC Mux, determine what value enters the PC
module PCMUX(SR1OUT, add_one, next_instruction, select);

input[15:0] SR1OUT; //input from register file
input[15:0] add_one; //update PC
input[15:0] next_instruction;
input[1:0] select; //select line for the MUX\
reg[15:0] add_variable;
reg[15:0] input_variable;
initial
   begin
	case(select)
	00 : begin 
		//pass in instruction +1
		add_variable <= 16'b0000000000000001;
		input_variable <= next_instruction[15:0];
	     end
	//pass in next instruction
	01: begin 
		input_variable <= SR1OUT[15:0];
		add_variable <= 16'b0000000000000000;
	    end
	//CSA16 csa16_5(SR1OUT[15:0], 16'b0000000000000000, 0, next_instruction[15:0], 0);
	//10 : //do nothing
	endcase
   end 
//module CSA16 (A,B,Ci,So,Co);
   CSA16 inst1 (.A(input_variable), .B(add_variable), .Ci(0), .So(next_instruction[15:0]), .Co(0));
endmodule







