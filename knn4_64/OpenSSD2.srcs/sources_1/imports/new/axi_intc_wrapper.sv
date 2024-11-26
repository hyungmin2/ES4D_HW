`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;


module axi_intc_wrapper#(
) (
    input rstn,
    input clk,

    output axi_output   AXI_output ,
    input  axi_input    AXI_input,
    
    input  axi_read_output          read_output_0 ,
    output axi_read_input_nodata    read_input_0 ,  
    output logic[31:0]              read_input_rdata_0 ,  
    input  axi_write_output_nodata  write_output_1 ,              
    input  logic[31:0]              write_output_wdata_1 ,              
    input  logic[3:0]               write_output_wstrb_1 ,              
    output axi_write_input          write_input_1
);
           
        
        
        
        
        
        

    assign AXI_output.awid = 0;
    assign AXI_output.awaddr = write_output_1.awaddr;
    assign AXI_output.awlen = write_output_1.awlen;
    assign AXI_output.awsize = write_output_1.awsize;
    assign AXI_output.awburst = write_output_1.awburst;
    assign AXI_output.awvalid = write_output_1.awvalid;
    assign AXI_output.wdata = write_output_wdata_1;
    assign AXI_output.wstrb = write_output_wstrb_1;
    assign AXI_output.wlast = write_output_1.wlast;
    assign AXI_output.wvalid = write_output_1.wvalid;
    assign AXI_output.bready = write_output_1.bready;
    
    assign write_input_1.awready = AXI_input.awready;
    assign write_input_1.wready = AXI_input.wready;
    assign write_input_1.bid = AXI_input.bid;
    assign write_input_1.bresp = AXI_input.bresp;
    assign write_input_1.bvalid = AXI_input.bvalid;


    assign AXI_output.arid = read_output_0.arid;
    assign AXI_output.araddr = read_output_0.araddr;
    assign AXI_output.arlen = read_output_0.arlen;
    assign AXI_output.arsize = read_output_0.arsize;
    assign AXI_output.arburst = read_output_0.arburst;
    assign AXI_output.arvalid = read_output_0.arvalid;
    assign AXI_output.rready  = read_output_0.rready;

    //assign read_input_0.rid = AXI_input.rid;
    assign read_input_0.arready = AXI_input.arready;
    assign read_input_rdata_0 = AXI_input.rdata;
    assign read_input_0.rresp = AXI_input.rresp;
    assign read_input_0.rlast = AXI_input.rlast;
    assign read_input_0.rvalid = AXI_input.rvalid;


        
  



    // axi_interconnect_0 axi_interconnect (
    //     .INTERCONNECT_ACLK(clk),
    //     .INTERCONNECT_ARESETN(rstn),
        
    //     .S00_AXI_ACLK(clk),
    //     .S00_AXI_AWID('0),
    //     .S00_AXI_AWADDR('0),
    //     .S00_AXI_AWLEN('0),
    //     .S00_AXI_AWSIZE('0),
    //     .S00_AXI_AWBURST('0),
    //     .S00_AXI_AWLOCK('0),
    //     .S00_AXI_AWCACHE('0),
    //     .S00_AXI_AWPROT('0),
    //     .S00_AXI_AWQOS('0),
    //     .S00_AXI_AWVALID('0),
    //     .S00_AXI_WDATA('0),
    //     .S00_AXI_WSTRB('0),
    //     .S00_AXI_WLAST('0),
    //     .S00_AXI_WVALID('0),
    //     .S00_AXI_BREADY('0),        
    //     .S00_AXI_ARID('0),
    //     .S00_AXI_ARADDR(read_output_0.araddr),
    //     .S00_AXI_ARLEN(read_output_0.arlen),
    //     .S00_AXI_ARSIZE(read_output_0.arsize),
    //     .S00_AXI_ARBURST(read_output_0.arburst),
    //     .S00_AXI_ARLOCK('0),
    //     .S00_AXI_ARCACHE('0),
    //     .S00_AXI_ARPROT('0),
    //     .S00_AXI_ARQOS('0),
    //     .S00_AXI_ARVALID(read_output_0.arvalid),
    //     .S00_AXI_ARREADY(read_input_0.arready),
    //     .S00_AXI_RDATA(read_input_rdata_0),
    //     .S00_AXI_RRESP(read_input_0.rresp),
    //     .S00_AXI_RLAST(read_input_0.rlast),
    //     .S00_AXI_RVALID(read_input_0.rvalid),
    //     .S00_AXI_RREADY(read_output_0.rready),
        
    //     .S01_AXI_ACLK(clk),
    //     .S01_AXI_AWID('0),
    //     .S01_AXI_AWADDR(write_output_1.awaddr),
    //     .S01_AXI_AWLEN(write_output_1.awlen),
    //     .S01_AXI_AWSIZE(write_output_1.awsize),
    //     .S01_AXI_AWBURST(write_output_1.awburst),
    //     .S01_AXI_AWLOCK('0),
    //     .S01_AXI_AWCACHE('0),
    //     .S01_AXI_AWPROT('0),
    //     .S01_AXI_AWQOS('0),
    //     .S01_AXI_AWVALID(write_output_1.awvalid),
    //     .S01_AXI_AWREADY(write_input_1.awready),
    //     .S01_AXI_WDATA(write_output_wdata_1),
    //     .S01_AXI_WSTRB(write_output_wstrb_1),
    //     .S01_AXI_WLAST(write_output_1.wlast),
    //     .S01_AXI_WVALID(write_output_1.wvalid),
    //     .S01_AXI_WREADY(write_input_1.wready),
    //     .S01_AXI_BID(write_input_1.bid),
    //     .S01_AXI_BRESP(write_input_1.bresp),
    //     .S01_AXI_BVALID(write_input_1.bvalid),
    //     .S01_AXI_BREADY(write_output_1.bready),        
    //     .S01_AXI_ARID('0),
    //     .S01_AXI_ARADDR('0),
    //     .S01_AXI_ARLEN('0),
    //     .S01_AXI_ARSIZE('0),
    //     .S01_AXI_ARBURST('0),
    //     .S01_AXI_ARLOCK('0),
    //     .S01_AXI_ARCACHE('0),
    //     .S01_AXI_ARPROT('0),
    //     .S01_AXI_ARQOS('0),
    //     .S01_AXI_ARVALID('0),
    //     .S01_AXI_RREADY('0),

    //     .M00_AXI_ACLK(clk),
    //     .M00_AXI_AWID(AXI_output.awid[3:0]),
    //     .M00_AXI_AWADDR(AXI_output.awaddr),
    //     .M00_AXI_AWLEN(AXI_output.awlen),
    //     .M00_AXI_AWSIZE(AXI_output.awsize),
    //     .M00_AXI_AWBURST(AXI_output.awburst),
    //     .M00_AXI_AWVALID(AXI_output.awvalid),
    //     .M00_AXI_AWREADY(AXI_input.awready),
    //     .M00_AXI_WDATA(AXI_output.wdata),
    //     .M00_AXI_WSTRB(AXI_output.wstrb),
    //     .M00_AXI_WLAST(AXI_output.wlast),
    //     .M00_AXI_WVALID(AXI_output.wvalid),
    //     .M00_AXI_WREADY(AXI_input.wready),
    //     .M00_AXI_BID(AXI_input.bid[3:0]),
    //     .M00_AXI_BRESP(AXI_input.bresp),
    //     .M00_AXI_BVALID(AXI_input.bvalid),
    //     .M00_AXI_BREADY(AXI_output.bready),        
    //     .M00_AXI_ARID(AXI_output.arid[3:0]),
    //     .M00_AXI_ARADDR(AXI_output.araddr),
    //     .M00_AXI_ARLEN(AXI_output.arlen),
    //     .M00_AXI_ARSIZE(AXI_output.arsize),
    //     .M00_AXI_ARBURST(AXI_output.arburst),
    //     .M00_AXI_ARVALID(AXI_output.arvalid),
    //     .M00_AXI_ARREADY(AXI_input.arready),
    //     .M00_AXI_RID(AXI_input.rid[3:0]),
    //     .M00_AXI_RDATA(AXI_input.rdata),
    //     .M00_AXI_RRESP(AXI_input.rresp),
    //     .M00_AXI_RLAST(AXI_input.rlast),
    //     .M00_AXI_RVALID(AXI_input.rvalid),
    //     .M00_AXI_RREADY(AXI_output.rready)
    // );
endmodule
