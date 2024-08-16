module one_shot (
  input   logic        clk,
  input   logic        reset,

  input   logic        data_i,

  output  logic        shot_o

);

  // Write your logic here
  logic data_q;
  
  always_ff @(posedge clk or posedge reset)
    if(reset)
      data_q <= 1'b0;
  	else
      data_q <= data_i;
  
  assign shot_o = data_i & ~data_q;

endmodule
