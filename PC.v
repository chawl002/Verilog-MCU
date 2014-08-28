`ifndef _PC_v_
`define _PC_v_


module PC(clk, MAR, MARPC, GATEPC, PCADDR);
input clk;
input[15:0] MAR;
input MARPC;
input GATEPC;
output reg[15:0]PCADDR; //chosen output for PC
integer i;

always@(posedge clk)
   begin
	if(GATEPC == 1 && MARPC == 1) begin
		for(i = 0; i < 16; i = i +1) PCADDR[i] <= MAR[i];
		end
   end
endmodule

`endif