`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;

module AXILoader #(
    parameter ILA=0,
    parameter ARSIZE= 3'b011,
    parameter DATA_SIZE = 32
) (
    input rstn,
    input clk,

    input logic[`DDR_ADDR_WIDTH-1:0] address,
    input logic[31:0] size,
    input logic trigger,
    output logic busy,
    output logic ready,
    
    output logic  o_valid,
    input logic i_ready,
    
    output axi_read_output   AXI_output ,
    input  axi_read_input_nodata    AXI_input
);

  localparam AXI_LOAD_UNIT_BYTE = DATA_SIZE/8;
  localparam AXI_LOAD_BURST = 256;
 
  typedef struct {
    logic [`DDR_ADDR_WIDTH-1:0] axi_load_addr; 
    logic [31:0] axi_load_size; 
    logic [15:0] axi_addr_remain; 
    // logic [15:0] load_remain; 
    logic [$clog2(AXI_LOAD_BURST)-1:0] axi_arlen_last; 
  } Registers;
    
  Registers reg_current,reg_next;

  always_comb begin //ddr
    reg_next = reg_current;
    
    busy = 0;
    ready = reg_current.axi_addr_remain  == 0;
       
    if(trigger) begin
      reg_next.axi_load_addr = address;
      reg_next.axi_load_size = size;
    
      reg_next.axi_addr_remain = `CEILDIV(size,(AXI_LOAD_BURST*AXI_LOAD_UNIT_BYTE));
      reg_next.axi_arlen_last  = (size / AXI_LOAD_UNIT_BYTE) % AXI_LOAD_BURST-1;
      // reg_next.load_remain     = size / AXI_LOAD_UNIT_BYTE ;
    end

    AXI_output = `AXI_READ_OUTPUT_IDLE;    
    
    AXI_output.arsize = ARSIZE;

    AXI_output.rready = i_ready;
    
    if(reg_current.axi_addr_remain != 0) begin      
      AXI_output.araddr = reg_current.axi_load_addr;
    
      AXI_output.arlen = AXI_LOAD_BURST-1;
      if(reg_current.axi_addr_remain == 1) begin
        AXI_output.arlen = reg_current.axi_arlen_last;
      end
      
      AXI_output.arvalid = 1;
      
      if(AXI_input.arready) begin
        reg_next.axi_addr_remain = reg_current.axi_addr_remain - 1;
        reg_next.axi_load_addr = reg_current.axi_load_addr + AXI_LOAD_BURST*AXI_LOAD_UNIT_BYTE;  
      end
    end
     
    o_valid = AXI_input.rvalid;
    // if(AXI_input.rvalid &&  AXI_output.rready) begin            
    //   if(reg_current.load_remain) begin
    //     reg_next.load_remain = reg_current.load_remain -1;
    //   end
    // end

    // busy = (reg_current.load_remain != 0) || (reg_current.axi_addr_remain != 0);

    if(rstn==0) begin
      // reg_next.load_remain = 0;
      reg_next.axi_addr_remain = 0;
    end
  end

  always @( posedge clk ) begin
    reg_current <= reg_next;
  end 
  
  
  // ila_0 ila_loader ( 
  //  .clk(clk),
  //  .probe0(AXI_output.araddr),
  //  .probe1({AXI_output.arburst,AXI_output.arlen,AXI_output.arvalid,AXI_output.rready,AXI_input.arready,AXI_input.rlast,AXI_input.rresp,AXI_input.rvalid}),
  //  .probe2(0),
  //  .probe3(0),
  //  .probe4(address),
  //  .probe5({size,trigger,busy,o_valid,i_ready}),
  //  .probe6(reg_current.axi_load_addr),
  //  .probe7({reg_current.axi_load_size,reg_current.axi_addr_remain}),
  //  .probe8({reg_current.load_remain,reg_current.axi_arlen_last}),
  //  .probe9(0)
  // )    ;
      

endmodule


