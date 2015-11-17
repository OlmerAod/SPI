module  control_data_master (dout, dclk, cs, cnt, control_data_master, data_slave, data_in);

input              dclk;
input       [11:0] control_data_master;
input  wire [3:0]  cnt;
input  wire        cs;
input              data_slave;
output reg         dout;
output reg  [15:0] data_in;

always @(negedge dclk or posedge cs)
begin
	dout = control_data_master << 1;
	data_in[cnt] <= data_slave;
	if (cs)
	begin
		dout <= 0;
		data_in <= 0;
	end
end

endmodule 