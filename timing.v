

module counter50 (
	input clk0,
	output clk
);

// 1 MHz
reg[5:0] lic = 6'b0;
reg[5:0] nlic = 6'b0;

reg clka = 1'b0;
reg nclka = 1'b0;

always@( posedge clk0 )begin
	clka <= nclka;
	lic <= nlic;
end

always@ ( * )begin
	nlic = lic + 1;
	nclka = clka;
	
	if(nlic == 6'd39) begin
		nclka = ~clka;
		nlic = 6'b0;
	end
end

assign clk = nclka;

endmodule


module div_input(
	input clk,
	output clkm
);

reg[15:0] licz;
reg clka = 0;

always@(posedge clk)begin
	licz = licz + 1;
	
	if(licz == 25000)begin
		licz = 0;
		clka = ~clka;
	end

end

assign clkm = clka;
endmodule