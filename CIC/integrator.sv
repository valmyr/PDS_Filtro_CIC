module integrator #(parameter WIDTH = 8)(input logic clock, ena, reset, input logic  [WIDTH-1:0] x_in, output logic  [WIDTH-1:0] y_out);


	//assign porque = x_in;
	always_ff@(posedge clock, negedge reset)begin
		if(!reset)begin
			y_out <= 0;
		end
		else begin
			y_out <= y_out+x_in;
		end
	end

endmodule
