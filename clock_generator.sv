module clk_gen (
  input   logic        clk_in,

  input   logic        reset,

  output  logic        clk_v1,
  output  logic        clk_v2
);

  // Write your logic here...
  logic state;
  
  always_ff @(posedge clk_in or posedge reset) begin
    if(reset)
      state <= 1'b0;
    else if(clk_in)
      state <= ~state;
    else
      state <= state;
  end
  
  assign clk_v1 = state & clk_in;
  assign clk_v2 = clk_v1 ^ clk_in;

endmodule
