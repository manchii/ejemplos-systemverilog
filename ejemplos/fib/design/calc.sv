

module calc (
    input logic clk, rst,
    input logic mux, 
    input logic en, 
    input logic rst_ctl,
    output logic [19:0] result
);

    logic [19:0] Fn1, Fn2;
    logic [19:0] suma;
    logic rst_reg;

    assign rst_reg = rst | rst_ctl;

    //Registros
    always_ff@(posedge clk,rst_reg) begin
        Fn1 <= Fn1;
        Fn2 <= Fn2;
        if(rst_ctl)begin
            Fn1 <= 'b0;
            Fn2 <= 'b0;
        end else if(en)begin
            Fn1 <= (mux)? 'b1 : suma;
            Fn2 <= (mux)? 'b0 : Fn1;
        end
    end

    //Suma
    always_comb begin 
        suma = Fn1 + Fn2;
    end

    assign result = suma;



endmodule