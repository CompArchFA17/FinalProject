`include "RijndaelSbox" // this doesn't exist. Also, what is the appropriate extension for this

module SubBytes(
// takes in Rijndael's S-box (does it actually?), ARKOut
// outputs SBOut, where the input bytes have been confused
reg [4:4] ARKOut;

wire [4:4] SBOut;

);


// for each entry of ARKOut

// split into Most Significant 4 bits & Least Significant 4 bits

// for 4 most significant bits, that corresponds to the ROW in Rijndael's S-box

// for the 4 least significant bits, that corresponds to the COLUMN in Rijndael's S-box

// That creates the new entry in SBOut


endmodule

