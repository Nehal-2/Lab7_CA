
  `timescale 1ns / 1ps

module alu_control(
    input logic [1:0] alu_op,
    input logic [31:0] instruction, // NOTE: This comes from the top file or main processor
    output logic [3:0] alu_ctrl
);

    main_control controler(

    .alu_op(alu_op)
    );

    // Extract instruction fields
    logic [2:0] fun3 = instruction[14:12];
    logic fun7 = instruction[30];

    // ALU control logic
    always @(*) begin
        case (alu_op)
            2'b00: begin // Arithmetic operations
                case (fun3)
                    3'b000: alu_ctrl = (fun7) ? 4'b0001 : 4'b0000; // ADD (fun7=0) or SUB (fun7=1)
                    3'b010: alu_ctrl = 4'b0010; // SLT (Set Less Than)
                    3'b011: alu_ctrl = 4'b0011; // SLTU (Set Less Than Unsigned)
                    default: alu_ctrl = 4'b1111; // Invalid or unsupported
                endcase
            end

            2'b01: begin // Logical operations
                case (fun3)
                    3'b100: alu_ctrl = 4'b0100; // XOR
                    3'b110: alu_ctrl = 4'b0101; // OR
                    3'b111: alu_ctrl = 4'b0110; // AND
                    default: alu_ctrl = 4'b1111; // Invalid or unsupported
                endcase
            end

            2'b10: begin // Shift operations
                case (fun3)
                    3'b001: alu_ctrl = 4'b0111; // SLL (Shift Left Logical)
                    3'b101: alu_ctrl = (fun7) ? 4'b1000 : 4'b1001; // SRA (fun7=1) or SRL (fun7=0)
                    default: alu_ctrl = 4'b1111; // Invalid or unsupported
                endcase
            end

            2'b11: begin // Immediate operations
                case (fun3)
                    3'b000: alu_ctrl = 4'b1010; // ADDI (Add Immediate)
                    3'b010: alu_ctrl = 4'b1011; // SLTI (Set Less Than Immediate)
                    3'b011: alu_ctrl = 4'b1100; // SLTIU (Set Less Than Immediate Unsigned)
                    3'b100: alu_ctrl = 4'b1101; // XORI
                    3'b110: alu_ctrl = 4'b1110; // ORI
                    3'b111: alu_ctrl = 4'b1111; // ANDI
                    default: alu_ctrl = 4'b1111; // Invalid or unsupported
                endcase
            end

            default: alu_ctrl = 4'b1111; // Invalid alu_op
        endcase
    end

endmodule
