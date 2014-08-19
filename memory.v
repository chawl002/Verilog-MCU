`ifndef _memory_v_
`define _memory_v_

module memory(MAR, LDMDR, GATEMDR, MDR, j);
input [15:0] MAR;
input LDMDR;
input GATEMDR;
output reg[15:0] MDR;
reg [15:0] memory_file;
reg[8:0] it = 00000000;
integer ops;
input j;
//m[mar] = mdr //use file with instructions.
//taken from: http://www.fullchipdesign.com/verilog_file_open_close.htm
initial
   begin
	ops = $fopen("memory.txt", "r");
	casez(j)
	0: begin//MDR = mem[MAR]
   		if(it == MAR)
		   begin 
			ops = $fread("memory.txt", memory_file);
		   end
	    end
	1: begin
		if(it == MDR)
  		   begin
			if(LDMEM == 1) //put memory_file in line in memory.txt
			//write to file?
		   end
//write to testbench put MDR in memory
	endcase	
	it <= it + 1;
	if(LDMDR == 1 && GATEMDR == 1) MDR <= memory_file;
	
	$fclose("memory.txt");
   end
endmodule

`endif
