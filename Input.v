module Input(input slow_clk,Reset,Plus,Minus,activate,output reg [6:0] Inp);

always@(posedge slow_clk or negedge Reset)
    
     begin
     if(Reset==0 & activate==1)
      Inp=0;
     else if(Plus==1 & Minus==0 & activate==1)
      Inp=Inp+1'b1;
     else if(Plus==0 & Minus==1 & activate==1)
      Inp=Inp-1'b1;
     else
      Inp=Inp;
     end
endmodule
