`ifndef _ZeroExtender_v_
`define _ZeroExtender_v_

module extender();
function [15:0] extend2(input[1:0] in2);
 begin
   if (in2[1] === 1'bX) 
	begin
      extend2 = {2'bXX, in2};
	end 
   else 
	begin
      extend2 = {2'b00, in2};
	end
 end
endfunction


function [15:0] extend3(input[2:0] in3);
 begin
   if (in3[2] === 1'bX) 
	begin
      extend3 = {3'bXXX, in3};
	end 
   else 
	begin
      extend3 = {3'b000, in3};
	end
 end
endfunction

function [15:0] extend7(input[6:0] in7);
 begin
   if (in7[6] === 1'bX) 
	begin
      extend7 = {7'bXXXXXXX, in7};
	end 
   else 
	begin
      extend7 = {7'b0000000, in7};
	end
 end
endfunction

function [15:0] extend8(input[7:0] in8);
 begin
   if (in8[7] === 1'bX) 
	begin
      extend8 = {8'hXX, in8};
	end 
   else 
	begin
      extend8 = {8'h00, in8};
	end
 end
endfunction
endmodule
`endif