`ifndef _REGBANK_v_
`define _REGBANK_v_

//Register bank/file
module REGBANK(REGISTER1, REGISTER2, LDREGF, SR1OUT, SR2OUT);

	input[2:0] REGISTER1;
	input[2:0] REGISTER2;
	input[1:0] LDREGF;
	output[15:0] SR1OUT;
	output[15:0] SR2OUT;
	reg [15:0] Address_mem;
	reg[15:0] address_extended;
	///reg[15:0] erom [:0];

//define registers and pull info from memory
always@(*)
	begin
		if(REGISTER1 == 3'b000 || REGISTER2 == 3'b000) //IF REGISTERs == 0
		begin
			Address_mem = 8'b00000000;
		end
		else if(REGISTER1 == 3'b001 || REGISTER2 == 3'b001) //IF REGISTERs == 1
		begin
			Address_mem = 8'b00000001;
		end
		else if(REGISTER1 == 3'b010 || REGISTER2 == 3'b010) //IF REGISTERs == 2
		begin
			Address_mem = 8'b00000010;
		end
		else if(REGISTER1 == 3'b011 || REGISTER2 == 3'b011) //IF REGISTERs == 3
		begin
			Address_mem = 8'b00000011;
		end
		else if(REGISTER1 == 3'b100 || REGISTER2 == 3'b100) //IF REGISTERs == 4
		begin
			Address_mem = 8'b00000100;
		end
		else if(REGISTER1 == 3'b101 || REGISTER2 == 3'b101) //IF REGISTERs == 5
		begin
			Address_mem = 8'b00000101;
		end
		else if(REGISTER1 == 3'b110 || REGISTER2 == 3'b110) //IF REGISTERs == 6
		begin
			Address_mem = 8'b00000110;
		end
		else if(REGISTER1 == 3'b111 || REGISTER2 == 3'b111) //IF REGISTERs == 7
		begin
			Address_mem = 8'b00000111;
		end
	if(LDREGF == 1)
	begin
		address_extended = extend8(Address_mem[7:0]);
		//Address_mem[15:0] = Address_mem[7:0] + zero_extender[15:0];
	end
   end


//call memory here and put into SROUTs
memory inst2(.MAR(address_extended), .LDMDR(1'b1), .LDMAR(1'b1), .GATEMDR(1'b1), .MDR(SR1OUT));
memory inst3(.MAR(address_extended), .LDMDR(1'b1), .LDMAR(1'b1), .GATEMDR(1'b1), .MDR(SR2OUT));
//return SRsOUT
endmodule

`endif