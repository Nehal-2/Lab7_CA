`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 01:41:01 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input logic [1:0] alu_op,
    input logic [2:0] fun3, // instruction[14:12]
    input logic fun7, // fun7[5] = instruction[30] 
    output logic [3:0] alu_ctrl
);

    always @(*) begin
        case (alu_op)
            2'b10: begin // R-Type and I-Type ALU operations
                case (fun3)
                    3'b000: alu_ctrl = (fun7) ? 4'b0001 : 4'b0000; // ADD or SUB
                    3'b010: alu_ctrl = 4'b0010; // SLT
                    3'b011: alu_ctrl = 4'b0011; // SLTU
                    3'b100: alu_ctrl = 4'b0100; // XOR
                    3'b110: alu_ctrl = 4'b0101; // OR
                    3'b111: alu_ctrl = 4'b0110; // AND
                    3'b001: alu_ctrl = 4'b0111; // SLL
                    3'b101: alu_ctrl = (fun7) ? 4'b1000 : 4'b1001; // SRA or SRL
                    default: alu_ctrl = 4'b1111; // Invalid
                endcase
            end
            2'b00: begin // Load/Store, Jump (JAL, JALR), and Branch (B-Type)
                case (fun3)
                    3'b000: alu_ctrl = 4'b0000; // ADD for address calculation
                    3'b010: alu_ctrl = 4'b0010; // SLT (for branch comparisons)
                    3'b011: alu_ctrl = 4'b0011; // SLTU (for branch comparisons)
                    default: alu_ctrl = 4'b0000; // Default to ADD
                endcase
            end
            2'b01: begin // Branch operations (BEQ, BNE, etc.)
                case (fun3)
                    3'b000: alu_ctrl = 4'b0000; // BEQ (compare with SUB behavior)
                    3'b001: alu_ctrl = 4'b0000; // BNE (compare with SUB behavior)
                    3'b100: alu_ctrl = 4'b0010; // BLT (signed comparison)
                    3'b101: alu_ctrl = 4'b0011; // BGE (signed comparison)
                    3'b110: alu_ctrl = 4'b0011; // BLTU (unsigned comparison)
                    3'b111: alu_ctrl = 4'b0010; // BGEU (unsigned comparison)
                    default: alu_ctrl = 4'b1111; // Invalid
                endcase
            end
            2'b11: begin // U-Type instructions (LUI, AUIPC)
                alu_ctrl = 4'b1010;
            end
            default: alu_ctrl = 4'b1111; // Invalid alu_op
        endcase
    end
endmodule
