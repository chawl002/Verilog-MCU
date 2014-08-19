`ifndef _PC_v_
`define _PC_v_


module PC(MAR, /*MARPC, GATEPC, */PCADDR);
///input clk;
input[15:0] MAR;
//input MARPC;
//input GATEPC;
output[15:0]PCADDR; //chosen output for PC

//initial
   //begin
	//if(GATEPC == 1 && MARPC == 1) 
		//pass the MAR to the PCADDR array CSA16(A,B,Ci,So,Co);
	CSA16 csa16_4(.A(MAR[15:0]), .B(16'b0000000000000000), .Ci(0), .So(PCADDR[15:0]), .Co(0));  //compiles when initial block removed
   //end
endmodule

`endif