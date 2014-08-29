`ifndef _RAM_v_
`define _RAM_v_

module RAM(MAR, MDR, LDMEM, LDMDR);
input[15:0] MAR;
input [15:0] MDR;
input LDMEM;
input LDMDR;
reg[15:0]data;
reg[15:0]address = 16'b0;
integer ops;
integer i;
integer position;
integer trash;
always@(*)
     begin
	ops = $fopen("memory.txt", "w+"); //open file to write
	if(LDMDR == 1)
	  begin 
		for (i=0; i == !$feof(ops) && position != MAR; i=i+1) 
		begin

			position = $ftell(ops);//go through array to find position in file 
		end
		trash = $fseek(ops, position, 0); //ftell to return position -> fseek to use position	
		if(LDMEM == 1) $fwrite(ops, "%b\n", MDR); //put memory_file into memory.txt at the ftell/seek function position.
	   end
	end
endmodule
`endif