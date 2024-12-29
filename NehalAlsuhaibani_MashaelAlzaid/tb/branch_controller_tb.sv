`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 12:42:50 PM
// Design Name: 
// Module Name: branch_controller_tb
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


module branch_controller_tb;
    logic branch;
    logic [2:0] fun3;
    logic zero;
    logic less;
    logic pc_sel;

    branch_controller uut (
        .branch(branch),
        .fun3(fun3),
        .zero(zero),
        .less(less),
        .pc_sel(pc_sel)
    );

    // Task to display results
    task display_result;
        input [2:0] fun3;
        input branch;
        input zero;
        input less;
        input pc_sel;
        $display("fun3=%b | branch=%b | zero=%b | less=%b | pc_sel=%b", fun3, branch, zero, less, pc_sel);
    endtask

    // Stimulus generation
    initial begin
        // Test cases
        // Format: {branch, fun3, zero, less, expected pc_sel}

        $display("Starting Testbench for branch_control");

        // BEQ: Branch if equal (fun3 = 000)
        branch = 1;
        fun3 = 3'b000;
        zero = 1; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // BNE: Branch if not equal (fun3 = 001)
        fun3 = 3'b001;
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 1; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // BLT: Branch if less than (fun3 = 100)
        fun3 = 3'b100;
        zero = 0; less = 1; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // BGE: Branch if greater or equal (fun3 = 101)
        fun3 = 3'b101;
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 0; less = 1; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // BLTU: Branch if less than unsigned (fun3 = 110)
        fun3 = 3'b110;
        zero = 0; less = 1; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // BGEU: Branch if greater or equal unsigned (fun3 = 111)
        fun3 = 3'b111;
        zero = 0; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 1
        zero = 0; less = 1; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        // Non-branch case: branch = 0
        branch = 0;
        fun3 = 3'b000; zero = 1; less = 0; #10 display_result(fun3, branch, zero, less, pc_sel); // pc_sel = 0

        $display("Testbench completed.");
        $finish;
    end

endmodule


