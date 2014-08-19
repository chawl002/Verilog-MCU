`ifndef _CSA16_v_
`define _CSA16_v_

//16bit adder
//http://www.edaboard.com/thread145292.html
module CSA16 (A,B,Ci,So,Co);
input [15:0] A,B;
input Ci;
output [15:0] So;
output Co;

wire [7:0] stemp1,stemp0;
wire c8;
wire c160,c161;

CSA8 CSA8in(A[7:0],B[7:0],Ci,So[7:0],c8 );
CSA8 CSA81 (A[15:8],B[15:8],1'b1,stemp1,c161);
CSA8 CSA80 (A[15:8],B[15:8],1'b0,stemp0,c160);

assign So[15:8] = c8?stemp1:stemp0;
assign Co= c8?c161:c160;

endmodule

//taken from http://www.edaboard.com/thread145292.html
//4 bit adder
module RCA4(A,B,Ci,So,Co);
input [3:0] A,B;
input Ci;
output [3:0] So;
output Co;
wire c1,c2,c3,c4;
wire g0,g1,g2,g3;
wire p0,p1,p2,p3;

assign g0=A[0]&B[0];
assign g1=A[1]&B[1];
assign g2=A[2]&B[2];
assign g3=A[3]&B[3];

assign p0=A[0]|B[0];
assign p1=A[1]|B[1];
assign p2=A[2]|B[2];
assign p3=A[3]|B[3];

assign c1=g0|(p0&Ci);
assign c2=g1|(p1&g0)|(p1&p0&Ci);
assign c3=g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&Ci);
assign c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&Ci);
assign Co=c4;

assign So[0]=g0^p0^Ci;
assign So[1]=g1^p1^c1;
assign So[2]=g2^p2^c2;
assign So[3]=g3^p3^c3;
endmodule

//8bit adder
//http://www.edaboard.com/thread145292.html
module CSA8(A,B,Ci,So,Co);
input [7:0] A,B;
input Ci;
output [7:0] So;
output Co;

wire [3:0] stemp1,stemp0;
wire c4;
wire c80,c81;

RCA4 RCA4in(A[3:0],B[3:0],Ci,So[3:0],c4);
RCA4 RCA41 (A[7:4],B[7:4],1'b1,stemp1,c81);
RCA4 RCA40 (A[7:4],B[7:4],1'b0,stemp0,c80);

assign So[7:4] = c4?stemp1:stemp0;
assign Co= c4?c81:c80;

endmodule

`endif