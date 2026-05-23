`timescale 1ns/1ps

module alu8_tb;

reg [7:0] A;
reg [7:0] B;
reg [2:0] opcode;

wire [7:0] result;
wire carry;
wire zero;

alu8 uut(
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry),
    .zero(zero)
);

initial begin

    $dumpfile("alu8.vcd");
    $dumpvars(0, alu8_tb);

    A = 8'd10;
    B = 8'd5;

    opcode = 3'b000;
    #10;

    opcode = 3'b001;
    #10;

    opcode = 3'b010;
    #10;

    opcode = 3'b011;
    #10;

    opcode = 3'b100;
    #10;

    opcode = 3'b101;
    #10;

    opcode = 3'b110;
    #10;

    opcode = 3'b111;
    #10;

    $finish;

end

endmodule
