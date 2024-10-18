module alinxModTest(
        input logic             RESET           ,
        input logic  [2:0]      KEY             ,
		  input logic 				  CLK					,

        output logic [7:0]      DISPLAY7SEG     ,
		  output logic [7:0]      CONTROL7SEG     ,
        output logic [0:3]      LED             ,
        output logic            BUZZER          ,

        //SD Card SLOT
        input logic     SD_NCS                  ,
        input logic     SD_DIN                  ,
        input logic     SD_CLK                  ,
        output logic    SD_DOUT                 ,
        //USB2UART
        input logic     RXD                     ,
        output logic    TXD                     ,
        //RTC Real-Time CLOCK
        input logic     RTC_SCLK                ,
        input logic     RTC_nRST                ,
        input logic     RTC_DATA                ,
        //EEPROM I2C            
        input logic     SDA                     ,
        input logic     SCL                     ,
        //SDRAM HY57V2562GTR                    
        input logic             S_CLK           ,
        input logic             S_CKE           ,
        input logic             S_NCS           ,
        input logic             S_NWE           ,
        input logic             S_NCAS          ,
        input logic             S_NRAS          ,
        input logic [1: 0]      S_DQM           ,
        input logic [1: 0]      S_BA            ,
        input logic [12:0]      S_A             ,
        input logic [15:0]      S_DB            ,
        // VGA Port                             
        output logic [15:0]     VGA_D           ,
        output logic            VGA_HS          ,
        output logic            VGA_VS          ,
        //Expansion Port
        input logic [16:0]      INPUT_GEN       ,
        output logic[16:0]      OUTPUT_GEN      						
);
		logic clk_;
		logic baud_clock;
		logic [3:0] HEX0;
		logic [3:0] HEX1;
		logic [3:0] HEX2;
		logic [3:0] HEX3;
		logic [3:0] HEX4;
		logic [3:0] HEX5;
		logic [3:0] HEX6;
		logic [3:0] HEX7;
		logic [$clog2(999999)+1:0] counter;
		
		MULTIPLAXDISP MULTIPLEXADOR_Control(
		
						.clock(clk_)				,
						.nreset(KEY[0])			,
						.D0(HEX0)					,
						.D1(HEX1)					,
						.D2(HEX2)					,
						.D3(HEX3)					,
						.D4(HEX4)					,
						.D5(HEX5)					,
						.D6(HEX6)					,
						.D7(HEX7)					,
						.DATA(DISPLAY7SEG)		,
						.CONTROL(CONTROL7SEG)
		);
		
		divClock #(.freq(720))divClockIns0(
		
						.iclock(CLK)				,
						.nreset(KEY[0])				,
						.oclock(clk_)
		);
		
		divClock #(.freq(10))divClockIns1(
						.iclock(CLK)				,
						.nreset(KEY[0])				,
						.oclock()
		);
		divClock #(.freq(22050*2))divClockIns2(
						.iclock(CLK)				,
						.nreset(KEY[0])				,
						.oclock(baud_clock)
		);
		
		
		
		
		
	//assign HEX3 = 8;
	//assign HEX4 = 2;

    
	/*
	uart_rxfun#(.CLK_FRE(50),.BAUD_RATE(115200))(
		.clk(CLK),              //clock input
		.rst_n(KEY[2]),         //asynchronous reset input, low active 
		.rx_data(a),          	//received serial data
		.rx_data_valid(LED[0]), //received serial data is valid
		.rx_data_ready(KEY[1]), //data receiver module ready
		.rx_pin(RXD)            //serial data input
	);*/
	logic clock_pwm,clock_signal;
	logic signed [7:0] A0,Y1;
	logic [7:0] a;
	divClock#(.freq(50)) newClock1 (.iclock(CLK), .nreset(KEY[0]), .oclock(clock_signal));
	divClock#(.freq(800_000)) newClock2 (.iclock(CLK), .nreset(KEY[0]), .oclock(clock_pwm));
	cos_2pi1000t#( .N_SAMPLES(240), .WIDTH(8)) cosi (.clock_fgen(clock_signal), .nreset(KEY[0]),.wave_out_(A0));
	pwm pwm_inst0(
     	.A(A0)							,
     	.C(OUTPUT_GEN[0])				,
    	.clock(clock_pwm) 			,
     	.nreset(KEY[0])
	);
	pwm pwm_inst1(
     	.A(Y1)						,
     	.C(OUTPUT_GEN[1])			,
     	.clock(clock_pwm)			,
     	.nreset(KEY[0])
	);
	filter #(.WIDTH(8),.SIZE(5))movingAverageFilter(
		.clock	(	clock_signal	)		,
		.reset	(	KEY[0]		)		,
		.x_in		(	A0				)		,
		.y_out	(	Y1				)	
	);
   	assign a = A0;
	assign LED[2] = A0 ;
	assign LED[1] = OUTPUT_GEN[0] ;
	assign HEX2 = a%10;
	assign HEX3 = (a/10);
endmodule