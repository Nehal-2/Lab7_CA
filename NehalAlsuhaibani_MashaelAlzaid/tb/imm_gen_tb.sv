`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 02:15:33 PM
// Design Name: 
// Module Name: imm_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen_tb;
    logic [31:0] inst, imm;
    
    imm_gen uut (.*);
    
    initial begin
        // Test I*- & I-type instructions
        inst = 32'h00052503; #10 // lw x10 0(x10) 
        inst = 32'h00050593; #10 // addi x11 x10 0
        inst = 32'h00008067; #10 // jalr x0 x1 0
        
        // Test S-type instructions
        inst = 32'h00112223; #10 // sw x1 4(x2)
        
        // Test B-type instructions
        inst = 32'h00500863; #10 // beq x0 x5 16
        
        // Test J-type instructions
        inst = 32'h014000EF; #10 // jal x1 20 
        
        // Test U-type instructions
        inst = 32'h10000517; #10 // auipc x10 65536
        inst = 32'h00001537; #10 // lui x10 1
        $finish;
    end
    
endmodule
