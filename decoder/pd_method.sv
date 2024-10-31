module pg_method (
    input logic A, B, EN,
    output logic [3:0] z
);
    logic Abar, Bbar;

    not v0 (Abar, A);
    not v1 (Bbar, B);
    nand n0 (z[0], Abar, Bbar, EN);
    nand n1 (z[1], Abar, B, EN);
    nand n2 (z[2], A, Bbar, EN);
    nand n3 (z[3], A, B, EN);
endmodule

