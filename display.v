

module migacz(
	input clk,
	input migaj,
	output miganie
);

reg miganiex = 0;
reg miganiexx = 0;
reg[9:0] licz = 0;
reg[9:0] nlicz = 0;

always@( posedge clk )begin
	licz <= nlicz;
	miganiex <= miganiexx;
end

always@( * )begin

	nlicz = 0;
	miganiexx = miganiex;
	
	if(~migaj) begin
		nlicz = licz + 1;
		
		
		if(nlicz == 0)begin
			miganiexx = ~miganiex;
		end
	end else
	begin
		miganiexx = 0;
	end
	
	
end

assign miganie = miganiexx;

endmodule



module krop(
	input miganie,
	input on,
	input mode,
	input[3:0] rendered,
	
	output kropka
);

reg out=1;

always@( * )begin
	if(on && (~miganie) )begin
		if(~mode)begin
			case(rendered)
				0: out = 0;
				1: out = 1;
				2: out = 0;
				3: out = 1;
				default: out = 1;
			endcase
		end else
		begin
			case(rendered)
				0: out = 1;
				1: out = 1;
				2: out = 1;
				3: out = 0;
				default: out = 1;
			endcase
		end
	end else
	begin
		out = 1;
	end
end

assign kropka = out;
endmodule


module display(
	input clk,
	
	input[6:0] number1,
	input[6:0] number2,
	input[6:0] number3,
	input[6:0] number4,
	
	output[1:0] rendered,
	output[6:0] fnumber,
	output displaying,
	output[3:0] select
);

reg[6:0] fnumberx;
reg[3:0] ssselect = 4'd0;
reg[3:0] sselect;

reg[1:0] numx=2'd0;
reg[1:0] nnumx=2'd0;
reg savebit=0;
reg display=0;

always@(posedge clk)begin

	
	fnumberx <= ffnumberx;
	sselect <= ssselect;
	numx <= nnumx;
	pik <=npik;
end

reg[6:0] ffnumberx;
reg[6:0] fffnumberx;
reg[8:0] pik = 0;
reg[8:0] npik = 0;

always@( * )begin

	npik = pik + 1;
	nnumx = numx;
	ssselect = 4'b1111;
	
	ffnumberx = fnumberx;
	ssselect = sselect;
	
	case(nnumx)
		0: ssselect = 4'b1110;
		1: ssselect = 4'b1101;
		2: ssselect = 4'b1011;
		3: ssselect = 4'b0111; 
	endcase
	
	if(npik == 0)begin
		
		
		nnumx = numx + 1;
		
		case(nnumx)
			0: ffnumberx = number1;
			1: ffnumberx = number2;
			2: ffnumberx = number3;
			3: ffnumberx = number4;
			
		endcase
	
		
	end
	
	if(npik > 127) begin
		display = 1;
		fffnumberx = ffnumberx;
	end else
	begin
		display = 0;
		fffnumberx = 7'b1111111;
	end
end

assign rendered = nnumx;
assign fnumber = fffnumberx;
assign select = ssselect;
assign displaying = display;
endmodule



module seg7(
	input[3:0] cyfra,
	input restarted,
	
	output[6:0] led
);

reg[6:0] seg;
always@( * )begin
	if(restarted)begin
		seg = 7'b1111110;
	end else
	begin
		case(cyfra) 
			4'd0 : seg = 7'b0000001;
			4'd1 : seg = 7'b1001111;
			4'd2 : seg = 7'b0010010;
			4'd3 : seg = 7'b0000110;
			4'd4 : seg = 7'b1001100;
			4'd5 : seg = 7'b0100100;
			4'd6 : seg = 7'b0100000;
			4'd7 : seg = 7'b0001111;
			4'd8 : seg = 7'b0000000;
			4'd9 : seg = 7'b0000100;
			4'd10 : seg = 7'b1111110; 
			default : seg = 7'b1111111; 
		endcase
	end
end

assign led = seg;

endmodule