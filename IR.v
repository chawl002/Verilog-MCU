`ifndef _IR_v_
`define _IR_v_


//IR
module IR(MDR, IReg);
	input[15:0] MDR;
	output[15:0] IReg;

assign IReg = MDR;
endmodule

`endif