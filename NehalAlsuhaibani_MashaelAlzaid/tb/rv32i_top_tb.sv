`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2024 10:59:35 AM
// Design Name: 
// Module Name: rv32i_top_tb
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


module rv32i_top_tb;
//    localparam WIDTH = 32;

    logic clk;
    logic reset_n;
//    logic [WIDTH-1:0] inst;

    rv32i_top dut (
        .clk(clk),
        .reset_n(reset_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with 10ns period
    end

    // Stimulus
    initial begin
        // Reset the system
        reset_n = 0;
        #10;
        reset_n = 1;
        #500
        $finish; 

//        // Test Case 1: R-Type (ADD Instruction)
//        inst = 32'h00b50533; // add x10, x10, x11
//        #20;

//        // Test Case 2: I-Type (ADDI Instruction)
//        inst = 32'h00850513; // addi x10, x10, 8
//        #20;

//        // Test Case 3: B-Type (BEQ Instruction)
//        inst = 32'h00050863; // beq x10, x0, offset
//        #20;

//        // Test Case 4: U-Type (LUI Instruction)
//        inst = 32'h00000537; // lui x10, 0x00000
//        #20;

//        // Test Case 5: J-Type (JAL Instruction)
//        inst = 32'h0000006f; // jal x0, offset
//        #20;

//        // Additional test cases can be added here

//        // Finish simulation
//        $stop;
//    end

//    // Monitor the outputs
//    initial begin
//        $monitor("Time: %0t | Inst: %h | Opcode: %h | Fun3: %h | Fun7: %b | Branch: %b | Jump: %b | PC_Sel: %b | Mem_Write: %b | MemtoReg: %h | Reg_Write: %b | ALU_Src: %b | ALU_Op: %b | ALU_Ctrl: %h",
//                 $time, uut.dp.inst, uut.opcode, uut.fun3, uut.fun7,
//                 uut.branch, uut.jump, uut.pc_sel, uut.mem_write,
//                 uut.memtoreg, uut.reg_write, uut.alu_src,
//                 uut.alu_op, uut.alu_ctrl);
    end

endmodule

