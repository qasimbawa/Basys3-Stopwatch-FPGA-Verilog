`timescale 1ns / 1ps

module pulse(
    input  wire clk,
    input  wire in,
    output wire pulse
);
    reg q1 = 1'b0;
    reg q2 = 1'b0;

    always @(posedge clk) begin
        q1 <= in;
        q2 <= q1;
    end

    assign pulse = q1 & ~q2;
endmodule
