`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;

module AXIWriter #(
    parameter ILA=0,
    parameter AWSIZE= 3'b011,
    parameter DATA_SIZE=32
) (
    input rstn,
    input clk,

    input logic [`DDR_ADDR_WIDTH-1:0] address,
    input logic [15:0] size,
    input logic trigger,
    output logic busy,
    
    input logic  i_valid,
    output logic o_accept,
    
    output axi_write_output_nodata   AXI_output ,
    input  axi_write_input    AXI_input
);
  localparam AXI_WRITE_UNIT_BYTE = DATA_SIZE/8;
  localparam AXI_WRITE_BURST = 32;

  typedef struct {
    logic [`DDR_ADDR_WIDTH-1:0] awaddr; 
    
    logic writing;
    logic waiting_bresp;
    
    logic [15:0] stored_bresp_count;
    logic [15:0] num_bursts;

    logic [7:0] burst_remain;
    logic burst_end;
    logic [$clog2(AXI_WRITE_BURST)-1:0] last_burst_size;
    
    logic [15:0] addr_write_remain;
    logic [15:0] write_remain;
    
    logic write_done_start_addr;      
  } Registers;
    
  Registers reg_current,reg_next;       

  always_comb begin
    reg_next = reg_current;
       
    AXI_output = '{default:'0, awburst : 2'b01, awsize : AWSIZE, bready : 1'b1};

    busy = reg_current.writing || reg_current.waiting_bresp;

    if(trigger) begin
      reg_next.awaddr = address;
      reg_next.num_bursts = `CEILDIV(size, (AXI_WRITE_BURST*AXI_WRITE_UNIT_BYTE)); 
      reg_next.last_burst_size  = (size / AXI_WRITE_UNIT_BYTE) % AXI_WRITE_BURST -1;

      reg_next.writing = 1;
      reg_next.waiting_bresp = 1;
      reg_next.stored_bresp_count = 0;          
      reg_next.addr_write_remain = reg_next.num_bursts;           //num_bursts
      reg_next.write_remain = reg_next.num_bursts;           //num_bursts
      reg_next.burst_remain = 0;
      reg_next.burst_end = 0;                
      reg_next.write_done_start_addr = 1;        
    end
    
    AXI_output.awaddr = reg_current.awaddr;
    AXI_output.awlen = AXI_WRITE_BURST-1;    
    AXI_output.wvalid = 1'b0;
    AXI_output.wlast =  0;
    
    if(reg_current.addr_write_remain && reg_current.write_done_start_addr) begin      
      AXI_output.awvalid = 1;                    
      
      if(reg_current.addr_write_remain == 1) begin
        AXI_output.awlen = reg_current.last_burst_size;
      end
      
      if(AXI_input.awready) begin        
        reg_next.addr_write_remain = reg_current.addr_write_remain -1;
          
        reg_next.awaddr = reg_current.awaddr + AXI_WRITE_BURST*AXI_WRITE_UNIT_BYTE;                        
        reg_next.write_done_start_addr = 0;                        
      end
    end
    
        
    if(reg_current.burst_remain == 0 && reg_current.write_remain) begin
      reg_next.write_remain = reg_current.write_remain -1;
      reg_next.burst_remain = AXI_WRITE_BURST;              
      if(reg_current.write_remain == 1) 
        reg_next.burst_remain = reg_current.last_burst_size + 1;        
      
      reg_next.burst_end = 0; 
      if(reg_next.burst_remain == 1)
        reg_next.burst_end = 1; 
    end

    o_accept = 0;
    if(i_valid && reg_current.burst_remain) begin
      AXI_output.wvalid = 1'b1;
      AXI_output.wlast =  reg_current.burst_end;
      if(AXI_input.wready) begin
        o_accept = 1;
        reg_next.burst_remain = reg_current.burst_remain-1;

        if(reg_current.burst_remain == 1) begin
          reg_next.burst_end = 0;                    
          reg_next.write_done_start_addr = 1;                    
          reg_next.writing = 0;
        end
        if(reg_current.burst_remain == 2) begin
          reg_next.burst_end = 1;
        end
      end
    end

        
    if(reg_current.waiting_bresp) begin
      if(AXI_input.bvalid) begin
        reg_next.stored_bresp_count = reg_current.stored_bresp_count + 1;    
        if(reg_next.stored_bresp_count == reg_current.num_bursts) begin
          reg_next.waiting_bresp = 0;
        end
      end
    end
    
    if(rstn == 0) begin
      reg_next.writing = '0;
      reg_next.waiting_bresp = '0;
    end
  end
              
	always @( posedge clk ) begin
    reg_current <= reg_next;    
	end 

endmodule


