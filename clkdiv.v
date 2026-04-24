`timescale 1ns / 1ps

module clkdiv #(
    parameter integer COUNT_MAX = 100_000 - 1
)(
    input  wire clk,
    output reg  pulse = 1'b0
);
    localparam WIDTH = $clog2(COUNT_MAX + 1);
    reg [WIDTH-1:0] count = {WIDTH{1'b0}};

    always @(posedge clk) begin
        if (count == COUNT_MAX) begin
            count <= {WIDTH{1'b0}};
            pulse <= 1'b1;
        end
        else begin
            count <= count + 1'b1;
            pulse <= 1'b0;
        end
    end
endmodule
