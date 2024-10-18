module MULTIPLAXDISP(input clock,input nreset, input logic [3:0] D0,D1,D2,D3,D4,D5,D6,D7,output logic[7:0] DATA, output logic [7:0] CONTROL);

	logic [6:0] RDATA [7:0];
	logic [7:0] RCONTROL;
	logic ENA;
	DEC2SEG7 SEG7Inst0(.EN(ENA),.IN(D0),.OUT(RDATA[0]));
	DEC2SEG7 SEG7Inst1(.EN(ENA),.IN(D1),.OUT(RDATA[1]));
	DEC2SEG7 SEG7Inst2(.EN(ENA),.IN(D2),.OUT(RDATA[2]));
	DEC2SEG7 SEG7Inst3(.EN(ENA),.IN(D3),.OUT(RDATA[3]));
	DEC2SEG7 SEG7Inst4(.EN(ENA),.IN(D4),.OUT(RDATA[4]));
	DEC2SEG7 SEG7Inst5(.EN(ENA),.IN(D5),.OUT(RDATA[5]));
	DEC2SEG7 SEG7Inst6(.EN(ENA),.IN(D6),.OUT(RDATA[6]));
	DEC2SEG7 SEG7Inst7(.EN(ENA),.IN(D7),.OUT(RDATA[7]));
	always_ff@(posedge clock, negedge nreset)begin
			if(!nreset)begin
				ENA <= 1;
				RCONTROL <= 6'b000_001;
			end
			else begin
				RCONTROL <= RCONTROL == 128 ? 1: RCONTROL << 1 ;
			end
	end
	
	always_comb case(RCONTROL)
		'b00000_001:DATA = RDATA[0];
		'b00000_010:DATA = RDATA[1];
		'b00000_100:DATA = RDATA[2];
		'b00001_000:DATA = RDATA[3];
		'b00010_000:DATA = RDATA[4];
		'b00100_000:DATA = RDATA[5];
		'b01000_000:DATA = RDATA[6];
		'b10000_000:DATA = RDATA[7];
		default:DATA=0;
	endcase
	always_comb CONTROL = ~RCONTROL;
endmodule