    .text
    .globl _start

_start:
    # Load Immediate and Arithmetic Instructions
    li x1, 5                 # Load immediate 5 into x1
    li x2, -10                # Load immediate -10 into x2
    add x3, x1, x2           # x3 = x1 + x2 = 5 + 10 = 15
    sub x4, x3, x1           # x4 = x3 - x1 = 15 - 5 = 10
    xor x5, x3, x4           # x5 = x3 ^ x4 (bitwise XOR)
    or x6, x1, x2            # x6 = x1 | x2 (bitwise OR)
    and x7, x1, x2           # x7 = x1 & x2 (bitwise AND)
    sll x8, x1, x2           # x8 = x1 << x2 (logical shift left)
    srl x9, x2, x1           # x9 = x2 >> x1 (logical shift right)
    sra x10, x2, x1          # x10 = x2 >>> x1 (arithmetic shift right)

    # SLT and SLTU
    slt x11, x1, x2          # x11 = (x1 < x2) ? 1 : 0 (signed)
    sltu x12, x2, x1         # x12 = (x2 < x1) ? 1 : 0 (unsigned)

    # Load and Store Instructions
    li x13, 48               # Load a valid (multiple of 4) dummy memory address (0x30) 
    li x2, 0xABCDE           # Load a valid (within 20 bits) test value (0xABCDE)
    sw x2, 0(x13)            # Store word (x2) to memory address x13
    lw x14, 0(x13)           # Load word from memory address x13 into x14
    sh x2, 4(x13)            # Store halfword (x2) into memory at address 0x34
    lh x15, 4(x13)           # Load halfword from memory into x15 (address 0x34)
    sb x2, 8(x13)            # Store byte (x2) into memory at address 0x38
    lb x16, 8(x13)           # Load byte from memory into x16 (address 0x38)

    # Immediate Arithmetic
    addi x18, x1, 3          # x18 = x1 + 3
    xori x19, x2, 0xFF       # x19 = x2 ^ 0xFF
    ori x20, x1, 0xF0        # x20 = x1 | 0xF0
    andi x21, x2, 0x0F       # x21 = x2 & 0x0F

    # Branch Instructions
#     beq x1, x2, label1       # Branch if x1 == x2 (should NOT branch)
# #     bne x1, x2, label1       # Branch if x1 != x2 (should branch)
# #     blt x1, x2, label1       # Branch if x1 < x2 (signed)
# #     bge x1, x2, label2       # Branch if x1 >= x2 (signed, should NOT branch)
# #     bltu x1, x2, label1      # Branch if x1 < x2 (unsigned)
#     bgeu x1, x2, label2      # Branch if x1 >= x2 (unsigned, should NOT branch)
    # Test jalr
    li x22, 8
    jalr x23, x22, 4         # Jump to x22 + 4 and store return address

# Test BLTU: Should branch since x1 < x2 (unsigned)

addi x1, x0, -50       # Load -50 into x1 (unsigned value)
addi x2, x0, 1      # Load 1 into x2 (unsigned value)

bltu x1, x2, label   # Branch to 'label' if x1 < x2 (unsigned)
addi x3, x0, 6                    # No operation (executed if branch is not taken)
label:
addi x3, x0, 11       # Load 1 into x3 (executed if branch is taken)

label1:
    # Jump Instructions
#     jal x22, label2          # Jump and link to label2
    
label2:
    # LUI and AUIPC
    lui x24, 0x100           # Load upper immediate (0x100 << 12)
    auipc x25, 0             # Set x25 to PC + immediate (here it's 0)

    # End the program
    li x10, 0                # Exit status 0
    ecall                    # End simulation
