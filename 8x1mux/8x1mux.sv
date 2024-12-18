`include "./mux.sv"

module mux8x1 (input [2:0] s, input [7:0] e, output logic y);
    logic y0, y1;
    mux a0(.s(s[1:0]), .e(e[3:0]), .y(y0));
    mux a1(.s(s[1:0]), .e(e[7:4]), .y(y1));
    assign y = (s[2] == 0) ? y0 : y1;
endmodule

module top;
    logic [2:0] s;
    logic [7:0] e;
    logic y;
    logic y_exp;

    mux8x1 DUT (s, e, y);

    task self_check_mux(input [7:0] e, input [2:0] s, output logic y_exp);
    begin
        y_exp = e[s];
    end
    endtask

    initial begin
        repeat(500) begin
            e = $random;
            s = $random;
            self_check_mux(e, s, y_exp);
	#5;
           if (y_exp !== y)
	    $monitor("MISMATCH: time= %t, s=%d, e=%b, y=%b, y_exp=%b", $time, s, e, y, y_exp);    
        else
            $monitor("MATCHED:  time= %t, s=%d, e=%b, y=%b, y_exp=%b", $time, s, e, y, y_exp);            
        end         
    end
endmodule

