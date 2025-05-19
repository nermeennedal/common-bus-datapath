module Control_Logic_Gate ( 
   
  input I , R , FGO , FGI , E , S , IEN , // input of Seven Flip Flop
  input [15:0] AC , DR , //  AC bits 0 through 15 to check if AC = 0 and DR bits 0 through 15 to check if DR = 0
  input [7:0] D , // 3 x8 decoder output 
  input [15:0] T, // 4x16 decoder output 
  input  [11:0] IR  , // and bits 0 through 11 of IR.
  output [6:0] LD ,  // Load for the seven registers 
  output  [5:0] INC , // increment for the eight registers
  output  [5:0] CLR , // clear signals for six registers 
  output  MEM_Read , MEM_Write , // memory signals read and Write 
  output  [5:0] SET   , // set , RESET , complement signal for 7 flip flop
  output  [5:0] RESET_FF,
  output  [1:0] Enable, // load flip flop for E and I
  output  [2:0] SEL , // Signals for 52, 51, and 50 to select a register for the bus
  output  reg [3:0] ALU_OPCODE// Signals to control the AC adder and logic circuit
);
  
  reg [2:0]ZERO;
  reg NEG;
  wire r ; // register refrence instruction 
  wire p ; // I/O instruction 
  wire [11:0] B ;
  wire [7:0] X ;
    // B / r / p
  assign B = IR;
  assign r = D[7] & ~I & T[3];
  assign p = D[7] & I & T[3] ;
   
  
    
// MEMORY READ AND Write 
 assign MEM_Read =(~R&T[1])|(~D[7]&I&T[3])|(D[0]&T[4])|(D[1]&T[4])|(D[2]&T[4])|(D[6]&T[4]);
 assign MEM_Write =(R&T[1])|(D[3]&T[4])|(D[5]&T[4])|(D[6]&T[6]);
// ZERO DETECTION
always @(*) begin
if(AC == 0)
  ZERO[0] = 1'b1;
else
  ZERO[0] = 1'b0;  
if(DR == 0)
  ZERO[1] = 1'b1;
else 
  ZERO[1] = 1'b0;  
  
if(AC[15] ==0 )
  NEG = 1'b0;
else
  NEG = 1'b1;

if(E==0)
  ZERO[2] =1'b1;
else 
  ZERO[2] =1'b0;
end
// LOAD Output for all registers 
     assign LD[6] = (~R & T[0]) | (~R&T[2]) | (~D[7] & I & T[3]); // load AR 
     assign LD[5] =(D[4]&T[4])|(D[5]&T[5]); // load PC 
     assign LD[4] = (D[0]&T[4])|(D[1]&T[4])|(D[2]&T[4])|(D[6]&T[4]); // LOAD DR
     assign LD[3] = ~R & T[1]; // load IR
     assign LD[2] = R & T[0]; // load TR
     assign LD[1]= p & B[10]; // load  OUTR 
     assign LD[0] = (D[0]&T[5])|(D[1]&T[5])|(D[2]&T[5])| (p&B[11])|(r&B[9])|(r&B[7])|(r&B[6]); // load Ac

    
// CLR output for all registers 
     assign CLR[0]= r&B[11]; // CLR AC
     assign CLR[2:1]= 1'b0; // CLR[2] DR ,CLR[1]TR 
     assign CLR[3] = R & T[1] ; // clear PC 
     assign CLR[4] = R & T[0]; // clear AR 
     assign CLR[5] = (R &T[2])|(D[0]& T[5])|(D[1] & T[5])|(D[2] & T[5])|(D[3] & T[4])|(D[4] & T[4])|(D[5] &T[5])|(D[6]&T[6])|(r)| (p); // clear SC 
	
// INC output for all register 
     assign INC[0] = r&B[5]; // INC AC
     assign INC[1] = 1'b0; // INC TR
     assign INC[2] = D[6]&T[5];  // INC DR
     assign INC[3] =(~R&T[1])|(R&T[2])|(D[6]&T[6]&ZERO[1])|(r&B[4]&(~NEG))|(r&B[3]&NEG)|(r&B[2]&ZERO[0])|(r&B[1]&ZERO[2])|(p&B[9]&FGI)|(p&B[8]&FGO); // INC PC 
     assign INC[4] = D[5]& T[4]; // INC AR
     assign INC[5] = ~CLR[5];// INC SC INC[0] = r&B[5]; // INC 

// flip flop clear
      assign RESET_FF[5] =1'b0; // RESET I
      assign RESET_FF[4] = p&B[10];//RESET FGO
      assign RESET_FF[3] = p& B[11]; // RESET FGI 
      assign RESET_FF[2] = r&B[0];// RESET START_STOP FLIP FLOP 
      assign RESET_FF[1] = R & T[2]; // reset R interrupt register 
      assign RESET_FF[0]=(p&B[6])|(R&T[2]); // reset IEN 
      

// SET flip  flop
       assign SET[5:2] = 1'b0; // SET[2] FGI , SET[3] FGO , SET[4] I , set[5] S  
       assign SET[1] = ~T[0]&~T[1] &~T[2] & IEN & (FGO | FGI); // set R 
       assign SET[0] = p&B[7]; // set IEN
//Load flip flop
       assign Enable[0] =(D[1]&T[5])|(r&B[8])|(r&B[10])|(r&B[7])|(r&B[6]); // LOAD E
       assign Enable[1] = ~R&T[2]; // LOAD I  
  



 
//ALU operation 
always @(*) begin
if (D[0] & T[5] == 1) // AND operation 
      ALU_OPCODE  = 4'b0000 ;
      
else if (D[1]&T[5] == 1) // ADD operation 
      ALU_OPCODE  = 4'b0001 ;
      
else if (D[2]&T[5]==1)// Transfer from DR 
      ALU_OPCODE  = 4'b0010;
      
else if (p & B[11] == 1) //Transfer from INPR
      ALU_OPCODE  = 4'b0110;
      
else if (r&B[9]==1) // Complement 
    ALU_OPCODE  = 4'b0011;
    
else if(r&B[7] ==1 ) //Shift right
      ALU_OPCODE = 4'b0100;  
      
else if(r&B[6]== 1) //Shift left
      ALU_OPCODE = 4'b0101 ;
else if (r & B[8]) //Complement E
      ALU_OPCODE = 4'b0111;
else if (r &B [10])
      ALU_OPCODE =4'b1000;  //reset or clear E
else 
      ALU_OPCODE =4'b0000;
end
    
    
// value of X 
assign X[0] = 1'b0;
assign X[1] =(D[4]&T[4]) | (D[5]&T[5]);  
assign X[2] =(~R&T[0])|(~R&T[1])|(R&T[0])|(R&T[2])|(D[5]&T[4])|(D[6]&T[6]);
assign X[3] =(D[0]&T[5])|(D[1]&T[5])|(D[2]&T[5])|(D[6]&T[5])|(D[6]&T[6]);
assign X[4]=(D[0]&T[5])|(D[1]&T[5])|(D[3]&T[4])|(p&B[10]);
assign X[5] = ~R&T[2];
assign X[6]= R& T[1];   
assign X[7] = (~R&T[1]) | (~D[7]&I&T[3]) |((D[0]|D[1]|D[2]|D[6])& T[4]); 
// SELECTION LINE  
assign SEL[0] = X[1] | X[3] | X[5] | X[7] ;
assign SEL[1] = X[2] | X[3] | X[6] | X[7]; 
assign SEL[2] = X[4] | X[5] | X[6] | X[7];     

endmodule

 