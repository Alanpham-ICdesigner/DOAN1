`timescale 1ns / 1ps

module top_pynq_pipeline (
    input  logic        sysclk,
    input  logic [3:0]  btn,
    output logic [3:0]  led
);

    logic [31:0] div_cnt = 32'd0;
    logic        cpu_clk_raw;
    logic        cpu_clk;

    always_ff @(posedge sysclk) begin
        div_cnt <= div_cnt + 1'b1;
    end

    assign cpu_clk_raw = div_cnt[7];

    BUFG bufg_cpu_clk (
        .I(cpu_clk_raw),
        .O(cpu_clk)
    );

    logic rst_n_meta, rst_n_cpu;

    always_ff @(posedge cpu_clk) begin
        rst_n_meta <= ~btn[0];   // BTN0 nhấn = reset
        rst_n_cpu  <= rst_n_meta;
    end

    logic [2:0] btn_cpu;

    always_ff @(posedge cpu_clk) begin
        btn_cpu <= btn[3:1];
    end

    logic [31:0] i_io_sw;
    assign i_io_sw = {29'b0, btn_cpu};

    logic [31:0] o_pc_debug;
    logic        o_insn_vld;
    logic        o_ctrl;
    logic        o_mispred;

    logic [31:0] o_io_ledr;
    logic [31:0] o_io_ledg;
    logic [31:0] o_io_lcd;

    logic [6:0]  o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;
    logic [6:0]  o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7;

    assign led = o_io_ledr[3:0];

    pipelined your_cpu (
        .i_clk       (cpu_clk),
        .i_reset     (rst_n_cpu),

        .i_io_sw     (i_io_sw),

        .o_pc_debug  (o_pc_debug),
        .o_insn_vld  (o_insn_vld),
        .o_ctrl      (o_ctrl),
        .o_mispred   (o_mispred),

        .o_io_ledr   (o_io_ledr),
        .o_io_ledg   (o_io_ledg),

        .o_io_hex0   (o_io_hex0),
        .o_io_hex1   (o_io_hex1),
        .o_io_hex2   (o_io_hex2),
        .o_io_hex3   (o_io_hex3),
        .o_io_hex4   (o_io_hex4),
        .o_io_hex5   (o_io_hex5),
        .o_io_hex6   (o_io_hex6),
        .o_io_hex7   (o_io_hex7),

        .o_io_lcd    (o_io_lcd)
    );

endmodule