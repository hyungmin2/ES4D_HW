`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;

module pl_main #
(
	parameter integer SIM_MODE	= 0
)
(		
    output axi_output AXI_HP0_output   ,
    input  axi_input  AXI_HP0_input    ,

    input   axi_lite_output AXI_LITE_output     ,
    output  axi_lite_input  AXI_LITE_input      ,
        
    input logic clk,
    input logic rstn
);    

  logic[AXI_LITE_ARG_NUM-1:0][AXI_LITE_WORD_WIDTH-1:0] kernel_engine_arg;
  logic[AXI_LITE_ARG_NUM-1:0][AXI_LITE_WORD_WIDTH-1:0] kernel_engine_status;	
	
  logic kernel_command_reg_new;
  logic [7:0] kernel_command_reg;
    
  AXI_reg_intf axi_reg_intf (
    .clk(clk),
    .rstn(rstn),
    
    .AXI_LITE_output  (AXI_LITE_output),
    .AXI_LITE_input   (AXI_LITE_input),
    
    .kernel_command         (kernel_command_reg),
    .kernel_command_new     (kernel_command_reg_new),
    .kernel_engine_arg      (kernel_engine_arg),
    .kernel_engine_status   (kernel_engine_status)
  );

  logic axi_in_valid;
	logic [FSIZE-1:0] axi_in_data;
		
	logic axi_out_valid;
	logic [FSIZE-1:0] axi_out_data;
  logic axi_out_ready;

  CommandDataPort commanddataport_axi;
  CommandDataPort commanddataport_axi_store;
  logic [STATE_WIDTH-1:0] stateport_axi;

  CommandDataPort commanddataport;
  StatePort stateport;

  risa_top risa_top (
    .clk(clk),
    .rstn(rstn),

    .axi_in_valid(axi_in_valid),
    .axi_in_data(axi_in_data),

    .axi_out_valid(axi_out_valid),
    .axi_out_ready(axi_out_ready),
    .axi_out_data(axi_out_data),

    .commanddataport_axi(commanddataport_axi),
    .commanddataport_axi_store(commanddataport_axi_store),
    .stateport_axi(stateport_axi),

    .commanddataport(commanddataport),
    .stateport(stateport)
  );

  
  axi_read_output           axi_read_output_0;
  axi_read_input_nodata     axi_read_input_0;
  logic[31:0]               axi_read_input_rdata_0; 
  
  axi_write_output_nodata   axi_write_output_1;
  logic[31:0]               axi_write_output_wdata_1;
  logic[3:0]                axi_write_output_wstrb_1;
  axi_write_input           axi_write_input_1;

  
  assign axi_in_data = axi_read_input_rdata_0;
  assign axi_write_output_wstrb_1 = '1;

  axi_intc_wrapper axi_intc( 
    .rstn(rstn),
    .clk(clk),

    .AXI_input(AXI_HP0_input),
    .AXI_output(AXI_HP0_output),
    
    .read_output_0(axi_read_output_0) ,
    .read_input_0(axi_read_input_0) ,  
    .read_input_rdata_0(axi_read_input_rdata_0) ,  

    .write_output_1(axi_write_output_1) ,              
    .write_output_wdata_1(axi_write_output_wdata_1) ,              
    .write_output_wstrb_1(axi_write_output_wstrb_1) ,              
    .write_input_1(axi_write_input_1)
  );

  	

  logic loader_busy;
  logic loader_ready;
  AXILoader #(.ARSIZE(3'b010),.DATA_SIZE(FSIZE)) axi_loader_rb(
    .rstn(rstn),
    .clk(clk),
    
    .address(commanddataport_axi.data0),
    .size(commanddataport_axi.data1),
    .trigger(commanddataport_axi.valid && commanddataport_axi.command==COMMAND_AXI_LOAD),
    .busy(loader_busy),
    .ready(loader_ready),
    
    .o_valid(axi_in_valid),    
    .i_ready(1'b1),    
    
    .AXI_input(axi_read_input_0),
    .AXI_output(axi_read_output_0)
  );


  logic writer_busy;
  logic axi_writer_accept;
  logic fifo_ob_full;
  logic fifo_ob_almost_full;
  
  FIFO_W32_D128_AF fifo_ob (
    .srst(!rstn),
    .clk(clk),
    .full(fifo_ob_full), 
    .prog_full(fifo_ob_almost_full), 
    .din(axi_out_data),
    .wr_en(axi_out_valid),
    .empty(fifo_empty),
    .dout(axi_write_output_wdata_1),
    .rd_en(axi_writer_accept)
  );

  assign axi_out_ready = !fifo_ob_almost_full;

  AXIWriter #(.AWSIZE(3'b010),.DATA_SIZE(FSIZE)) axi_writer_ob(
    .rstn(rstn),
    .clk(clk),
    
    .address(commanddataport_axi_store.data0),
    .size(commanddataport_axi_store.data1),
    .trigger(commanddataport_axi_store.valid && commanddataport_axi_store.command==COMMAND_AXI_STORE),
    .busy(writer_busy),
    
    .i_valid(!fifo_empty),    
    .o_accept(axi_writer_accept),    
        
    .AXI_input(axi_write_input_1),
    .AXI_output(axi_write_output_1)
  );  

  
    

  typedef struct {
    logic empty;
  } reg_control;

  reg_control reg_ctrl, reg_ctrl_next;
        
	always_comb begin
    reg_ctrl_next = reg_ctrl;
    
    //read values for GP1
    kernel_engine_status[0] = stateport.state0;
    kernel_engine_status[1] = stateport.state1;
    kernel_engine_status[2] = stateport.state2;
    kernel_engine_status[3] = stateport.state3;
    kernel_engine_status[4] = stateport.state4;
    kernel_engine_status[5] = stateport.state5;
    kernel_engine_status[6] = stateport.state6;
    kernel_engine_status[7] = stateport.state7;
    kernel_engine_status[8] = stateport.state8;
    kernel_engine_status[9] = stateport.state9;
    kernel_engine_status[10] = stateport.state10;
    kernel_engine_status[11] = stateport.state11;
    kernel_engine_status[12] = stateport.state12;
    kernel_engine_status[13] = stateport.state13;
    kernel_engine_status[14] = stateport.state14;
    kernel_engine_status[15] = stateport.state15;

    stateport_axi = 0;
    stateport_axi[0] = loader_ready;
    
    commanddataport.valid = 0;
    commanddataport.command = kernel_engine_arg[1];
    commanddataport.data0 = kernel_engine_arg[2];
    commanddataport.data1 = kernel_engine_arg[3];
    if(kernel_command_reg_new) begin
      commanddataport.valid = 1;
    end    
  end
  
  
  always @( posedge clk ) begin
    reg_ctrl <= reg_ctrl_next;
  end
 
    
endmodule

module AXI_reg_intf   (		
    input logic clk,
    input logic rstn,

    input  axi_lite_output AXI_LITE_output     ,           //output/input name is seen from the master
    output axi_lite_input  AXI_LITE_input      ,

    output  logic [7:0]	kernel_command,
		output  logic	      kernel_command_new,
    output  logic[AXI_LITE_ARG_NUM-1:0][AXI_LITE_WORD_WIDTH-1:0]	kernel_engine_arg,
		input   logic[AXI_LITE_ARG_NUM-1:0][AXI_LITE_WORD_WIDTH-1:0]	kernel_engine_status

);

  typedef struct {
    logic arready;
    logic rvalid;
    logic awready;
    logic wready;
    logic waddr_received;
    logic wdata_received;
    logic bvalid;
    
    logic kernel_command_new;

    logic [$clog2(AXI_LITE_ARG_NUM)-1:0] write_reg_idx;
    logic [AXI_LITE_WORD_WIDTH-1:0] write_reg_data;
    logic [AXI_LITE_WORD_WIDTH-1:0] read_reg_data;

    logic[AXI_LITE_ARG_NUM-1:0][AXI_LITE_WORD_WIDTH-1:0] kregs;
  } reg_control;

  reg_control reg_ctrl, reg_ctrl_next;
    
  localparam REG_ADDR_IDX_LOW = $clog2(AXI_LITE_WORD_WIDTH/8) ;//3
  localparam REG_ADDR_IDX_HI = REG_ADDR_IDX_LOW + $clog2(AXI_LITE_ARG_NUM); //3+5 = 8
    
	always_comb begin
    reg_ctrl_next = reg_ctrl;

    AXI_LITE_input.arready = 0;
    AXI_LITE_input.awready = 0;
    AXI_LITE_input.bresp = 0;
    AXI_LITE_input.bvalid = 0;
    AXI_LITE_input.rdata = 0;
    AXI_LITE_input.rresp = 0;
    AXI_LITE_input.rvalid = 0;
    AXI_LITE_input.wready = 0;

    kernel_engine_arg = reg_ctrl.kregs;
    kernel_command = reg_ctrl.kregs[0];
    kernel_command_new = reg_ctrl.kernel_command_new;

    if(reg_ctrl.arready) begin
      AXI_LITE_input.arready = 1;
      if(AXI_LITE_output.arvalid) begin
        reg_ctrl_next.arready = 0;
        reg_ctrl_next.rvalid = 1;        
        reg_ctrl_next.read_reg_data = kernel_engine_status[ AXI_LITE_output.araddr[REG_ADDR_IDX_HI:REG_ADDR_IDX_LOW] ];
      end
    end

    if(reg_ctrl.rvalid) begin
      AXI_LITE_input.rvalid = 1;
      AXI_LITE_input.rdata = reg_ctrl.read_reg_data;
      if(AXI_LITE_output.rready) begin
        reg_ctrl_next.rvalid = 0;
        reg_ctrl_next.arready = 1;        
      end
    end


    if(reg_ctrl.awready) begin
      AXI_LITE_input.awready = 1;
      if(AXI_LITE_output.awvalid) begin
        reg_ctrl_next.awready = 0;
        reg_ctrl_next.write_reg_idx = AXI_LITE_output.awaddr[REG_ADDR_IDX_HI:REG_ADDR_IDX_LOW];
        reg_ctrl_next.waddr_received = 1;        
      end
    end

    if(reg_ctrl.wready) begin
      AXI_LITE_input.wready = 1;
      if(AXI_LITE_output.wvalid) begin
        reg_ctrl_next.wready = 0;
        reg_ctrl_next.write_reg_data = AXI_LITE_output.wdata;
        reg_ctrl_next.wdata_received = 1;        
      end
    end


    if(reg_ctrl.waddr_received && reg_ctrl.wdata_received) begin
      reg_ctrl_next.kregs[reg_ctrl.write_reg_idx] = reg_ctrl.write_reg_data;
      reg_ctrl_next.bvalid = 1;    
      reg_ctrl_next.waddr_received = 0;        
      reg_ctrl_next.wdata_received = 0;   
      if(reg_ctrl.write_reg_idx == 0)
        reg_ctrl_next.kernel_command_new = 1;     
    end

    if(reg_ctrl.kernel_command_new) begin
      reg_ctrl_next.kernel_command_new = 0;
    end

    if(reg_ctrl.bvalid) begin
      AXI_LITE_input.bvalid = 1;
      if(AXI_LITE_output.bready) begin
        reg_ctrl_next.bvalid = 0;
        reg_ctrl_next.awready = 1;        
        reg_ctrl_next.wready = 1;
      end    
    end

    if(rstn==0) begin
      reg_ctrl_next.kregs[0] = 32'hDEADBEEF;
      reg_ctrl_next.arready = 1;    
      reg_ctrl_next.rvalid = 0;
      reg_ctrl_next.awready = 1;    
      reg_ctrl_next.wready = 1;    
      reg_ctrl_next.waddr_received = 0;    
      reg_ctrl_next.wdata_received = 0;    
      reg_ctrl_next.bvalid = 0;    
      reg_ctrl_next.kernel_command_new = 0;    
    end
  end
    
  always @( posedge clk ) begin
    reg_ctrl <= reg_ctrl_next;
  end

endmodule