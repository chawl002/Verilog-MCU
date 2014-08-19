`ifndef _FSM_v_
`define _FSM_v_
//Finite State Machine
module FSM(IReg); //separate the binary and put it in individual regs.
	input[15:0] IReg; 
	reg [3:0] OPERATION;
	reg FLAG;
	reg[2:0] REGISTER1;
	reg[2:0] REGISTER2;
	reg[7:0] DATA;
	reg[6:0] ADDRESS;
	reg[1:0] SR2_select;
initial
   begin
	casez(IReg)  
		16'b00001???????????: //ADD RN, data
			begin
			assign{OPERATION, FLAG, REGISTER1, DATA} = IReg;
			
			//         ALUK     SR2      reg1    reg2  data  addr, gatealu, answer
			//ALU alu_0(2'b11, 2'b01, REGISTER1, 2'b0, DATA, 5'b0, 1'b1, 16'b0);
			SR2_select <= 2'b01;
			REGISTER2 <= 2'b00;
			ADDRESS <= 5'b0;
			$display("ADD Rn, #data\n");
			end
		 //5432109876543210
		16'b00000???????????: //ADD RN, address
			begin
			assign{OPERATION, FLAG, REGISTER1, FLAG, ADDRESS} = IReg;

			//ALU alu_1(2'b11, 2'b10, REGISTER1, 2'b0, 8'b0, ADDRESS, 1'b1, 16'b0);
			SR2_select <= 2'b10;
			REGISTER2 <= 2'b00;
			DATA = 8'b0;
			$display("ADD Rn, address\n");
			end
 		  //5432109876543210
		16'b00000????00010??: //ADD RN Ri
			begin
			assign{OPERATION, FLAG, REGISTER1, FLAG, FLAG, FLAG, FLAG, FLAG, REGISTER2} = IReg;
			//ALU alu_2(2'b11, 2'b00, REGISTER1, REGISTER2, 8'b0, 5'b0, 1'b1, 16'b0);
			SR2_select <= 2'b00;
			ADDRESS <= 5'b0;
			DATA <= 8'b0;
			$display("ADD Rn, @Ri");
			end	
		16'b00011???????????: //ANDC RN data
			begin //ADD MORE HERE
			$display("ANDC Rn, data\n");
			end
		//ADD MORE CASES FOR OTHER FUNCTIONS HERE
       endcase
   end
ALU inst_0(.ALUK(2'b11), .SR2select(SR2_select), .REGISTER1(REGISTER1), .REGISTER2(REGISTER2), .DATA(DATA), .ADDRESS(ADDRESS), .GATEALU(1'b1), .ANSWER(16'b0), .SR1OUT(16'b0), .SR2OUT(16'b0));
endmodule
`endif