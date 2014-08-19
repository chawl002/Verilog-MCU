`ifndef _IR_v_
`define _IR_v_


//IR
module IR(MDR, IReg);
	input[15:0] MDR;
	output[15:0] IReg;

CSA16 csa16_0(.A(MDR[15:0]), .B(16'b0000000000000000), .Ci(0), .So(IReg[15:0]), .Co(0));
endmodule

`endif