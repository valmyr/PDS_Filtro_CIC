`include "pwm.sv"
`include "integrator.sv"
`include "divClock.sv"
`include "comb.sv"
`include "sawtooth_wave.sv"
`include "cos_wave .sv" 
`include "filtro_em_cascata.sv"
module tb();
  logic [7:0] A,saida_filtro;
  logic clock,C,nreset1,nreset2,clock_fgen;
  
  
  pwm pwm_inst0(
    .A(A),
    .C(C1),
    .clock(clock),
    .nreset(nreset1)
  );

    pwm pwm_inst1(
    .A(saida_filtro),
    .C(C2),
    .clock(clock),
    .nreset(nreset1)
  );
// xrun test_pwm.sv -access +rw -input restore.tcl
  divClock#(.freq(200_000)) newClock2 (.iclock(clock), .nreset(nreset1), .oclock(clock_fgen));
  filter#(.WIDTH(8), .SIZE(5))CIC_filter(.clock(clock_fgen),.reset(nreset2),.x_in(A),.y_out(saida_filtro));

  cos_2pi1000t  cos_t
  (
    .clock_fgen(clock_fgen)		,
    .nreset(nreset1)			,
    .wave_out(A)
  );

  initial begin
        	clock = 0;
    	#2nreset1 = 0;
    	#2nreset1  =1;

      #2nreset2 = 0;
    	#2nreset2  =1;
    	
    
    //$dumpvars(0,pwm.mod.wave_out,pwm.mod.wave_out);
    //$dumpfile("graphic.vcd");
    #10000000$finish;
    	
  end
  
  always #1 clock = ~ clock;
endmodule 