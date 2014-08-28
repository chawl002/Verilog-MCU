`ifndef _RAM_v_
`define _RAM_v_

module ROM(LDMAR, MAR);
input LDMAR;
input MAR;
integer ops;
integer position;
integer trash;
integer i;
reg[15:0] i_extended;
reg [15:0] memory_file; //regbank address

always@(*)
   begin
	ops = $fopen("memory.txt", "w+");
	if(LDMAR) //read memory
	begin
		//MDR = mem[MAR]
	   for(i = 0; i < MAR && i != $feof(ops); i = i + 1)
	   begin
		i_extended = extend2(i);
   		if(i_extended == MAR)
		   begin 
			position = $ftell(ops); //find position
			trash = $fseek(ops, position, 0); //find position in specific file
			//ftell to return position -> fseek to use position
			trash = $fread(ops, memory_file);
		   end
	    end
	end
   end
endmodule

`endif