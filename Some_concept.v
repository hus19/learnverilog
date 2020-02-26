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
 module adder (clock,reset,a,b,c); //模块名（口1,2,3）
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
 
 //====模块内容 包括I/O说明，内部信号声明、功能定义
  input[信号位宽-1:0] 端口名i; //i个输入口
  output[信号位宽-1:0] 端口名j; //j个输出口
  inout[信号位宽-1:0] 端口名k; //k个输入输出口
 or module module_name (input port1,input port2, ..., output port1, output port2...); 
 
 reg[width-1:0] R1,R2 ...
 wire[width-1:0] W1,W2...
 
 1. assign a=b&c;  //产生逻辑
 2. and # 2 u1(q,a,b);  //调用名为u1的与门输入为a，b；输出为q，输出延时2个单位时间
 3. always @(posedge clk or posedge clr)  //既可以描述逻辑，也可以描述时序
		begin 
			if(clr)q <= 0;
			else if (en) q <= d;
		end
 //以上三种理解为并发实现的，而always内部是按照顺序执行的
 
 //===========数据类型及常量和变量===========//
Verilog有19种数据类型 常用的有四种 reg wire integer parameter
 one 常量--不说明位数时，默认值是32位
	数字-整数： B2 D10 H16 O8   ex： 8'b10101100  8'ha2 
	数字-x和z： x：不定值 z:高阻值
				4'b10x0  //位宽为4的二进制数从低位数起第2位为不定值
				4'b101z  //位宽为4的二进制数从低位数起第1位为高阻值
				12'dz    //位宽为12的十进制数，其值为高阻值（第1种表达方式）
				12d？    //位宽为12的十进制数，其值为高阻值（第2种表达方式）
				8"h4x    //位宽为8的十六进制数，其低4位值为不定值
	数字-负数： 只需要在位宽前加减号
				-8'd5   //这个表达式代表5的补数（用八位二进制数表示）
				8d-5   //非法格式
	数字-下划线： 下划线用于数之间分割，提高可读性；
				16b1010_1011_1111_1010//合法格式
				8"b_0011_1010//非法格式
				
	参数型（parameter） 	parameter参数名1=表达式，参数名2=表达式，……，参数名n=表达式；	
		parameter是参数型数据的确认符。确认符后跟着一个用逗号分隔开的赋值语句表。在每一个赋值语句的右边必须是一个常数表达式。
		parameter msb=7;      //定义参数msb为常量
		parameter e=25，f=29；//定义两个常数参数
		parameter r=5.7		  //声明r为一个实型参数
		parameter byte_size=8， byte_msb= byte_size-1； //用常数表达式赋值
		parameter average_delay =(r+f)/2;    //用常数表达式赋值
 two 变量-- 值可以变化的量
	变量-wire型： wire型可以做任何方程式的输入，也可以作为assign或实例原件的输出
		wire[n-1：0]数据名1，数据名2，…数据名i；//共有i条总线，每条总线内有n条线路
		=wire[n：1]数据名1，数据名2，…数据名i
	ex: wire a;        //定义了一个1位的wire型数据
		wire[7：0]b;   //定义了一个8位的wire型数据
		wire[4：1]c,d；//定义了二个4位的wire型数据
	变量-reg型：  在always内赋值的每一个信号都必须要定义为reg型
		reg[n-1：0]数据名1，数据名2，…，数据名i； 
		=reg[n：1] 数据名1，数据名2，…，数据名i；
	ex: reg rega；			//定义了一个1位的名为rega的reg型数据
		reg [3：0] regb		//定义了一个4位的名为regb的reg型数据
		reg[4：1]rege,regd；//定义了二个4位的名为regc和regd的reg型数据
	变量-memory型：	
		reg[n-1：0]存储器名[m-1：0]； 
		=reg[n-1：0]存储器名[m：1]；
	ex: reg[7：0]mema[255：0]；//这个例子定义了一个名为mema的存储器，该存储器有256个8位的存储器。该存储器的地址范围是0到255。
	
		parameter wordsize=16，//定义两个参数
				  memsize=256； 
		reg [wordsize-1：0] mem[memsize-1：0]， writereg, readreg; //可以在同一个数据类型声明语句中定义存储器型数据和reg型数据
		
		reg[n-1：0] rega ;     //一个n位的寄存器
		reg mema [n-1：0];    //一个由n个1位寄存器构成的存储器组  注意区分以上两者
		mema[3]=0;    //给memory中的第三个存储器单元赋值为0；
 three 运算符和表达式
		clock =~clock； //~是一个单目取反运算符， clock是操作数
		c=a|b 			//是一个双目按位或运算符，a和b是操作数
		r=s?t:u；		//？：是一个三目条件运算符，s,t,u是操作数
	基本运算符 ：+ - * / %
	位运算符： ~ & | ^(按位异或) ^~(同或)
 
 //================运算符、赋值语句和结构说明语句==============//
  I 逻辑运算符
	&& || !  //使用括号明确表达运算优先关系
  II 关系运算符  ---级别低于算术运算符
	a<b a>b a<=b a>=b
  III 等式运算符
	== != === !===(包括x，z状态)
  IV 移位运算符
	a>>n  a<<n(左移)
  ex:   module shift；
			reg [3：0] start, result； 
			initial； 
			begin 
				start=1；		// start在初始时刻设为值0001
				result =（start<<2）； //移位后， start的值0100，然后赋给 result 
			end 
		endmodule
  V 位拼接运算符 {}
   {信号1的某几位，信号2的某几位，…，…，信号n的某几位}
  ex：{a,b[3:0],w,3'b101}
	  ={a,b[3],b[2],b[1],b[0],w,1'b1,1'b0,1'b1}   //不允许存在没有指明位数的信号
	  {4{w}}  //等同于{w,w,w,w}   //重复法
	  {b,{3{a,b}}}    //等同{b,a,b,a,b,a,b}
  VI 缩减运算符
    reg[3:0]B;
	reg C;
	 C=&B;
	=== C=((B[0]&B[1])&B[2])&B[3];
  VII 运算级别 
  VIII 关键词
   always, and, assign, begin, buf, bufif0, bufif1, case, casex, casez, cmos, deassign, default, defparam, disable, edge, else, end, endcase, endmodule, endfunction, endprimitive, endspecify, endtable, endtask, event, for, force, forever, fork, function, highz0,highz1, if, initial, 
   inout, input, integer, join, large, macromodule, medium, module, nand, negedge, nmos, nor, not, notif0, notif1, or, output, parameter, pmos, posedge, primitive, pull0, pull1, pullup, pulldown, rcmos, reg, releses, repeat, mmos, rpmos, rtran, rtranif0， rtranif1, scalared, small, 
   specparam,specify, strength, strong0, strong1, supply0, supply1, table, task, time, tran, tranif0，tranif1, tri, tri0, tri1, triand, trior,
   trireg, vectored, wait, wand, weak0, weak1, while, wire, wor, xnor, xor
   
  IX 赋值语句和块语句
   1.非阻塞赋值方式  b < = a; //always块结束后才赋值
   2.阻塞赋值方式    b=a;  //立即执行，但会带来麻烦
   块语句
	顺序块 begin  end 
	ex： 	parameter d=50;   //声明d是一个参数
			reg【7：0】r;   //声明r是一个8位的寄存器变量
			begin			//由一系列延迟产生的波形
				# d r='h35;
				# d r='hE2;
				# d r='h00;
				# d r='hF7;
				# d -> end wave;    //触发事件 end_wave 
			end
	并行块 fork  join
	ex：	
			fork			
				# 50 r='h35;
				# 100 r='hE2;
				# 150 r='h00;
				# 200 r='hF7;
				# 250 -> end wave;    //触发事件 end_wave 
			join
			
//================条件语句、循环语句、块语句与生成语句============//







