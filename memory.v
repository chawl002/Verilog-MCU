`ifndef _memory_v_
`define _memory_v_
module memory(MAR, LDMDR, LDMEM, GATEMDR, MDR, j);
input [15:0] MAR;
input LDMDR;
input LDMEM;
input GATEMDR;
output reg[15:0] MDR;
reg [15:0] memory_file;
reg[7:0] it = 00000000;
integer ops;
integer position;
integer trash;
input j;
initial
   begin
	ops = $fopen("memory.txt", "r+");
	casez(j)
	0: begin//MDR = mem[MAR]
   		if(it == MAR)
		   begin 
			position = $ftell(ops); //find position
			trash = $fseek(ops, position, 0); //find position in specific file
			//ftell to return position -> fseek to use position
			trash = $fread(ops, memory_file);
		   end
	    end
	1: begin
		if(it == MDR)
  		   begin
			if(LDMEM == 1)
			   begin 
			position = $ftell(ops); //find position
			trash = $fseek(ops, position, 0); //find position in specific file
			//ftell to return position -> fseek to use position
			trash = $fprint(ops, "%b\n"); //put memory_file into memory.txt at the ftell/seek function position.
			   end
		   end
	   end
//write to testbench put MDR in memory
	endcase	
	it <= it + 1;
	if(LDMDR == 1 && GATEMDR == 1) MDR <= memory_file;
	
	$fclose("memory.txt");
   end
endmodule

`endif