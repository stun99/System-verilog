module beh_method (input logic A,B,EN,output logic [3:0]z);

always_comb begin
z = 4'b0000;
    casez ({A, B, EN})
      3'b??0: z = 4'b1111;
      3'b001: z = 4'b1110;    
      3'b011: z = 4'b1101;    
      3'b101: z = 4'b1011;  
      3'b111: z = 4'b0111; 
    endcase
end
endmodule
