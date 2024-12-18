`include "./pd_method.sv"
`include "./dataflow.sv"
`include "./beh.sv"

module top;
    logic A, B, EN;
    logic [3:0] z, z1,z2,z3;  
    logic [1:0] s;

    function void decoder (input [1:0] s, input EN, output reg [3:0] y);
        begin
            y = 4'b1111; 
            if(EN)
            y[s] = 1'b0;
            else
            y[s] = 1'b1;
        end
    endfunction

    pg_method DUT (A, B, EN, z1);
    dataflow_method DUT1 (A, B, EN, z2);
    beh_method DUT2 (A, B, EN, z3);

    initial begin
        for (int i = 0; i < 8; i = i + 1) begin
            {EN, A, B} = i;  
            
    
            s[0] = B;
            s[1] = A;

            decoder(s, EN, z);
	#5;
            if ((z1 == z) & (z2 ==z) & (z3 ==z)) 
               $display("Match: A = %b B = %b EN = %b | z = %b |z1 = %b | z2 = %b | z3 = %b", A, B, EN, z,z1,z2,z3);
            else begin
               $display("Mismatch: A = %b B = %b EN = %b | z = %b, z1 = %b, z2 = %b, z3 = %b", A, B, EN, z, z1, z2, z3);
		$stop; 
		end
        end
    end
endmodule





