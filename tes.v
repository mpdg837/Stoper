module tes(

	input[4:0] in,
	input clk0,
	
	output[3:0] out,
	output[6:0] number,
	output[3:0] select,
	output kropka,
	output sound
);


wire[3:0] liczba3;
wire[3:0] liczba2;
wire[3:0] liczba1;
wire[3:0] liczba0;

wire[4:0] switch;
wire[4:0] rpressound;

wire[1:0] rendered;
wire clki,clk,started;


counter50 clkm1(.clk0(clk0),.clk(clk));

// 1Mhz

div_input d1(.clk(clk0),.clkm(clki));

przycisk p1(.in(in[0]),.clk(clki),.press(switch[0]),.mode(1),.rspress(rpressound[0]));
przycisk p2(.in(in[1]),.clk(clki),.press(switch[1]),.mode(0),.rspress(rpressound[1]));
przycisk reset(.in(in[2]),.clk(clki),.press(switch[2]),.mode(0),.rspress(rpressound[2]));
przycisk p4(.in(in[3]),.clk(clki),.press(switch[3]),.mode(1),.rspress(rpressound[3]));

przycisk p5(.in(in[4]),.clk(clki),.press(switch[4]),.mode(0),.rspress(rpressound[4]));

wire restarted;

wire[6:0] number1;
wire[6:0] number2;
wire[6:0] number3;
wire[6:0] number4;

wire[3:0] save0 = 4'b0;
wire[3:0] save1 = 4'b0;
wire[3:0] save2 = 4'b0;
wire[3:0] save3 = 4'b0;
wire[3:0] save4 = 4'b0;
wire[3:0] save5 = 4'b0;
wire[3:0] save6 = 4'b0;

wire pressed = (~rpressound[0]) || (~rpressound[1]) || (~rpressound[2]) || (~rpressound[3]) ||  (~rpressound[4]);

count c1(.save6(save6),.save5(save5),.save4(save4),.save3(save3),.save2(save2),.save1(save1),.save0(save0),.restarted(restarted),.in(clki),.liczba0(liczba0),.liczba1(liczba1),.liczba2(liczba2),.liczba3(liczba3),.on(switch[3]),.clear(switch[2]),.mode(switch[0]));

// Memory

memory mem(.save6(save6),.save5(save5),.save4(save4),.save3(save3),.save2(save2),.save1(save1),.save0(save0));

// Graphics

seg7 seg1(.cyfra(liczba0),.led(number1),.restarted(restarted));
seg7 seg2(.cyfra(liczba1),.led(number2),.restarted(restarted));
seg7 seg3(.cyfra(liczba2),.led(number3),.restarted(restarted));
seg7 seg4(.cyfra(liczba3),.led(number4),.restarted(restarted));

wire[3:0] selected;
wire miga;
migacz mig(.clk(clki),.migaj(switch[3]),.miganie(miga));

wire displaym;
display dis(.clk(clk),.number1(number1),.number2(number2),.number3(number3),.number4(number4),.fnumber(number),.select(select),.rendered(rendered),.displaying(displaym));
krop kropa(.miganie(miga),.on(displaym),.mode(switch[0]),.rendered(rendered),.kropka(kropka));


// Sound


sound sou(.clk(clk),.in(pressed ),.out(sound));


assign out[0] = switch[3];
assign out[1] = switch[0];
assign out[2] = 1;
assign out[3] = 1;

endmodule

