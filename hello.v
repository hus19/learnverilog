module hello(in1,in2,in3,out1,out2,clk,rst,bidir_signal,output_enable); //模块名称一般与文件名称相同
	/* 另一种注释方法*/
	input in1,in2,in3,clk,rst,output_enable; //端口方向列表，定义输入输出端口和双向端口
	output out1,out2;
	inout bidir_signal;
	reg out2; // 信号分为线网型和寄存器型
	wire out1; //线网型信号可被寄存器或组合赋值驱动，未定义的信号默认为1比特的线网型信号

	assign out = in1 & in2; // 强制赋值语句应是连续的逻辑语句
	assign bidir_signal = output_enable ? out2:1'bz; //bidir_signal条件赋值，若enable为真，out值给bir 反之bir为三态z

	always @ (posedge clk or posedge rst) //always顺序执行。@后为事件灵敏度表，综合工具从此表提取程序块的控制信号。
	begin //分离代码段
		if (rst)out2 < = 1'b0; // 希望时序程序块可以同时更新
		else out2 < = (in3 & bidir_signal);
		end
	end
endmodule