module palindrome3b (
  input   logic        clk,
  input   logic        reset,

  input   logic        x_i,

  output  logic        palindrome_o
);

  // Write your logic here...
  logic [1:0] count;
  logic [1:0] prevTwoBits;
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      count <= 2'h0;
  	else
      if(count != 2'h2)
        count <= count + 1'b1;
  		else
        count <= count;
  end
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      prevTwoBits <= 2'h0;
    else if(count == 2'h0)
      prevTwoBits[1] <= x_i;
    else if(count == 2'h1)
      prevTwoBits[0] <= x_i;
    else
      prevTwoBits <= {prevTwoBits[0], x_i};
  end
  
  assign palindrome_o = ((~prevTwoBits[1] & ~x_i) | (prevTwoBits[1] & x_i)) & 
    										(count == 2'h2);
endmodule
