module comb #(parameter WIDTH = 8)(
	input logic 				clock	,
	 							ena		, 
								reset	,
	input logic  [WIDTH-1:0] 	x_in	, 
	output logic  [WIDTH-1:0] 	y_out	
);
	logic  [WIDTH-1:0] regDelay;
	always_ff@(posedge clock, negedge reset)begin
		if(!reset)begin
			y_out 	<= 0;
			regDelay <= 0;
		end
		else begin
			regDelay <= x_in != 0 ?		   x_in 	: regDelay ;
			y_out	 <= x_in != 0 ? x_in - regDelay : y_out    ;
		end
	end
endmodule
