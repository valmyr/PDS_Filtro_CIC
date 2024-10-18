module DEC2SEG7(input logic [3:0] IN, input logic EN, output logic [7:0] OUT);
	always_comb
	 if(EN)
		case(IN)
		0:OUT = 8'b11_000000;
		1:OUT = 8'b11_111001;
		2:OUT = 8'b10_100100;
		3:OUT = 8'b10_110000;
		4:OUT = 8'b10_011001;
		5:OUT = 8'b10_010010;
		6:OUT = 8'b10_000010;
		7:OUT = 8'b11_111000;
		8:OUT = 8'b10_000000;
		9:OUT = 8'b10_010000;
		default: OUT = 8'b11_111111;
	endcase
	else OUT = 8'b11_111111;
endmodule