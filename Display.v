`timescale 1ns / 1ns


module Display(input [12:0] Bit,input CLK,output reg a,b,c,d,e,f,g,AN0,AN1,AN2,AN3);

reg [12:0] Bit_copy=13'b0;
reg [15:0] Digit=16'b0;
reg [6:0] LED0,LED1,LED2,LED3;
reg [1:0] count=2'b0;

always@(Bit)
begin
 Bit_copy=Bit;
 Digit[3:0]=Bit_copy%(4'b1010);
 Bit_copy=(Bit_copy/(4'b1010));
 Digit[7:4]=Bit_copy%(4'b1010);
 Bit_copy=(Bit_copy/(4'b1010));
 Digit[11:8]=Bit_copy%(4'b1010);
 Bit_copy=(Bit_copy/(4'b1010));
 Digit[15:12]=Bit_copy%(4'b1010);
 Bit_copy=(Bit_copy/(4'b1010));
end

function automatic [6:0] Decode;
     input [3:0] Dig;
     begin
      case(Dig)
       0:Decode=7'b0000001;
       1:Decode=7'b1001111;
       2:Decode=7'b0010010;
       3:Decode=7'b0000110;
       4:Decode=7'b1001100;
       5:Decode=7'b0100100;
       6:Decode=7'b0100000;
       7:Decode=7'b0001111;
       8:Decode=7'b0000000;
       9:Decode=7'b0000100;
      endcase
     end
    endfunction
    
    always@(Digit)
    begin 
     LED0=Decode(Digit[3:0]);
     LED1=Decode(Digit[7:4]);
     LED2=Decode(Digit[11:8]);
     LED3=Decode(Digit[15:12]);
    end
       
    always@(posedge CLK)
    begin
     if(count<3)
      count<=count+1;
     else
      count<=0;
    end
    
    always@(count)
    begin
     case(count)
      0:begin {a,b,c,d,e,f,g}=LED0;{AN0,AN1,AN2,AN3}=4'b0111; end
      1:begin {a,b,c,d,e,f,g}=LED1;{AN0,AN1,AN2,AN3}=4'b1011; end
      2:begin {a,b,c,d,e,f,g}=LED2;{AN0,AN1,AN2,AN3}=4'b1101; end
      3:begin {a,b,c,d,e,f,g}=LED3;{AN0,AN1,AN2,AN3}=4'b1110; end
     endcase
    end     
endmodule
