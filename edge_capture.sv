module edge_capture (
  input   logic        clk,
  input   logic        reset,

  input   logic [31:0] data_i,

  output  logic [31:0] edge_o

);

  // Write your logic here...
  logic [31:0] negEdge;
  logic [31:0] data_q;
  logic [31:0] edge_q;
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      data_q <= 32'h0;
    else
      data_q <= data_i;
  end
  
  assign negEdge = data_q & ~data_i;
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      edge_q <= 32'h0;
    else if(|negEdge)
      edge_q <= edge_q | negEdge;
    else
      edge_q <= edge_q;
  end
  
  assign edge_o = (|(data_q & ~data_i)) ? (edge_q | negEdge) : edge_q;
endmodule
