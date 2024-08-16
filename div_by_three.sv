module div_by_three (
  input   logic    clk,
  input   logic    reset,

  input   logic    x_i,

  output  logic    div_o

);

  // Write your logic here...
  typedef enum bit[1:0] {a, b, c} divByThree;
  
  divByThree state, state_q;
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      state_q <= a;
    else
      state_q <= state;
  end
  
  assign state = (~x_i) ? (state_q == a) ? a
                        : (state_q == b) ? c
                        : b
                        : (state_q == a) ? b
                        : (state_q == b) ? a
                        : c;
  
  assign div_o = (state == a);
endmodule
