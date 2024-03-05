

module fsm (
    input logic clk, rst, 
    input logic [4:0] i,
    input logic start,
    output logic done, 
    output logic mux, 
    output logic en, 
    output logic rst_ctl
);

localparam [2:0] 
    INIT   = 3'b000,
    IDLE   = 3'b001,
    CASE_0 = 3'b010,
    LOAD   = 3'b011,
    CALC   = 3'b100,
    FINAL  = 3'b101;

logic [2:0] states, next_state;

logic [4:0] counter; 
logic incr;

// Secuencial

always_ff@(posedge clk, posedge rst) begin   
    if(rst) begin 
        states <= INIT;
    end else 
        states <= next_state;
end

// Combinacional
always_comb begin
    next_state = states;
    done='b0; mux='b0;
    en='b0; rst_ctl='b0;
    incr = 1'b0;
    case(states)
        INIT: begin
            next_state=IDLE;
            rst_ctl='b1;
        end
        IDLE: begin
            if(start)
                next_state=CASE_0;
        end
        CASE_0: begin
            rst_ctl='b1;
            if(i=='b0)
                next_state=FINAL;
            else
                next_state=LOAD;
        end
        LOAD: begin
            next_state=CALC;
            mux='b1;
            en='b1;
        end
        CALC: begin
            en='b1;
            incr = 'b1;
            if((counter+'d2)>=i)begin
                incr = 'b0;
                en='b0;
                next_state=FINAL;
            end
        end
        FINAL: begin
            next_state=IDLE;
            done='b1;
        end
        default:
            next_state=INIT;
    endcase
end

//counter 

always_ff@(posedge clk, posedge rst) begin
    if(rst)
        counter <= 'b0;
    else
        if(incr)
            counter <= counter+'b1;
        else 
            counter <= 'b0;
end


endmodule