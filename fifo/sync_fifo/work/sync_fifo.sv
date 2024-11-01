module sync_fifo (input logic d, clk, rst, output logic [3:0] q);
always @ (posedge clk) begin
if(rst==1) begin

q=0;
end
else begin
q[0]<=d;
q[1]<=q[0];
q[2]<=q[1];
q[3]<=q[2];
end
end
endmodule

module top();
    logic d, clk, rst;
    logic [3:0] q;

    sync_fifo DUT(d, clk, rst, q);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin 
        $monitor("q0=%b, q1=%b, q2=%b, q3=%b, d=%b", q[0], q[1], q[2], q[3], d);
        rst = 1;
        #5;
        rst = 0;
        d = 1;
        #50;
        rst = 1;
        #15;
        rst = 0;
        d = 1;
        #50;
        $stop;
    end
endmodule