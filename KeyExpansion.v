module KeyExpansion(
input [31:0] inarray,
input i, //iteration number
output [31:0] outarray
);


assign outarray = {inarray[23:0], inarray[31:24]};

endmodule
