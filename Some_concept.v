//Verilog 数
 1'b0  // 1位，值全为0
 'b0   // 32位
 32'b0 //32位
 4'ha  //4位十六进制数1010
 5'h5  //5位十六进位数00101
 4'hz  //zzzz
 4'h? zz?  //
 4'bx  //xxxx
 9  //32位数（从左边开始，前28位用0填充）
 a //非法数 
 
 //====================简单加法器的代码===========//
 module adder (clock,reset,a,b,c);
	 input clock,reset,a,b;
	 reg[1:0]c;
	 always @(posedge clock or posedge reset)
		begin if (reset)
		c = 2'b0;
		else
		c = a+b;
	end
end module
 //========简单加法布尔等式==========//
 c[0] <= a^b; //verilog布尔逻辑XOR运算符
 c[1] <= a&b; //verilog布尔逻辑AND运算符