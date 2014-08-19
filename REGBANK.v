`ifndef _REGBANK_v_
`define _REGBANK_v_

//Register bank/file
module REGBANK(REGISTER1, REGISTER2, ADDRESS, LDREGF, SR1OUT, SR2OUT);

	input[2:0] REGISTER1;
	input[2:0] REGISTER2;
	input[6:0] ADDRESS;
	input[1:0] LDREGF;
	output[15:0] SR1OUT;
	output[15:0] SR2OUT;
	integer ops;
	reg x_1 = 1'b0;
	reg y_1 = 1'b0;
always
   begin

	ops = $fopen("registerfile.txt", "rb");
	while(!$feof("registerfile.txt"))
	begin
	   if(LDREGF == 1) 
	   begin
		if(REGISTER1 == x_1) ops = $fread("registerfile.txt", SR1OUT);//ops = $fscanf(ops, "%b\n", SR1OUT);
		if(REGISTER2 == y_1) ops = $fread("registerfile.txt", SR2OUT);//ops = $fscanf(ops, "%b\n", SR2OUT);
	   end
	end
	x_1 <= x_1 + 1;
	y_1 <= y_1 + 1;
	$fclose("registerfile.txt");
   end

endmodule

`endif