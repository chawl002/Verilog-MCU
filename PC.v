`ifndef _PC_v_
`define _PC_v_


module PC(clk, INSTRUCTION, LDPC, GATEPC, PCADDR);
input clk;
input[15:0] INSTRUCTION;
input LDPC;
input GATEPC;
output reg[15:0]PCADDR; //chosen output for PC
integer i;

always@(posedge clk)
   begin
	if(GATEPC == 1 && LDPC == 1) begin
		for(i = 0; i < 16; i = i +1) PCADDR[i] <= INSTRUCTION[i];
		end
   end
endmodule

`endif