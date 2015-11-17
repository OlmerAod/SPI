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
	watchdog <= 1'b0;
	dclk <= 1'b1;
end

always @(negedge clk)
begin
	if (~cs)
		cnt <= cnt + 1;
	else
	begin
		cnt <= 0;
	end
end

always
begin
	if (cs)
		begin
			dclk <= 1;
		end
	else
		if (~cs)
			begin
				if (invert)
					dclk <= dclk + 1;
				else
					dclk <= dclk - 1;
			end
	if (work)
		begin
			if (watchdog)
				cs <= 1;				
			else
				cs <= 0;
		end
	else
		begin
			cs <= 1;
			if (cnt == 15)
				begin
					watchdog <= 1;
					#50 watchdog <= 0;
				end
		end
end

always @(posedge work)
begin
	if (clk)
		invert <= 0;	
	else 
		invert <= 1;
end

endmodule 