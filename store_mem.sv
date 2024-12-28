`timescale 1ns / 1ps


module store_mem(
    input logic [31:0] memory_word,
    input logic [3:0] addr_lsb,
    input logic [2:0] funct3,
    input logic wEn,
    input logic [31:0] addre,
    output logic [31:0] dmem [0:1023]
);

    logic [3:0] byte_wsel, hw_wsel, wsel;

    // Byte select mux
    always_comb begin
        case (addr_lsb[1:0])
            2'b00: byte_wsel = 4'b0001; // byte0
            2'b01: byte_wsel = 4'b0010; // byte1
            2'b10: byte_wsel = 4'b0100; // byte2
            2'b11: byte_wsel = 4'b1000; // byte3
        endcase
    end

    // Half-word select mux
    always_comb begin
        case (addr_lsb[1])
            1'b0: hw_wsel = 4'b0011; // half-word1
            1'b1: hw_wsel = 4'b1100; // half-word2
        endcase
    end
logic [3:0] bsel;
    // Write select flag
    always_comb begin
        case (funct3)
            3'b000:  bsel = byte_wsel;
            3'b001:  bsel = hw_wsel;
            3'b010:  bsel = 4'b1111; // full word
            default: bsel = 4'b0000; // Default to no write
        endcase
    end
    
    always_comb begin
    wsel[0] = bsel[0] && wEn;
    wsel[1] = bsel[1] && wEn;
    wsel[2] = bsel[2] && wEn;
    wsel[3] = bsel[3] && wEn;
end

    // Data alignment and writing
    always_comb begin
        if (wsel[0])
            dmem[addre[31:2]] = (dmem[addre[31:2]] & ~32'hFF) | (memory_word[7:0] << (addr_lsb[1:0] * 8));
        else if (wsel[1])
            dmem[addre[31:2]] = (dmem[addre[31:2]] & ~32'hFF00) | (memory_word[15:8] << (addr_lsb[1:0] * 8));
        else if (wsel[2])
            dmem[addre[31:2]] = (dmem[addre[31:2]] & ~32'hFF0000) | (memory_word[23:16] << (addr_lsb[1:0] * 8));
        else if (wsel[3])
            dmem[addre[31:2]] = (dmem[addre[31:2]] & ~32'hFF000000) | (memory_word[31:24] << (addr_lsb[1:0] * 8));
    end

    // Output selection based on instruction type
//    always_comb begin
//        if (wsel[0] )
//            dmem[addre[31:1]] = memory_word[7:0];
//        else if (wsel[1])
//            dmem[addre[31:1]] = memory_word[15:8];
//        else if (wsel[2])
//            dmem[addre[31:1]] = memory_word[23:16];
//        else if (wsel[3])
//            dmem[addre[31:1]] = memory_word[31:24];
//    end

endmodule
