

module tb ();

logic clk, rst, start,done;
logic [4:0] i;
logic [19:0] result;

fib dut(
    .clk(clk), 
    .rst(rst),
    .i(i),
    .start(start),
    .done(done),
    .result(result)
);

always begin
    #5;
    clk = ~clk;
end

task automatic wait_n_clks(int n);
    repeat(n) @(posedge clk);
endtask


initial begin
    clk <= 0;
    rst <= 1;
    start <= 0;
    i <= 0;
end

//0,1,2,3,4,5,6, 7, 8, 9
//0,1,1,2,3,5,8,13,21,34

task automatic test_sequence(bit [4:0] num);
    i<= num;
    start<=1;
    wait_n_clks(1);
    start<=0;
    wait(done==1);
    wait_n_clks(1);
    $display($sformatf("Index: %0d result: %0d",num,result));
    wait_n_clks(10);
endtask



initial begin
    wait_n_clks(10);
    rst <= 0;
    wait_n_clks(10);
    repeat(10)
        test_sequence($random());
    $finish;
end

endmodule