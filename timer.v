`timescale 1ns / 1ps

module timer(
    input  wire clk,        
    input  wire start_stop,  
    input  wire reset,       
    input  wire [1:0] mode,         
    input  wire [7:0] preset,       
    output wire [3:0] an,
    output wire [6:0] sseg,
    output wire dp
);
    wire tick_10ms;
    wire tick_mux;

    clkdiv #(
        .COUNT_MAX(1_000_000 - 1)  
    ) tick10ms_gen (
        .clk(clk),
        .pulse(tick_10ms)
    );

    clkdiv #(
        .COUNT_MAX(100_000 - 1)   
    ) mux_gen (
        .clk(clk),
        .pulse(tick_mux)
    );

    wire start_pulse;
    wire reset_pulse;

    pulse start_onepulse (
        .clk(clk),
        .in(start_stop),
        .pulse(start_pulse)
    );

    pulse reset_onepulse (
        .clk(clk),
        .in(reset),
        .pulse(reset_pulse)
    );


    localparam IDLE = 1'b0;
    localparam RUN  = 1'b1;

    reg state = IDLE;


    reg [3:0] sec_tens  = 4'd0;
    reg [3:0] sec_ones  = 4'd0;
    reg [3:0] hund_tens = 4'd0;
    reg [3:0] hund_ones = 4'd0;

    wire at_zero = (sec_tens  == 4'd0) &&
                   (sec_ones  == 4'd0) &&
                   (hund_tens == 4'd0) &&
                   (hund_ones == 4'd0);

    wire at_max  = (sec_tens  == 4'd9) &&
                   (sec_ones  == 4'd9) &&
                   (hund_tens == 4'd9) &&
                   (hund_ones == 4'd9);

    wire count_up_mode   = (mode == 2'b00) || (mode == 2'b10);
    wire count_down_mode = (mode == 2'b01) || (mode == 2'b11);
    wire preset_mode     = (mode == 2'b10) || (mode == 2'b11);


    wire [3:0] preset_tens = (preset[7:4] <= 4'd9) ? preset[7:4] : 4'd0;
    wire [3:0] preset_ones = (preset[3:0] <= 4'd9) ? preset[3:0] : 4'd0;


    always @(posedge clk) begin
        if (start_pulse) begin
            state <= ~state;
        end

        if (reset_pulse) begin
            state <= IDLE;

            case (mode)
                2'b00: begin // up from 00.00
                    sec_tens  <= 4'd0;
                    sec_ones  <= 4'd0;
                    hund_tens <= 4'd0;
                    hund_ones <= 4'd0;
                end

                2'b01: begin // down from 99.99
                    sec_tens  <= 4'd9;
                    sec_ones  <= 4'd9;
                    hund_tens <= 4'd9;
                    hund_ones <= 4'd9;
                end

                2'b10: begin // up from preset seconds
                    sec_tens  <= preset_tens;
                    sec_ones  <= preset_ones;
                    hund_tens <= 4'd0;
                    hund_ones <= 4'd0;
                end

                2'b11: begin // down from preset seconds
                    sec_tens  <= preset_tens;
                    sec_ones  <= preset_ones;
                    hund_tens <= 4'd0;
                    hund_ones <= 4'd0;
                end
            endcase
        end
        else if (state == RUN && tick_10ms) begin
            if (count_up_mode) begin
                if (at_max) begin
                    state <= IDLE;
                end
                else begin
                    // BCD increment: SS.hh
                    if (hund_ones < 4'd9) begin
                        hund_ones <= hund_ones + 4'd1;
                    end
                    else begin
                        hund_ones <= 4'd0;
                        if (hund_tens < 4'd9) begin
                            hund_tens <= hund_tens + 4'd1;
                        end
                        else begin
                            hund_tens <= 4'd0;
                            if (sec_ones < 4'd9) begin
                                sec_ones <= sec_ones + 4'd1;
                            end
                            else begin
                                sec_ones <= 4'd0;
                                if (sec_tens < 4'd9) begin
                                    sec_tens <= sec_tens + 4'd1;
                                end
                                else begin
                                    // Should only happen at max
                                    sec_tens <= 4'd9;
                                    sec_ones <= 4'd9;
                                    hund_tens <= 4'd9;
                                    hund_ones <= 4'd9;
                                    state <= IDLE;
                                end
                            end
                        end
                    end
                end
            end
            else if (count_down_mode) begin
                if (at_zero) begin
                    state <= IDLE;
                end
                else begin
                    // BCD decrement: SS.hh
                    if (hund_ones > 4'd0) begin
                        hund_ones <= hund_ones - 4'd1;
                    end
                    else begin
                        hund_ones <= 4'd9;
                        if (hund_tens > 4'd0) begin
                            hund_tens <= hund_tens - 4'd1;
                        end
                        else begin
                            hund_tens <= 4'd9;
                            if (sec_ones > 4'd0) begin
                                sec_ones <= sec_ones - 4'd1;
                            end
                            else begin
                                sec_ones <= 4'd9;
                                if (sec_tens > 4'd0) begin
                                    sec_tens <= sec_tens - 4'd1;
                                end
                                else begin
                                    sec_tens <= 4'd0;
                                    sec_ones <= 4'd0;
                                    hund_tens <= 4'd0;
                                    hund_ones <= 4'd0;
                                    state <= IDLE;
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    reg [1:0] mux_sel = 2'b00;
    always @(posedge clk) begin
        if (tick_mux) begin
            mux_sel <= mux_sel + 2'b01;
        end
    end

    reg [3:0] digit;
    reg [3:0] an_reg;

    always @(*) begin
        case (mux_sel)
            2'b00: begin
                digit  = hund_ones;
                an_reg = 4'b1110;
            end
            2'b01: begin
                digit  = hund_tens;
                an_reg = 4'b1101;
            end
            2'b10: begin
                digit  = sec_ones;
                an_reg = 4'b1011;
            end
            default: begin
                digit  = sec_tens;
                an_reg = 4'b0111;
            end
        endcase
    end

    assign an = an_reg;
    assign dp = (mux_sel == 2'b10) ? 1'b0 : 1'b1; 
    hexto7segment seg_dec (
        .x(digit),
        .r(sseg)
    );
endmodule