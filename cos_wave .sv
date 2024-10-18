module cos_2pi1000t#(parameter N_SAMPLES = 100, WIDTH = 8)(input logic clock_fgen, nreset, output logic [WIDTH-1:0] wave_out_);
	
	logic[$clog2(N_SAMPLES)-1:0] counter;
	logic signed [WIDTH-1:0] cos_mem  [N_SAMPLES-1:0];
	logic [WIDTH-1:0] wave_out;
	//logic clock_fgen;
	initial $readmemh("./input2_t.txt",cos_mem);
  	always_ff@(posedge clock_fgen, negedge nreset)begin 
		if(!nreset)begin counter <= 0;
						 wave_out <=cos_mem[0];
		end else if(N_SAMPLES-1 == counter) begin counter <= 0;
			wave_out <= cos_mem[N_SAMPLES-1];
		end
		else begin counter <= counter + 1;
			wave_out <= cos_mem[counter];
		end
	end
	assign wave_out_ = wave_out;
endmodule