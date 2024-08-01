//Codigo de simulacion siempre se hace secuencial

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
    //tasks permiten delays en tiempo de simulacion
    repeat(n) @(posedge clk);
endtask


initial begin
    clk <= 0;
    rst <= 1; // toda simulacion inicia con reset en alto
    start <= 0;
    i <= 0;
end

function automatic int fib_ref(int num);
    //functions NO permiten delays en tiempo de simulacion
    if(num == 0 )begin
        fib_ref = 0;
    end
    else if(num == 1) begin
        fib_ref = 1;
    end 
    else begin
        fib_ref = fib_ref(num - 1)+fib_ref(num - 2);
    end
endfunction

task automatic test_sequence(bit [4:0] num);
    i<= num;
    start<=1;
    wait_n_clks(1);
    start<=0;
    wait(done==1);
    wait_n_clks(1);
    if(result != fib_ref(num)) begin
        $display("ERROR");
        $finish;
    end
    $display($sformatf("SUCCESS Index: %0d result: %0d expect: %0d",num,result, fib_ref(num)));
    wait_n_clks(10);
endtask



initial begin
    wait_n_clks(10);
    rst <= 0;
    wait_n_clks(10);
    repeat(10) begin
        test_sequence($random());
    end
    $finish;
end

endmodule