`ifndef _PCMUX_v_
`define _PCMUX_v_
module PCMUX(SR1OUT, next_instruction, select, OUTPUT1);

input[15:0] SR1OUT; //input from register file
input[15:0] next_instruction;
input[1:0] select; //select line for the MUX
output reg[15:0] OUTPUT1;
initial
   begin
	case(select)
	00 : begin 
		//pass in instruction +1
		OUTPUT1[15:0] = next_instruction[15:0] + 16'b1;
	     end
	//pass in next instruction
	01: begin 
		OUTPUT1[15:0] = SR1OUT[15:0];
	    end
	//10 : //do nothing
	endcase
   end 
endmodule

`endif





