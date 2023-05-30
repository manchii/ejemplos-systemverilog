

module fib (
    input logic clk, rst,
    input logic [4:0] i,
    input logic start,
    output logic done,
    output logic [19:0] result
);

    logic en, rst_ctl, mux;

    calc i_calc(
        .clk(clk), 
        .rst(rst),
        .mux(mux), 
        .en(en), 
        .rst_ctl(rst_ctl),
        .result(result)
    );

    fsm i_fsm(
        .clk(clk), 
        .rst(rst), 
        .i(i),
        .start(start),
        .done(done), 
        .mux(mux), 
        .en(en), 
        .rst_ctl(rst_ctl)
    );


endmodule