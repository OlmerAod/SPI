`timescale 1ns / 1ps
module dclk_cs_form (clk, dclk, work, cs, cnt);

input   wire      work;
input   wire      clk;
output  reg	      dclk;
output  reg       cs;
output  reg [3:0] cnt; 

reg invert, watchdog;

initial 
begin
	cnt <=4'b0000;
	cs <= 1'b1;
	dclk <= 1'b1;
	invert <= 0;
	watchdog <= 0;
end

always @(posedge work)
begin
	if (clk)
		invert <= 0;	
	else 
		invert <= 1;
end

always @(negedge dclk)
begin
	if (~cs)
		cnt <= cnt + 1;
	else
		cnt <= 0;
	if (cnt == 15)
		watchdog <= 1;
	else
		watchdog <= 0;
	if (work)
		cs<=0;
	else
		cs <= 1;
end

always
begin
	if (cs)
			dclk <= 1;
	else
		begin
			if (~watchdog)
				begin
					if (invert)
							dclk <= dclk + 1;
					else
							dclk <= dclk - 1;
				end
			//else
				//dclk <= 1;
		end
end

endmodule 