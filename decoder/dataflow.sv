module dataflow_method (input logic A,B,EN,output logic [3:0]z);
assign z[0] = EN ? (A|B):1'b1;
assign z[1] = EN ? (A|~B):1'b1;
assign z[2] = EN ? (~A|B):1'b1;
assign z[3] = EN ? (~A|~B):1'b1;
endmodule

