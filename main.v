`timescale 1ns / 1ns
module main(input Plus_in,Minus_in,Button1,Button2,Button3,Button4,Button5,Button6,masCLK,Reset,output reg a,b,c,d,e,f,g,AN0,AN1,AN2,AN3);

//generating 2 Hz clock for number update
    /*reg [26:0] tictoc=0;
    reg CLK_PushButton=0;

    always@(posedge masCLK)
    begin
    if(tictoc<25000000)
     tictoc<=tictoc+1'b1;
    else
    begin
     tictoc<=0;
     CLK_PushButton<=~CLK_PushButton;
    end
    end*/
    //generating 500 Hz clock for 7 segment multiplexing T=2ms
    reg [26:0] tictoc2=0;
    reg CLK=0;
    always@(posedge masCLK)
    begin
    if(tictoc2<100000)
     tictoc2<=tictoc2+1'b1;
    else
    begin
     tictoc2<=0;
     CLK<=~CLK;
    end
    end
    
    //generating slow_clk for debouncing T=2.5 ms
    reg [26:0]counter=0;
    reg slow_clk;
    always @(posedge masCLK)
    begin
        counter <= (counter>=249999)?0:counter+1;
        slow_clk <= (counter < 125000)?1'b0:1'b1;
    end
    
    reg [12:0] BitR=13'b0;
    wire [6:0] Bit1,Bit2;
    wire [10:0] L1,L2,LR;
    wire Plus,Minus;
    Debounce inst0(Plus_in,slow_clk,Plus);
    Debounce inst1(Minus_in,slow_clk,Minus);
    
    
    Input inst2(slow_clk,Reset,Plus,Minus,Button1,Bit1);
    Input inst3(slow_clk,Reset,Plus,Minus,Button2,Bit2);
   
    always@(Button3 or Button4 or Button5 or Button6)
    begin
     if({Button3,Button4,Button5,Button6}==4'b1000)
      BitR=Bit1+Bit2;
     else if({Button3,Button4,Button5,Button6}==4'b0100)
      BitR=Bit1-Bit2;
     else if({Button3,Button4,Button5,Button6}==4'b0010)
      BitR=Bit1*Bit2;
     else if({Button3,Button4,Button5,Button6}==4'b0001)
      BitR=Bit1/Bit2;
     else
      BitR=0;
    end
     
    Display inst4({6'b000000,Bit1},CLK,L1[10],L1[9],L1[8],L1[7],L1[6],L1[5],L1[4],L1[3],L1[2],L1[1],L1[0]);
    Display inst5({6'b000000,Bit2},CLK,L2[10],L2[9],L2[8],L2[7],L2[6],L2[5],L2[4],L2[3],L2[2],L2[1],L2[0]);
    Display inst6(BitR,CLK,LR[10],LR[9],LR[8],LR[7],LR[6],LR[5],LR[4],LR[3],LR[2],LR[1],LR[0]);
   
    
    always@(*)
    begin
     if({Button1,Button2,Button3,Button4,Button5,Button6}==6'b100000)
      {a,b,c,d,e,f,g,AN0,AN1,AN2,AN3}=L1;
     else if({Button1,Button2,Button3,Button4,Button5,Button6}==6'b010000)
      {a,b,c,d,e,f,g,AN0,AN1,AN2,AN3}=L2;
     else if(({Button1,Button2,Button3,Button4,Button5,Button6}==6'b001000) ||
             ({Button1,Button2,Button3,Button4,Button5,Button6}==6'b000100) ||
             ({Button1,Button2,Button3,Button4,Button5,Button6}==6'b000010) ||
             ({Button1,Button2,Button3,Button4,Button5,Button6}==6'b000001))                                                                 
      {a,b,c,d,e,f,g,AN0,AN1,AN2,AN3}=LR;  
    end
      
    
 endmodule
      