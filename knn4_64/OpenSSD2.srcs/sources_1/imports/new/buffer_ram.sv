`timescale 1 ns / 1 ns

`include "defines.vh"


import RISA_PKG::*;


module BufferRAMT #(
  parameter ID      = 0,
  parameter DEPTH   = 512,
  parameter WIDTH   = FSIZE,
  parameter WORDS   = 32,
  parameter READ_LATENCY = BUFFER_READ_LATENCY,
  parameter DEPTHAD = $clog2(DEPTH)
) (
  input logic                   clk,
  input logic [DEPTHAD-1:0]     raddr,
  input logic [DEPTHAD-1:0]     waddr,
  input logic [WIDTH*WORDS-1:0] wdata,
  input logic                   wren,
  output logic [WIDTH*WORDS-1:0] rdata
);
  generate 
      logic[WIDTH*WORDS-1:0] memory[0:DEPTH-1];
      logic[WIDTH*WORDS-1:0] rbuffer[0:READ_LATENCY-1];
      
      assign rdata = rbuffer[READ_LATENCY-1];
      
      always @ (posedge clk) begin
        rbuffer[0] <= memory[raddr];
        for(int i = 0; i < READ_LATENCY-1; i ++)  
          rbuffer[i+1] <= rbuffer[i];
        
        if(wren) begin
          memory[waddr] = wdata;
        end
      end  
  endgenerate  

endmodule