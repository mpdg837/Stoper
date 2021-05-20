
module count(
	input mode,
	input clear,
	input in,
	input on,
	output restarted,
	
	output[3:0] liczba0,
	output[3:0] liczba1,
	output[3:0] liczba2,
	output[3:0] liczba3,
	
	
	output[3:0] save0,
	output[3:0] save1,
	output[3:0] save2,
	output[3:0] save3,
	output[3:0] save4,
	output[3:0] save5,
	output[3:0] save6
	
);

reg[3:0] wliczba01 = 4'd0;
reg[3:0] wliczba0 = 4'd0;
reg[3:0] wliczba1 = 4'd0;
reg[3:0] wliczba2 = 4'd0;
reg[3:0] wliczba3 = 4'd0;

reg[3:0] nliczba0 = 4'd0;
reg[3:0] nliczba1 = 4'd0;
reg[3:0] nliczba2 = 4'd0;
reg[3:0] nliczba3 = 4'd0;
reg[3:0] nliczba4 = 4'd0;
reg[3:0] nliczba5 = 4'd0;
reg[3:0] nliczba6 = 4'd0;

reg[3:0] nnliczba0 = 4'd0;
reg[3:0] nnliczba1 = 4'd0;
reg[3:0] nnliczba2 = 4'd0;
reg[3:0] nnliczba3 = 4'd0;

reg[3:0] nnliczba4 = 4'd0;
reg[3:0] nnliczba5 = 4'd0;
reg[3:0] nnliczba6 = 4'd0;

reg restartedx = 1;
reg nrestarted = 1;

always@ (posedge in)begin
	if(~ clear && on)begin

		nliczba6 <= 0;
		nliczba5 <= 0;
		nliczba4 <= 0;
		nliczba3 <= 0;
		nliczba2 <= 0;
		nliczba1 <= 0;
		nliczba0 <= 0;
		
		restartedx <= 1;
	end else 
	begin
		nliczba0 <= nnliczba0;
		nliczba1 <= nnliczba1;
		nliczba2 <= nnliczba2;
		nliczba3 <= nnliczba3;
		nliczba4 <= nnliczba4;
		nliczba5 <= nnliczba5;
		nliczba6 <= nnliczba6;
		wliczba01 <= nnliczba3;
		
		restartedx <= nrestarted;
	end
end


always@ (*)begin

	nrestarted = restarted;
	nnliczba0 = nliczba0;
	nnliczba1 = nliczba1;
	nnliczba2 = nliczba2;
	nnliczba3 = nliczba3;
	nnliczba4 = nliczba4;
	nnliczba5 = nliczba5;
	nnliczba6 = nliczba6;
	
	wliczba0 = 4'd11;
	wliczba1 = 4'd11;
	wliczba2 = 4'd11;
	wliczba3 = 4'd11;
	
	if(~ on)begin
		nrestarted = 0;
		
		nnliczba0 = nliczba0 + 1;
		if(nnliczba0 >9) begin
			nnliczba0 = 0;
			nnliczba1 = nliczba1 + 1;
		end
		
		
		if(nnliczba1 >9) begin
			nnliczba1 = 0;
			nnliczba2 = nliczba2 + 1;
		end
		
		if(nnliczba2 >9) begin
			nnliczba2 = 0;
			nnliczba3 = nliczba3 + 1;
		end
		
		if(nnliczba3 >9) begin
			nnliczba3 = 0;
			nnliczba4 = nliczba4 + 1;
		end
		
		if(nnliczba4 >5) begin
			nnliczba4 = 0;
			nnliczba5 = nliczba5 + 1;
		end
		
		if(nnliczba5 >9) begin
			nnliczba5 = 0;
			nnliczba6 = nliczba6 + 1;
		end
		
		if(nnliczba6 >5) begin
			nnliczba6 = 0;
			nnliczba5 = 0;
			nnliczba4 = 0;
			nnliczba3 = 0;
			nnliczba2 = 0;
			nnliczba1 = 0;
			nnliczba0 = 0;
		end
	end

	if(mode)
	begin
		wliczba0 = nnliczba0;
		wliczba1 = nnliczba1;
		wliczba2 = nnliczba2;
		wliczba3 = nnliczba3;
	end
	else begin
		wliczba0 = wliczba01;
		wliczba1 = nnliczba4;
		wliczba2 = nnliczba5;
		wliczba3 = nnliczba6;
	end
	
end

assign restarted = restartedx;

assign liczba0 = wliczba0;
assign liczba1 = wliczba1;
assign liczba2 = wliczba2;
assign liczba3 = wliczba3;

assign save0 = nnliczba0;
assign save1 = nnliczba1;
assign save2 = nnliczba2;
assign save3 = nnliczba3;
assign save4 = nnliczba4;
assign save5 = nnliczba5;
assign save6 = nnliczba6;

endmodule
