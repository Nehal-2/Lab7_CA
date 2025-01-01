`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 02:09:02 PM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb;
    reg [6:0] opcode;
    reg fun7; // instruction[30]
    reg [2:0] fun3; // instruction[14:12]
    reg zero, less;
    wire pc_sel;
    wire branch;
    wire jump;
    wire mem_write;
    wire memtoreg;
    wire reg_write;
    wire alu_src;
    wire [1:0] alu_op;
    wire [3:0] alu_ctrl;

    control_unit uut (
        .opcode(opcode),
        .fun7(fun7),
        .fun3(fun3),
        .zero(zero),
        .less(less),
        .pc_sel(pc_sel),
        .branch(branch),
        .jump(jump),
        .mem_write(mem_write),
        .memtoreg(memtoreg),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        // Initialize Inputs
        opcode = 7'b0000000;
        fun7 = 0;
        fun3 = 3'b000;
        zero = 0;
        less = 0;

        // Display signals
        $monitor("opcode=%b fun7=%b fun3=%b zero=%b less=%b | pc_sel=%b branch=%b jump=%b mem_write=%b memtoreg=%b reg_write=%b alu_src=%b alu_op=%b alu_ctrl=%b", 
            opcode, fun7, fun3, zero, less, pc_sel, branch, jump, mem_write, memtoreg, reg_write, alu_src, alu_op, alu_ctrl);

        // Test 1: BEQ instruction
        #10 opcode = 7'b1100011; fun3 = 3'b000; zero = 1; // Branch Equal
        #10 opcode = 7'b1100011; fun3 = 3'b000; zero = 0; // Branch Equal (not taken)

        // Test 2: BNE instruction
        #10 opcode = 7'b1100011; fun3 = 3'b001; zero = 1; // Branch Not Equal (not taken)
        #10 opcode = 7'b1100011; fun3 = 3'b001; zero = 0; // Branch Not Equal (taken)

        // Test 3: BLT instruction
        #10 opcode = 7'b1100011; fun3 = 3'b100; less = 1; // Branch Less Than
        #10 opcode = 7'b1100011; fun3 = 3'b100; less = 0; // Branch Less Than (not taken)

        // Test 4: BGE instruction
        #10 opcode = 7'b1100011; fun3 = 3'b101; less = 0; // Branch Greater or Equal
        #10 opcode = 7'b1100011; fun3 = 3'b101; less = 1; // Branch Greater or Equal (not taken)

        // Test 5: JAL instruction
        #10 opcode = 7'b1101111; // Jump and Link
        #10 opcode = 7'b1100111; // JALR

        // Test 6: LUI and AUIPC
        #10 opcode = 7'b0110111; // LUI
        #10 opcode = 7'b0010111; // AUIPC

        // Test 7: Arithmetic and Logical
        #10 opcode = 7'b0110011; fun7 = 0; fun3 = 3'b000; // ADD
        #10 opcode = 7'b0110011; fun7 = 1; fun3 = 3'b000; // SUB
        #10 opcode = 7'b0110011; fun7 = 0; fun3 = 3'b111; // AND
        #10 opcode = 7'b0110011; fun7 = 0; fun3 = 3'b110; // OR

        // Test 8: End of simulation
        #20 $finish;
    end

endmodule
