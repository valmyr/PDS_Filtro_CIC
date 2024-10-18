
module pwm#(parameter freq = 60)(
	input logic    clock,
  input logic signed [7:0] A	,
  input logic nreset	,
  output logic  C		
);
  
  logic signed [7:0] B;
  sawtooth_wave sawtooth(
    .clock_fgen(clock)			,
    .nreset(nreset)		,
    .wave_out(B)
  );
  assign C = A > B;
  
endmodule