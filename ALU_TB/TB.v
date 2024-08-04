`timescale 1us/1ns
`include "ALU.v"
module ALU_Operations();
parameter IN_DATA_WIDTH_TB=16;
parameter OUT_DATA_WIDTH_TB=32;
//Declare TB Stimulus and Output Signals
reg[IN_DATA_WIDTH_TB-1:0] A_TB,B_TB;
reg[3:0]ALU_FUN_TB;
reg CLK_TB;
wire [OUT_DATA_WIDTH_TB-1:0] ALU_OUT_TB;
wire Arith_Flag_TB,Logic_Flag_TB,CMP_Flag_TB,Shift_Flag_TB;
//Instantiation (Port Mapping)
ALU DUT(
.A(A_TB),
.B(B_TB),
.ALU_FUN(ALU_FUN_TB),
.CLK(CLK_TB),
.ALU_OUT(ALU_OUT_TB),
.Arith_Flag(Arith_Flag_TB),
.Logic_Flag(Logic_Flag_TB),
.CMP_Flag(CMP_Flag_TB),
.Shift_Flag(Shift_Flag_TB)
);
//Clock Generation
always #5 CLK_TB=~(CLK_TB);
//Initial Block with 16 Test Cases for ALU Operations
initial 
begin
 //Initialization Inputs to Zero
 A_TB='b0;
 B_TB='b0;
 CLK_TB=1'b0;
 ALU_FUN_TB=4'b0;
#10 A_TB='b101000;//(40 in decimal)
    B_TB='b010100;//(20 in decimal)
ALU_FUN_TB=4'b0000;
$display("Test case 1 for Addition");
//Testing if ALU_OUT added A,B inputs the result should be 60
#10 if(ALU_OUT_TB=='b111100 && Arith_Flag_TB==1'b1)
    $display("Test case 1 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 1 Failed");

#10 ALU_FUN_TB=4'b0001;
$display("---------------------------------");
$display("Test case 2 for Subtraction");
//Testing if ALU_OUT subtracted A,B inputs the result should be 20 in decimal
#10 if(ALU_OUT_TB=='b010100 && Arith_Flag_TB==1'b1)
    $display("Test case 2 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 2 Failed");

#10 ALU_FUN_TB=4'b0010;
$display("---------------------------------");
$display("Test case 3 for Multiplication");
//Testing if ALU_OUT multiplies A,B inputs the result should be 800 in decimal
#10 if(ALU_OUT_TB=='d800 && Arith_Flag_TB==1'b1)
    $display("Test case 3 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 3 Failed");

#10 ALU_FUN_TB=4'b0011;
$display("---------------------------------");
$display("Test case 4 for Division");
//Testing if ALU_OUT divides A,B inputs the result should be 2 in decimal
#10 if(ALU_OUT_TB=='b10 && Arith_Flag_TB==1'b1)
    $display("Test case 4 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 4 Failed");

#10 ALU_FUN_TB=4'b0100;
$display("---------------------------------");
$display("Test case 5 for AND Operation");
//Testing if ALU_OUT AND A,B inputs the result should be 0
#10 if(ALU_OUT_TB=='b0 && Logic_Flag_TB==1'b1)
    $display("Test case 5 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 5 Failed");

#10 ALU_FUN_TB=4'b0101;
$display("---------------------------------");
$display("Test case 6 for OR Operation");
//Testing if ALU_OUT OR A,B inputs ,The result should be bitwise OR of A and B 
#10 if(ALU_OUT_TB=='b111100 && Logic_Flag_TB==1'b1)
    $display("Test case 6 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 6 Failed");

#10 ALU_FUN_TB=4'b0110;
$display("---------------------------------");
$display("Test case 7 for NAND Operation");
//Testing if ALU_OUT NAND A,B inputs ,The result should be bitwise NAND of A and B 
#10 if(ALU_OUT_TB=='hFFFF && Logic_Flag_TB==1'b1)
    $display("Test case 7 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 7 Failed");

#10 ALU_FUN_TB=4'b0111;
$display("---------------------------------");
$display("Test case 8 for NOR Operation");
//Testing if ALU_OUT NOR A,B inputs ,The result should be bitwise NOR of A and B 
#10 if(ALU_OUT_TB=='hFFC3 && Logic_Flag_TB==1'b1)
    $display("Test case 8 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 8 Failed");

#10 ALU_FUN_TB=4'b1000;
$display("---------------------------------");
$display("Test case 9 for XOR Operation");
//Testing if ALU_OUT XOR A,B inputs ,The result should be bitwise XOR of A and B 
#10 if(ALU_OUT_TB=='b111100 && Logic_Flag_TB==1'b1)
    $display("Test case 9 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 9 Failed");

#10 ALU_FUN_TB=4'b1001;
$display("---------------------------------");
$display("Test case 10 for XNOR Operation");
//Testing if ALU_OUT XNOR A,B inputs ,The result should be bitwise XNOR of A and B 
#10 if(ALU_OUT_TB=='hFFC3 && Logic_Flag_TB==1'b1)
    $display("Test case 10 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 10 Failed");

#10 ALU_FUN_TB=4'b1010;
$display("---------------------------------");
$display("Test case 11 for Comparison Operation");
//Testing if ALU_OUT Compare A,B inputs the result should be 0
#10 if(ALU_OUT_TB=='b0 && CMP_Flag_TB==1'b1)
    $display("Test case 11 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 11 Failed");

#10 ALU_FUN_TB=4'b1011;
$display("---------------------------------");
$display("Test case 12 for Comparison Operation");
//Testing if ALU_OUT Compare A,B inputs the result should be 2 as A>B
#10 if(ALU_OUT_TB=='b10 && CMP_Flag_TB==1'b1)
    $display("Test case 12 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 12 Failed");

#10 ALU_FUN_TB=4'b1100;
$display("---------------------------------");
$display("Test case 13 for Comparison Operation");
//Testing if ALU_OUT Compare A,B inputs the result should be 0
#10 if(ALU_OUT_TB=='b0 && CMP_Flag_TB==1'b1)
    $display("Test case 13 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 13 Failed");

#10 ALU_FUN_TB=4'b1101;
$display("---------------------------------");
$display("Test case 14 for Shift Right Operation");
//Testing if ALU_OUT equals shifting A right by 1 bit, the result should be 20(in decimal)
#10 if(ALU_OUT_TB=='d20 && Shift_Flag_TB==1'b1)
    $display("Test case 14 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 14 Failed");

#10 ALU_FUN_TB=4'b1110;
$display("---------------------------------");
$display("Test case 15 for Shift Left Operation");
//Testing if ALU_OUT equals shifting A left by 1 bit, the result should be 80(in decimal)
#10 if(ALU_OUT_TB=='d80 && Shift_Flag_TB==1'b1)
    $display("Test case 15 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 15 Failed");

#10 ALU_FUN_TB=4'b1111;
$display("---------------------------------");
$display("Test case 16 for NO Operation (NOP)");
//Testing if ALU_OUT equals 0
#10 if(ALU_OUT_TB=='b0 &&Arith_Flag_TB==1'b0 && Logic_Flag_TB==1'b0 && CMP_Flag_TB==1'b0 && Shift_Flag_TB==1'b0)
    $display("Test case 16 Passed ALU_OUT=0x%0h and time=%0t",ALU_OUT_TB,$time);
    else
    $display("Test case 16 Failed");
#100 $stop;
end
endmodule
