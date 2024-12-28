`timescale 1ns / 1ps

module store_mem(
input logic [31:0]memory_word
,input logic  [3:0] addr_lsb
,input logic  [2:0] funct3 
,output logic [31:0] load_data  );
    
    
    // Byte selection logic
reg [7:0] selected_byte;
always @(*) begin
    case(addr_lsb[1:0])
        2'b00: selected_byte = memory_word[7:0];    // byte0
        2'b01: selected_byte = memory_word[15:8];   // byte1
        2'b10: selected_byte = memory_word[23:16];  // byte2
        2'b11: selected_byte = memory_word[31:24];  // byte3
    endcase
end

// Halfword selection logic
reg [15:0] selected_halfword;
always @(*) begin
    case(addr_lsb[1])
        1'b0: selected_halfword = memory_word[15:0];   // lower half
        1'b1: selected_halfword = memory_word[31:16];  // upper half
    endcase
end

//  output selection based on instruction type
always @(*) begin
    case(funct3)
        3'b000: begin  // lb
            load_data = {{24{selected_byte[7]}}, selected_byte};
        end
        3'b001: begin  // lh
            load_data = {{16{selected_halfword[15]}}, selected_halfword};
        end
        3'b010: begin  // lw
            load_data = memory_word;
        end
        3'b100: begin  // lbu
            load_data = {24'b0, selected_byte};
        end
        3'b101: begin  // lhu
            load_data = {16'b0, selected_halfword};
        end
        default: load_data = 32'b0;
    endcase
end
    
    
    endmodule
