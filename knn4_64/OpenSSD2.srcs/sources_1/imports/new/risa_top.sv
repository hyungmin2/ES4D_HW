`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;

module risa_top #(
        parameter SIM_MODE        = 0
	) (
		input logic	clk,		    		
		input logic rstn,			

		input logic axi_in_valid,
		input logic [FSIZE-1:0] axi_in_data,
				
		output logic axi_out_valid,
		input logic axi_out_ready,
		output logic [FSIZE-1:0] axi_out_data,

		output CommandDataPort       commanddataport_axi,
		output CommandDataPort       commanddataport_axi_store,
		input logic [STATE_WIDTH-1:0] stateport_axi,

		input CommandDataPort commanddataport,
		output StatePort stateport
	);
             

  logic [$clog2(SLICE_BUFFER_SIZE*2)-1:0]  slice_data_raddr;
  logic [FSIZE-1:0]                      slice_data_rdata;
  logic [$clog2(SLICE_BUFFER_SIZE*2)-1:0]  slice_data_waddr;
  logic [FSIZE-1:0]                      slice_data_wdata;
  logic                                  slice_data_wren;

  BufferRAMT #(
    .ID(0),
    .DEPTH(SLICE_BUFFER_SIZE*2),
    .WIDTH(FSIZE),
    .WORDS(1)
  ) slice_data (
    .clk(clk),
    .raddr(slice_data_raddr),
    .rdata(slice_data_rdata),
    .waddr(slice_data_waddr),
    .wdata(slice_data_wdata),
    .wren (slice_data_wren)
  );
  assign  slice_data_wdata = axi_in_data;
  

  logic [$clog2(ORDER_BUFFER_SIZE*2)-1:0] ordering_vector_raddr;
  logic [FSIZE-1:0]                     ordering_vector_rdata;
  logic [$clog2(ORDER_BUFFER_SIZE*2)-1:0] ordering_vector_waddr;
  logic [FSIZE-1:0]                     ordering_vector_wdata;
  logic                                 ordering_vector_wren;

  BufferRAMT #(
    .ID(0),
    .DEPTH(ORDER_BUFFER_SIZE*2),
    .WIDTH(FSIZE),
    .WORDS(1)
  ) ordering_vector (
    .clk(clk),
    .raddr(ordering_vector_raddr),
    .rdata(ordering_vector_rdata),
    .waddr(ordering_vector_waddr),
    .wdata(ordering_vector_wdata),
    .wren (ordering_vector_wren)
  );
  assign  ordering_vector_wdata = axi_in_data;
  
  logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0] psum_read_buffer_raddr;
  logic [FSIZE-1:0]                    psum_read_buffer_rdata;
  logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0] psum_read_buffer_waddr;
  logic [FSIZE-1:0]                    psum_read_buffer_wdata;
  logic                                psum_read_buffer_wren;

  BufferRAMT #(
    .ID(0),
    .DEPTH(PSUM_BUFFER_SIZE*2),
    .WIDTH(FSIZE),
    .WORDS(1)
  ) psum_read_buffer (
    .clk(clk),
    .raddr(psum_read_buffer_raddr),
    .rdata(psum_read_buffer_rdata),
    .waddr(psum_read_buffer_waddr),
    .wdata(psum_read_buffer_wdata),
    .wren (psum_read_buffer_wren)
  );
  assign  psum_read_buffer_wdata = axi_in_data;
  
  logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0] psum_write_buffer_raddr;
  logic [FSIZE-1:0]                    psum_write_buffer_rdata;
  logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0] psum_write_buffer_waddr;
  logic [FSIZE-1:0]                    psum_write_buffer_wdata;
  logic                                psum_write_buffer_wren;

  BufferRAMT #(
    .ID(1),
    .DEPTH(PSUM_BUFFER_SIZE*2),
    .WIDTH(FSIZE),
    .WORDS(1)
  ) psum_write_buffer (
    .clk(clk),
    .raddr(psum_write_buffer_raddr),
    .rdata(psum_write_buffer_rdata),
    .waddr(psum_write_buffer_waddr),
    .wdata(psum_write_buffer_wdata),
    .wren (psum_write_buffer_wren)
  );
  assign  axi_out_data = psum_write_buffer_rdata;
  

  logic [$clog2(QUERY_BUFFER_SIZE)-1:0] query_vector_raddr;
  logic [FSIZE-1:0]                     query_vector_rdata;
  logic [$clog2(QUERY_BUFFER_SIZE)-1:0] query_vector_waddr;
  logic [FSIZE-1:0]                     query_vector_wdata;
  logic                                 query_vector_wren;

  BufferRAMT #(
    .ID(0),
    .DEPTH(QUERY_BUFFER_SIZE),
    .WIDTH(FSIZE),
    .WORDS(1)
  ) query_vector (
    .clk(clk),
    .raddr(query_vector_raddr),
    .rdata(query_vector_rdata),
    .waddr(query_vector_waddr),
    .wdata(query_vector_wdata),
    .wren (query_vector_wren)
  );
  assign  query_vector_wdata = axi_in_data;

  
  logic pe_input_valid;
  logic pe_input_last;
  logic [FSIZE-1:0] pe_A_data;
  logic [FSIZE-1:0] pe_B_data;
  logic pe_output_valid;
  logic [FSIZE-1:0] pe_out_data;

  logic pe_rstn;

  PE #(
    .ID(0)
  ) pe (
    .clk(clk),
    .rstn(rstn && pe_rstn),
    .input_valid(pe_input_valid),
    .input_last(pe_input_last),
    .A_data(pe_A_data),
    .B_data(pe_B_data),
    .output_valid(pe_output_valid),
    .out_data(pe_out_data)
  );

  
  logic fadd_in_valid;
  logic fadd_in_tlast;
  logic fadd_res_valid;
  logic [31:0] fadd_in_A;
  logic [31:0] fadd_in_B;
  logic [31:0] fadd_res;
  logic fadd_res_tlast;

  float_add float_add(
    .aclk(clk),	    
    .s_axis_a_tvalid(fadd_in_valid),
    .s_axis_a_tdata(fadd_in_A),
    .s_axis_a_tlast(fadd_in_tlast),
    .s_axis_b_tvalid(fadd_in_valid),
    .s_axis_b_tdata(fadd_in_B),
    .m_axis_result_tlast(fadd_res_tlast),
    .m_axis_result_tvalid(fadd_res_valid),
    .m_axis_result_tdata(fadd_res)
  );

  logic ignore_psum_read;

  logic pe_output_valid_delayed;
  FifoBuffer #(.DATA_SIZE(1), .CYCLES(BUFFER_READ_LATENCY) )  pe_output_valid_delayed_fifo (.clk(clk), .in(pe_output_valid), .out(pe_output_valid_delayed));
  logic [FSIZE-1:0] pe_out_data_delayed;
  FifoBuffer #(.DATA_SIZE(FSIZE), .CYCLES(BUFFER_READ_LATENCY) )  pe_out_data_delayed_fifo (.clk(clk), .in(pe_out_data), .out(pe_out_data_delayed));



  logic psum_buffer_wdata_sel;
  Controller controller(
    .rstn(rstn),
    .clk(clk),

    .pe_rstn(pe_rstn),

    .commanddataport(commanddataport),
    .stateport(stateport),
    
    .commanddataport_axi(commanddataport_axi),
    .commanddataport_axi_store(commanddataport_axi_store),
    .stateport_axi(stateport_axi),

    .axi_in_valid(axi_in_valid),

    .axi_out_valid(axi_out_valid),
    .axi_out_ready(axi_out_ready),

    .slice_data_wren(slice_data_wren),
    .slice_data_waddr(slice_data_waddr),
    .slice_data_raddr(slice_data_raddr),

    .ordering_vector_wren(ordering_vector_wren),
    .ordering_vector_waddr(ordering_vector_waddr),
    .ordering_vector_raddr(ordering_vector_raddr),

    .ordering_vector_rdata(ordering_vector_rdata),

    .query_vector_wren(query_vector_wren),
    .query_vector_waddr(query_vector_waddr),
    .query_vector_raddr(query_vector_raddr),

    .pe_input_valid(pe_input_valid),
    .pe_input_last(pe_input_last),
    .pe_output_valid(pe_output_valid),

    .ignore_psum_read(ignore_psum_read),

    .fadd_res_valid(fadd_res_valid),
    .fadd_res(fadd_res),

    .psum_read_buffer_raddr(psum_read_buffer_raddr),
    .psum_read_buffer_waddr(psum_read_buffer_waddr),
    .psum_read_buffer_wren(psum_read_buffer_wren),


    .psum_write_buffer_raddr(psum_write_buffer_raddr),
    .psum_write_buffer_waddr(psum_write_buffer_waddr),
    .psum_write_buffer_wren(psum_write_buffer_wren)
  );

  assign pe_A_data = query_vector_rdata;
  assign pe_B_data = slice_data_rdata;
  
  assign fadd_in_A = pe_out_data_delayed;
  assign fadd_in_B = ignore_psum_read ? '0 : psum_read_buffer_rdata;

  assign fadd_in_valid = pe_output_valid_delayed;
  assign fadd_in_tlast = 0;

  assign psum_write_buffer_wdata = fadd_res;
  
endmodule
