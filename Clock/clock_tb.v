module tb;
reg clk;
reg rst;
reg leap;

wire [3:0] mon;
wire [4:0] day;
wire [4:0] hrs;
wire [5:0] min;
wire [5:0] sec;

hw21 KABALI (clk, rst, leap, mon, day, hrs, min, sec);

initial
	begin
		clk=0;
		rst=1;
		leap = 1;
		#2;
		rst=0;
		wait (mon==11);
		wait (day==30);
		wait (hrs==23);
		wait (min==59);
		wait (sec==59);
		/*
		force tb.KABALI.mon=2;
		force tb.KABALI.day=27;
		force tb.KABALI.hrs=23;
		force tb.KABALI.min=59;
		force tb.KABALI.sec=59;
		
		release tb.KABALI.mon;
		release tb.KABALI.day;
		release tb.KABALI.hrs;
		release tb.KABALI.min;
		release tb.KABALI.sec;
		*/
		$finish;
	end

always #5 clk =!clk;

endmodule
