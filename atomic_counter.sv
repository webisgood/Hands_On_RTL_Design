module atomic_counters (
  input                   clk,
  input                   reset,
  input                   trig_i,
  input                   req_i,
  input                   atomic_i,
  output logic            ack_o,
  output logic[31:0]      count_o
);

  // --------------------------------------------------------
  // DO NOT CHANGE ANYTHING HERE
  // --------------------------------------------------------
  logic [63:0] count_q;
  logic [63:0] count;

  always_ff @(posedge clk or posedge reset)
    if (reset)
      count_q[63:0] <= 64'h0;
    else
      count_q[63:0] <= count;
  // --------------------------------------------------------

  // Write your logic here...
  logic isAtomic;
  logic isFirstReq;
  logic isSecondReq;
  logic [31:0] upperHalf;
  
  // logic to increment the counter
  assign count = (trig_i) ? count_q + 1'b1 : count_q;
  
  // logic to accurately detect the atomicity of a request
  always_ff @(posedge clk)
    isAtomic <= (isFirstReq | isAtomic) & ~isSecondReq;
  
  // detect the first and second read reqests
  assign isFirstReq = req_i & atomic_i;
  assign isSecondReq = req_i & ~atomic_i & isAtomic;
  
  // capture the current upper 32-bits of the counter
  always_ff @(posedge clk)
    if(isFirstReq)
      upperHalf <= count[63:32];
  	else
      upperHalf <= upperHalf;
  
  // produce the counter output
  always_ff @(posedge clk)
    if(isFirstReq) begin
      count_o <= count[31:0];
  		ack_o <= 1'b1;
    end
  	else if(isSecondReq) begin
    	count_o <= upperHalf;
    	ack_o <= 1'b1;
  	end
  	else begin
      count_o <= 32'h0;
      ack_o <= 1'b0;
    end
endmodule