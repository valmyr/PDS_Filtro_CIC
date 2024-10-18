
module sawtooth_wave#(parameter N_SAMPLES = 100, WIDTH = 8,Freq=100)(input logic clock_fgen, nreset, output logic signed [WIDTH-1:0] wave_out);
	
	logic[$clog2(N_SAMPLES)-1:0] counter;
	logic signed [WIDTH-1:0] sawtooth_mem  [N_SAMPLES-1:0];
	initial $readmemb("./trian.txt",sawtooth_mem);
  	always_ff@(posedge clock_fgen, negedge nreset)begin
		if(!nreset)begin
			counter <= 0;
			wave_out <= sawtooth_mem[0]-64;
		end else if((N_SAMPLES-1 == counter) ) begin
					counter <= 0;
					wave_out <=sawtooth_mem[0]-64;
		end else begin counter <= counter + 1;	
		wave_out = sawtooth_mem[counter]-64;
		end
 	end
endmodule