module divClock#(parameter freq = 60)(input logic iclock, nreset, output logic oclock);
	logic [$clog2(50_000_000)+1		:0] counter			;
	logic [$clog2(50_000_000)+1:0]	stopCounter = 50_000_000/(2*freq);
	always_ff@(negedge iclock)
		if			(!nreset)begin 				counter <= 0;
												oclock  <= 0;
		end
		else if	(stopCounter-1 == counter)begin	counter <= 0;
												oclock  <= ~oclock;
		end
		else begin 								counter <= counter + 1;
											
		end
		
endmodule

