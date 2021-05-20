

module sound(
	input clk,
	input in,
	
	output out
);

reg sound = 1;
reg nsound = 1;

reg[14:0] licz = 0;
reg[14:0] nlicz = 0;
always@ (posedge clk)begin
	sound <= nsound;
	licz <= nlicz;
end

always@ ( * )begin
	
	if(in)begin
		if(licz < 32000) begin
			nsound = 0;
			nlicz = licz + 1;
			
		end else
		begin
		
			nlicz = licz;
			nsound = 1;
		end
	end else
	begin 
		nsound = 1;
		nlicz = 0;
	end
end

assign out = nsound;
endmodule
