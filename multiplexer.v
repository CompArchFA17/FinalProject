/*
4 input multiplexer
*/

module multiplexer4to1
#(parameter ENTRY_SIZE = 5)(
	input[1:0] res_sel,
	input [(9 * ENTRY_SIZE) - 1:0] AEplusBG, AFplusBH, CEplusDG, CFplusDH,
	output reg [(9 * ENTRY_SIZE) - 1:0] result
);
	always @(res_sel) begin
		case (res_sel)
			2'b00: begin result = AEplusBG; end
			2'b01: begin result = AFplusBH; end
			2'b10: begin result = CEplusDG; end
			2'b11: begin result = CFplusDH; end
		endcase
	end
endmodule