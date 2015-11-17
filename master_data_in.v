module master_data_in (dclk, cs, data_slave, data_in);

input              dclk;

input  wire        cs;


reg [3:0] cnt;

always
if (~cs)

else


endmodule 