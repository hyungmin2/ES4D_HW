`timescale 1 ns / 1 ns

`include "defines.vh"
import RISA_PKG::*;

(* use_dsp = "no" *) module Controller  (
    input rstn,
    input clk,

    output logic pe_rstn,

    input CommandDataPort commanddataport,
    output StatePort stateport,
    
    output CommandDataPort commanddataport_axi,
    output CommandDataPort commanddataport_axi_store,
    input logic [STATE_WIDTH-1:0] stateport_axi,

    input logic axi_in_valid,
    
    output logic axi_out_valid,
    input logic axi_out_ready,
   
    output logic slice_data_wren,
    output logic [$clog2(SLICE_BUFFER_SIZE*2)-1:0]  slice_data_waddr,
    output logic [$clog2(SLICE_BUFFER_SIZE*2)-1:0]  slice_data_raddr,
   
    output logic ordering_vector_wren,
    output logic [$clog2(ORDER_BUFFER_SIZE*2)-1:0]  ordering_vector_waddr,
    output logic [$clog2(ORDER_BUFFER_SIZE*2)-1:0]  ordering_vector_raddr,
   
    input logic[FSIZE-1:0] ordering_vector_rdata,

    output logic query_vector_wren,
    output logic [$clog2(QUERY_BUFFER_SIZE)-1:0]  query_vector_waddr,
    output logic [$clog2(QUERY_BUFFER_SIZE)-1:0]  query_vector_raddr,


    output logic pe_input_valid,
    output logic pe_input_last,
    input logic pe_output_valid,

    output logic ignore_psum_read,

    input logic fadd_res_valid,
    input logic [FSIZE-1:0] fadd_res,

    output logic psum_read_buffer_wren,
    output logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0]  psum_read_buffer_waddr,
    output logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0]  psum_read_buffer_raddr,

    output logic psum_write_buffer_wren,
    output logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0]  psum_write_buffer_waddr,
    output logic [$clog2(PSUM_BUFFER_SIZE*2)-1:0]  psum_write_buffer_raddr
);
  localparam AXI_LOAD_QUERY = 1;
  localparam AXI_LOAD_SLICE_DATA = 2;
  localparam AXI_LOAD_ORDERING_VECTOR = 0;
  localparam AXI_LOAD_PSUM = 4;
  localparam AXI_OUT_WORKING = 1;
  
  localparam STATE_LOAD_SLICE_DATA = 1;
  localparam STATE_LOAD_SLICE_DATA_START = 2;
  localparam STATE_LOAD_ORDERING_VECTOR = 3;
  localparam STATE_LOAD_PSUM_BUFFER = 4;
  localparam STATE_DIST_CALC_START = 5;
  localparam STATE_DIST_CALC = 6;
  localparam STATE_DIST_CALC_WAIT = 7;
  localparam STATE_STORE_PSUM_BUFFER_START = 8;
  localparam STATE_STORE_PSUM_BUFFER = 9;
  localparam STATE_CHECK_NEXT_WORK = 10;
  localparam STATE_LOAD_PSUM_BUFFER_BEFORE = 11;
  localparam STATE_LOAD_SLICE_DATA_BEFORE = 12;


  localparam WORK_FIFO_WIDTH = FSIZE*2 + ASIZE*5 + 2;
  logic [WORK_FIFO_WIDTH-1:0] work_fifo_din;
  logic [WORK_FIFO_WIDTH-1:0] work_fifo_dout;
  logic work_fifo_push;
  logic work_fifo_pop;
  logic work_fifo_empty;
  logic work_fifo_full;

  FIFO_W226_D128 work_fifo (
    .clk(clk),
    .srst(!rstn),
    .wr_en(work_fifo_push),
    .din(work_fifo_din),
    .rd_en(work_fifo_pop),
    .dout(work_fifo_dout),
    .empty(work_fifo_empty),
    .full(work_fifo_full)
  );

  logic [FSIZE-1:0] complete_fifo_din;
  logic [FSIZE-1:0] complete_fifo_dout;
  logic complete_fifo_push;
  logic complete_fifo_pop;
  logic complete_fifo_empty;
  logic complete_fifo_full;

  FIFO_W32_D128 complete_fifo (
    .clk(clk),
    .srst(!rstn),
    .wr_en(complete_fifo_push),
    .din(complete_fifo_din),
    .rd_en(complete_fifo_pop),
    .dout(complete_fifo_dout),
    .empty(complete_fifo_empty),
    .full(complete_fifo_full)
  );




  typedef struct packed{
    logic [COMMAND_WIDTH-1:0] command;        
    logic [FSIZE-1:0]  command_data0;
    logic [FSIZE-1:0]  command_data1;

    logic [FSIZE-1:0] axi_in_state;
    logic [FSIZE-1:0] axi_out_state;
    logic [FSIZE-1:0] work_load_state;
    logic [FSIZE-1:0] work_compute_state;
    logic [FSIZE-1:0] work_store_state;
    
    logic [$clog2(MAX_BUFFER_SIZE+1)-1:0] axi_store_size;
    logic [$clog2(MAX_BUFFER_SIZE)-1:0] axi_stored;

    logic [$clog2(QUERY_BUFFER_SIZE)-1:0] axi_loaded_query;
    logic [$clog2(SLICE_BUFFER_SIZE)-1:0] axi_loaded_slice;
    logic [$clog2(ORDER_BUFFER_SIZE)-1:0] axi_loaded_ordering;
    logic [$clog2(PSUM_BUFFER_SIZE)-1:0]  axi_loaded_psum;

    logic [$clog2(MAX_VECTOR_LEN+1):0] VECTOR_LEN;
    logic [$clog2(MAX_VECTORS_PER_GROUP)-1:0] VECTORS_PER_GROUP;
    logic [$clog2(MAX_VECTOR_LEN_PER_SLICE)-1:0] VECTOR_LEN_PER_SLICE;

    logic [$clog2(MAX_VECTOR_LEN_PER_SLICE)-1:0] dist_calc_idx;
    logic [$clog2(SLICE_BUFFER_SIZE)-1:0] slice_data_offset;
    logic [$clog2(SLICE_BUFFER_SIZE)-1:0] slice_data_offset_base;
    logic [$clog2(MAX_VECTORS_PER_GROUP)-1:0] dist_calc_vector_id;
    logic [$clog2(MAX_VECTORS_PER_GROUP)-1:0] psum_load_vector_id;
    logic [$clog2(MAX_VECTORS_PER_GROUP)-1:0] psum_store_vector_id;

    logic axi_out_ready;

    WorkItem work_item_in;
    
    WorkItem work_item_load;
    WorkItem work_item_load_wait0;    
    WorkItem work_item_load_wait1;    
    WorkItem work_item_compute;
    WorkItem work_item_compute0;
    WorkItem work_item_compute1;
    logic work_item_compute0_valid;
    logic work_item_compute1_valid;
    WorkItem work_item_store;
    WorkItem work_item_store0;
    WorkItem work_item_store1;
    logic work_item_store0_valid;
    logic work_item_store1_valid;
    
    logic load_phase;
    logic compute_phase;
    logic store_phase;
    logic [1:0] load_token;
    logic [1:0] store_token;
    logic phase_for_new_item;

    logic [STATE_WIDTH-1:0] stateport_axi;
    
    logic [FSIZE-1:0] cutoff;
    logic below_cutoff;

    logic count;
    logic [FSIZE-1:0] count_all;
    logic [FSIZE-1:0] count_incoming_axi_data;
    logic [FSIZE-1:0] count_axi_in_state_AXI_LOAD_ORDERING_VECTOR;
    logic [FSIZE-1:0] count_axi_in_state_AXI_LOAD_PSUM;
    logic [FSIZE-1:0] count_axi_in_state_AXI_LOAD_SLICE_DATA;
    logic [FSIZE-1:0] count_work_compute_state_STATE_IDLE;
    logic [FSIZE-1:0] count_work_compute_state_STATE_DIST_CALC_START;
    logic [FSIZE-1:0] count_work_compute_state_STATE_DIST_CALC_WAIT;
    logic [FSIZE-1:0] count_work_store_state_STATE_IDLE;
    logic [FSIZE-1:0] count_work_store_state_STATE_STORE_PSUM_BUFFER;
  } Registers;
    
  Registers reg_current,reg_next;

  logic axi_out_valid_fifo_in;
  FifoBuffer #(.DATA_SIZE(1), .CYCLES(BUFFER_READ_LATENCY) )  axi_out_valid_fifo (.clk(clk), .in(axi_out_valid_fifo_in), .out(axi_out_valid));

  logic [$clog2(SLICE_BUFFER_SIZE)-1:0] slice_data_raddr_calculated_fifo_in0;
  logic [$clog2(SLICE_BUFFER_SIZE):0] slice_data_raddr_calculated_fifo_in, slice_data_raddr_calculated;
  FifoBuffer #(.DATA_SIZE($clog2(SLICE_BUFFER_SIZE)+1), .CYCLES(BUFFER_READ_LATENCY) )  slice_data_raddr_calculated_fifo (.clk(clk), .in(slice_data_raddr_calculated_fifo_in), .out(slice_data_raddr_calculated));

  logic ordering_vector_ready_fifo_in, ordering_vector_ready;
  FifoBuffer #(.DATA_SIZE(1), .CYCLES(BUFFER_READ_LATENCY) )  ordering_vector_ready_fifo (.clk(clk), .in(ordering_vector_ready_fifo_in), .out(ordering_vector_ready));
  logic dist_calc_input_tlast_fifo_in, dist_calc_input_tlast;
  FifoBuffer #(.DATA_SIZE(1), .CYCLES(BUFFER_READ_LATENCY*2) )  dist_calc_input_tlast_fifo (.clk(clk), .in(dist_calc_input_tlast_fifo_in), .out(dist_calc_input_tlast));
  logic query_slice_data_ready_fifo_in, query_slice_data_ready;
  FifoBuffer #(.DATA_SIZE(1), .CYCLES(BUFFER_READ_LATENCY) )  query_slice_data_ready_fifo (.clk(clk), .in(query_slice_data_ready_fifo_in), .out(query_slice_data_ready));

  logic load_token_use;
  logic load_token_return;
  logic store_token_use;
  logic store_token_return;
  logic [$clog2(ORDER_BUFFER_SIZE)-1:0]  ordering_vector_raddr0;

  always_comb begin
    reg_next = reg_current;
       
    stateport.state0 = !complete_fifo_empty;
    stateport.state1 = {reg_current.axi_in_state[15:0],reg_current.axi_out_state[15:0]};
    stateport.state2 = {'0,reg_current.work_store_state[7:0],reg_current.work_compute_state[7:0],reg_current.work_load_state[7:0]};
    stateport.state3 = complete_fifo_dout;

    stateport.state4 = reg_current.count_all;
    stateport.state5 = reg_current.count_incoming_axi_data;
    stateport.state6 = reg_current.count_axi_in_state_AXI_LOAD_ORDERING_VECTOR;
    stateport.state7 = reg_current.count_axi_in_state_AXI_LOAD_PSUM;
    stateport.state8 = reg_current.count_axi_in_state_AXI_LOAD_SLICE_DATA;
    stateport.state9 = reg_current.count_work_compute_state_STATE_IDLE;
    stateport.state10 = reg_current.count_work_compute_state_STATE_DIST_CALC_START;
    stateport.state11 = reg_current.count_work_compute_state_STATE_DIST_CALC_WAIT;
    stateport.state12 = reg_current.count_work_store_state_STATE_IDLE;
    stateport.state13 = reg_current.count_work_store_state_STATE_STORE_PSUM_BUFFER;

    reg_next.axi_out_ready = axi_out_ready;
    reg_next.stateport_axi = stateport_axi;

    commanddataport_axi.valid = 0;
    commanddataport_axi.command = 0;
    commanddataport_axi.data0 = 0;
    commanddataport_axi.data1 = 0;
    
    commanddataport_axi_store.valid = 0;
    commanddataport_axi_store.command = 0;
    commanddataport_axi_store.data0 = 0;
    commanddataport_axi_store.data1 = 0;

    slice_data_wren = 0;
    slice_data_waddr = 0;
    slice_data_raddr = 0;

    ordering_vector_wren = 0;
    ordering_vector_waddr = 0;
    ordering_vector_raddr = 0;

    query_vector_wren = 0;
    query_vector_waddr = 0;
    query_vector_raddr = 0;

    pe_input_valid = 0;
    pe_input_last = 0;
    // psum_start_new = 0;
    psum_read_buffer_wren = 0;
    psum_read_buffer_waddr = 0;
    psum_read_buffer_raddr = 0;
    psum_write_buffer_wren = 0;
    psum_write_buffer_waddr = 0;
    psum_write_buffer_raddr = 0;
    
    work_fifo_din = 0;
    work_fifo_push = 0;
    work_fifo_pop = 0;

    complete_fifo_din = 0;
    complete_fifo_push = 0;
    complete_fifo_pop = 0;

    load_token_use = 0;
    load_token_return = 0;    
    store_token_use = 0;
    store_token_return = 0;
    


    reg_next.command = 0;
    if(commanddataport.valid) begin
      reg_next.command = commanddataport.command;       
      reg_next.command_data0 = commanddataport.data0;       
      reg_next.command_data1 = commanddataport.data1;       
    end

    pe_rstn = 1;
    if(reg_current.command == COMMAND_PE_RESET) begin 
      pe_rstn = 0;
    end

    if(reg_current.command == COMMAND_SET_VECTOR_LEN) begin 
      reg_next.VECTOR_LEN = reg_current.command_data0;
    end
    if(reg_current.command == COMMAND_SET_VECTORS_PER_GROUP) begin 
      reg_next.VECTORS_PER_GROUP = reg_current.command_data0;
    end
    if(reg_current.command == COMMAND_SET_VECTOR_LEN_PER_SLICE) begin 
      reg_next.VECTOR_LEN_PER_SLICE = reg_current.command_data0;
    end
       
    if(reg_current.command == COMMAND_SET_CUTOFF) begin 
      reg_next.cutoff = reg_current.command_data0;
    end
       
    //++ COMMAND_DIST_CALC
    if(reg_current.command == COMMAND_DIST_CALC1) begin 
      reg_next.work_item_in.stream_id = reg_current.command_data0;
      reg_next.work_item_in.vector_count = reg_current.command_data1;
    end
    if( reg_current.command == COMMAND_DIST_CALC2) begin 
      reg_next.work_item_in.addr_ordering_vector = reg_current.command_data0;
      reg_next.work_item_in.addr_data_slice = reg_current.command_data1;
      reg_next.work_item_in.shard_size = reg_current.VECTOR_LEN_PER_SLICE; //if shard_size is not explicitly set by COMMAND_DIST_CALC2_1 in between COMMAND_DIST_CALC2 and COMMAND_DIST_CALC3, the default value of shard_size is the same as reg_current.VECTOR_LEN_PER_SLICE
    end   
    if( reg_current.command == COMMAND_DIST_CALC2_1) begin 
      reg_next.work_item_in.shard_size = reg_current.command_data0;
    end   
    if( reg_current.command == COMMAND_DIST_CALC3 || reg_current.command == COMMAND_DIST_CALC3_FIRST) begin 
      reg_next.work_item_in.addr_partial_sum_in = reg_current.command_data0;
      reg_next.work_item_in.addr_partial_sum_out = reg_current.command_data1;

      reg_next.work_item_in.first_slice = 0;
      if(reg_current.command == COMMAND_DIST_CALC3_FIRST) reg_next.work_item_in.first_slice = 1;
      work_fifo_push = 1;

      reg_next.phase_for_new_item = !reg_current.phase_for_new_item;
    end    

    work_fifo_din = {
      reg_next.work_item_in.stream_id,
      reg_next.work_item_in.vector_count,
      reg_next.work_item_in.addr_ordering_vector,
      reg_next.work_item_in.addr_data_slice,
      reg_next.work_item_in.addr_partial_sum_in,
      reg_next.work_item_in.addr_partial_sum_out,
      reg_next.work_item_in.shard_size,
      reg_current.phase_for_new_item,
      reg_next.work_item_in.first_slice
    };
    //-- COMMAND_DIST_CALC

    //++ COMMAND_POP_COMPLETED
    if(reg_current.command == COMMAND_POP_COMPLETED) begin 
      complete_fifo_pop = 1;
    end
    //-- COMMAND_POP_COMPLETED

    //++ COMMAND_AXI_LOAD_QUERY
    if(reg_current.command == COMMAND_AXI_LOAD_QUERY) begin 
      reg_next.axi_in_state = AXI_LOAD_QUERY;

      commanddataport_axi.valid = 1;
      commanddataport_axi.command = COMMAND_AXI_LOAD;
      commanddataport_axi.data0 = reg_current.command_data0;
      commanddataport_axi.data1 = (FSIZE/8) * reg_current.VECTOR_LEN;

      //reg_next.axi_load_size = VECTOR_LEN;
      reg_next.axi_loaded_query = 0;
    end    

    query_vector_waddr = reg_current.axi_loaded_query;
    query_vector_wren = 0;
    
    if(axi_in_valid) begin
      if(reg_current.axi_in_state == AXI_LOAD_QUERY)  begin
        reg_next.axi_loaded_query = reg_current.axi_loaded_query + 1;
        query_vector_wren = 1;

        if(reg_current.axi_loaded_query == reg_current.VECTOR_LEN - 1) begin
          reg_next.axi_loaded_query = 0;
          reg_next.axi_in_state = AXI_LOAD_ORDERING_VECTOR;       
        end
      end
    end
    //-- COMMAND_AXI_LOAD_QUERY       

    //++ input from AXI loader control
    slice_data_waddr = {reg_current.load_phase,reg_current.axi_loaded_slice};
    slice_data_wren = 0;
    ordering_vector_waddr = {reg_current.load_phase,reg_current.axi_loaded_ordering};
    ordering_vector_wren = 0;
    psum_read_buffer_waddr = {reg_current.load_phase,reg_current.axi_loaded_psum};
    psum_read_buffer_wren = 0;

    if(axi_in_valid) begin      
      if(reg_current.axi_in_state == AXI_LOAD_ORDERING_VECTOR)  begin
        reg_next.axi_loaded_ordering = reg_current.axi_loaded_ordering + 1;
        ordering_vector_wren = 1;

        if(reg_current.axi_loaded_ordering == reg_current.VECTOR_LEN_PER_SLICE - 1) begin
          reg_next.axi_loaded_ordering = 0;
          reg_next.axi_in_state = AXI_LOAD_PSUM;       
        end
      end
      else if(reg_current.axi_in_state == AXI_LOAD_PSUM)  begin
        reg_next.axi_loaded_psum = reg_current.axi_loaded_psum + 1;
        psum_read_buffer_wren = 1;

        if(reg_current.axi_loaded_psum == reg_current.VECTORS_PER_GROUP - 1) begin
          reg_next.axi_loaded_psum = 0;
          reg_next.axi_in_state = AXI_LOAD_SLICE_DATA;                        
        end
      end
      else if(reg_current.axi_in_state == AXI_LOAD_SLICE_DATA)  begin
        reg_next.axi_loaded_slice = reg_current.axi_loaded_slice + 1;
        slice_data_wren = 1;

        if(reg_current.axi_loaded_slice == SLICE_WORDS - 1) begin
          reg_next.axi_loaded_slice = 0;

          reg_next.axi_in_state = AXI_LOAD_ORDERING_VECTOR;      
          reg_next.load_phase = !reg_current.load_phase;

          if(reg_current.load_phase == 0)  begin
            reg_next.work_item_compute0 = reg_current.work_item_load_wait0; 
            reg_next.work_item_compute0_valid = 1;
          end
          else begin
            reg_next.work_item_compute1 = reg_current.work_item_load_wait1; 
            reg_next.work_item_compute1_valid = 1;
          end
        end
      end
    end
    //-- input from AXI loader control


    //++Load FSM    
    if(reg_current.work_load_state == STATE_IDLE && !work_fifo_empty && reg_current.load_token > 0) begin    
      work_fifo_pop = 1;
      load_token_use = 1;

      {
        reg_next.work_item_load.stream_id,
        reg_next.work_item_load.vector_count,
        reg_next.work_item_load.addr_ordering_vector,
        reg_next.work_item_load.addr_data_slice,
        reg_next.work_item_load.addr_partial_sum_in,
        reg_next.work_item_load.addr_partial_sum_out,
        reg_next.work_item_load.shard_size,
        reg_next.work_item_load.phase,
        reg_next.work_item_load.first_slice
      } = work_fifo_dout;
    
      reg_next.work_load_state = STATE_LOAD_ORDERING_VECTOR;
    end
    else if(reg_current.work_load_state == STATE_LOAD_ORDERING_VECTOR && reg_current.stateport_axi == 1) begin
      commanddataport_axi.valid = 1;
      commanddataport_axi.command = COMMAND_AXI_LOAD;
      commanddataport_axi.data0 = reg_current.work_item_load.addr_ordering_vector;
      commanddataport_axi.data1 = (FSIZE/8) * reg_current.VECTOR_LEN_PER_SLICE;

      // reg_next.axi_load_size = VECTOR_LEN_PER_SLICE;
      // reg_next.axi_loaded_ordering = 0;

      reg_next.work_load_state = STATE_LOAD_PSUM_BUFFER_BEFORE;
    end
    else if(reg_current.work_load_state == STATE_LOAD_PSUM_BUFFER_BEFORE) begin
      reg_next.work_load_state = STATE_LOAD_PSUM_BUFFER;
    end
    else if(reg_current.work_load_state == STATE_LOAD_PSUM_BUFFER && reg_current.stateport_axi == 1) begin
      commanddataport_axi.valid = 1;
      commanddataport_axi.command = COMMAND_AXI_LOAD;
      commanddataport_axi.data0 = reg_current.work_item_load.addr_partial_sum_in;
      commanddataport_axi.data1 = (FSIZE/8) * reg_current.VECTORS_PER_GROUP;

      // reg_next.axi_load_size = VECTORS_PER_GROUP;
      // reg_next.axi_loaded_psum = 0;

      reg_next.work_load_state = STATE_LOAD_SLICE_DATA_BEFORE;
    end
    else if(reg_current.work_load_state == STATE_LOAD_SLICE_DATA_BEFORE) begin
      reg_next.work_load_state = STATE_LOAD_SLICE_DATA;
    end
    else if(reg_current.work_load_state == STATE_LOAD_SLICE_DATA && reg_current.stateport_axi == 1) begin
      commanddataport_axi.valid = 1;
      commanddataport_axi.command = COMMAND_AXI_LOAD;
      commanddataport_axi.data0 = reg_current.work_item_load.addr_data_slice;
      commanddataport_axi.data1 = (FSIZE/8) * SLICE_WORDS;

      // reg_next.axi_load_size = SLICE_WORD;
      // reg_next.axi_loaded_slice = 0;
      
      reg_next.work_load_state = STATE_IDLE;

      if(reg_current.work_item_load.phase == 0)  begin
        reg_next.work_item_load_wait0 = reg_current.work_item_load; 
      end
      else begin
        reg_next.work_item_load_wait1 = reg_current.work_item_load; 
      end
    end
    //----Load Stage
    


    //++++Compute Stage
    if(reg_current.work_compute_state == STATE_IDLE) begin
      if(reg_current.compute_phase == 0 && reg_current.work_item_compute0_valid) begin
        reg_next.work_item_compute = reg_current.work_item_compute0;
        reg_next.work_item_compute0_valid = 0;
        reg_next.work_compute_state = STATE_DIST_CALC_START;      
      end
      else if(reg_current.compute_phase == 1 && reg_current.work_item_compute1_valid) begin
        reg_next.work_item_compute = reg_current.work_item_compute1;
        reg_next.work_item_compute1_valid = 0;
        reg_next.work_compute_state = STATE_DIST_CALC_START;      
      end
    end

    ignore_psum_read = reg_current.work_item_compute.first_slice;

    ordering_vector_ready_fifo_in = 0;
    dist_calc_input_tlast_fifo_in = 0;
    slice_data_raddr_calculated_fifo_in0 = 0;

    if(reg_current.work_compute_state == STATE_DIST_CALC_START && reg_current.store_token > 0) begin
      reg_next.work_compute_state = STATE_DIST_CALC;      
      reg_next.dist_calc_idx = 0;
      reg_next.slice_data_offset = 0;
      reg_next.slice_data_offset_base = 0;
      reg_next.dist_calc_vector_id = 0;
      reg_next.psum_load_vector_id = 0;
      reg_next.psum_store_vector_id = 0;
      reg_next.below_cutoff = 0;

      store_token_use = 1;
    end
    else if(reg_current.work_compute_state == STATE_DIST_CALC) begin      
      reg_next.dist_calc_idx = reg_current.dist_calc_idx + 1;

      reg_next.slice_data_offset = reg_current.slice_data_offset + 1;

      if(reg_current.dist_calc_idx == reg_current.work_item_compute.shard_size-1) begin
        reg_next.dist_calc_idx = 0;
        reg_next.dist_calc_vector_id = reg_current.dist_calc_vector_id + 1;
        reg_next.slice_data_offset_base = reg_current.slice_data_offset_base + reg_current.VECTOR_LEN_PER_SLICE;
        reg_next.slice_data_offset = reg_current.slice_data_offset_base + reg_current.VECTOR_LEN_PER_SLICE;
        
        dist_calc_input_tlast_fifo_in = 1;

        if(reg_current.dist_calc_vector_id == reg_current.work_item_compute.vector_count-1) begin
          reg_next.dist_calc_vector_id = 0;
          reg_next.slice_data_offset = 0;

          reg_next.work_compute_state = STATE_DIST_CALC_WAIT;
        end
      end
      slice_data_raddr_calculated_fifo_in0 = reg_current.slice_data_offset;     
      slice_data_raddr_calculated_fifo_in = {reg_current.compute_phase,slice_data_raddr_calculated_fifo_in0};
      ordering_vector_raddr0 = reg_current.dist_calc_idx;     
      ordering_vector_raddr = {reg_current.compute_phase,ordering_vector_raddr0};
      ordering_vector_ready_fifo_in = 1; 
    end
    else if(reg_current.work_compute_state == STATE_DIST_CALC_WAIT) begin
      //wait
    end

    query_slice_data_ready_fifo_in = 0;
    if(ordering_vector_ready) begin
      query_vector_raddr = ordering_vector_rdata;
      slice_data_raddr = slice_data_raddr_calculated;
      query_slice_data_ready_fifo_in = 1;
    end
    
    if(query_slice_data_ready) begin
      pe_input_valid = 1;
    end
    pe_input_last = dist_calc_input_tlast;

    if(pe_output_valid) begin
      psum_read_buffer_raddr = {reg_current.compute_phase,reg_current.psum_load_vector_id[$clog2(PSUM_BUFFER_SIZE)-1:0]};
      reg_next.psum_load_vector_id = reg_current.psum_load_vector_id + 1;
    end

    if(fadd_res_valid) begin
      reg_next.psum_store_vector_id = reg_current.psum_store_vector_id + 1;

      psum_write_buffer_wren = 1;
      
      psum_write_buffer_waddr = {reg_current.compute_phase,reg_current.psum_store_vector_id[$clog2(PSUM_BUFFER_SIZE)-1:0]};

      if(fadd_res < reg_current.cutoff) begin
        reg_next.below_cutoff = 1;
      end

      if(reg_current.psum_store_vector_id == reg_current.work_item_compute.vector_count-1) begin
        reg_next.psum_store_vector_id = 0;

        reg_next.work_compute_state = STATE_IDLE;
        reg_next.compute_phase = !reg_current.compute_phase;
        load_token_return = 1;

        if(reg_current.compute_phase == 0)  begin
          reg_next.work_item_store0 = reg_current.work_item_compute; 
          reg_next.work_item_store0.below_cutoff = reg_next.below_cutoff;
          reg_next.work_item_store0_valid = 1;
        end
        else begin
          reg_next.work_item_store1 = reg_current.work_item_compute; 
          reg_next.work_item_store1.below_cutoff = reg_next.below_cutoff;
          reg_next.work_item_store1_valid = 1;
        end
      end
    end
    //----Compute Stage


    //++++Store Stage
    if(reg_current.work_store_state == STATE_IDLE) begin
      if(reg_current.store_phase == 0 && reg_current.work_item_store0_valid) begin
        reg_next.work_item_store = reg_current.work_item_store0;
        reg_next.work_item_store0_valid = 0;
        reg_next.work_store_state = STATE_STORE_PSUM_BUFFER_START;      
      end
      else if(reg_current.store_phase == 1 && reg_current.work_item_store1_valid) begin
        reg_next.work_item_store = reg_current.work_item_store1;
        reg_next.work_item_store1_valid = 0;
        reg_next.work_store_state = STATE_STORE_PSUM_BUFFER_START;      
      end
    end
    if(reg_current.work_store_state == STATE_STORE_PSUM_BUFFER_START) begin
      reg_next.work_store_state = STATE_STORE_PSUM_BUFFER;    

      reg_next.axi_out_state = AXI_OUT_WORKING;

      commanddataport_axi_store.valid = 1;
      commanddataport_axi_store.command = COMMAND_AXI_STORE;
      commanddataport_axi_store.data0 = reg_current.work_item_store.addr_partial_sum_out;
      commanddataport_axi_store.data1 = (FSIZE/8) * reg_current.VECTORS_PER_GROUP;

      reg_next.axi_store_size = reg_current.VECTORS_PER_GROUP;
      reg_next.axi_stored = 0;
    end
    else if(reg_current.work_store_state == STATE_STORE_PSUM_BUFFER) begin
      if(reg_current.axi_out_state == STATE_IDLE) begin
        complete_fifo_din = {reg_current.work_item_store.below_cutoff,reg_current.work_item_store.stream_id[FSIZE-2:0]};
        complete_fifo_push = 1;
     
        reg_next.work_store_state = STATE_IDLE;
      end
    end

    
    //++output to AXI writer control
    axi_out_valid_fifo_in = 0;
    if(reg_current.axi_out_state == AXI_OUT_WORKING)  begin
      if(reg_current.axi_out_ready ) begin
        
        axi_out_valid_fifo_in = 1;

        reg_next.axi_stored = reg_current.axi_stored + 1;
        
        if(reg_current.axi_stored == reg_current.axi_store_size-1) begin
          reg_next.axi_stored = 0;
          reg_next.axi_out_state = STATE_IDLE;    

          store_token_return = 1;   
          reg_next.store_phase = !reg_current.store_phase;
        end

        psum_write_buffer_raddr = {reg_current.store_phase,reg_current.axi_stored[$clog2(PSUM_BUFFER_SIZE)-1:0]};
      end
    end      
    //--output to AXI writer control

    if(reg_current.count) begin
      reg_next.count_all      = reg_current.count_all + 1;
      if(axi_in_valid) reg_next.count_incoming_axi_data      = reg_current.count_incoming_axi_data + 1;

      if(reg_current.axi_in_state == AXI_LOAD_ORDERING_VECTOR ) reg_next.count_axi_in_state_AXI_LOAD_ORDERING_VECTOR = reg_current.count_axi_in_state_AXI_LOAD_ORDERING_VECTOR + 1;
      if(reg_current.axi_in_state == AXI_LOAD_PSUM            ) reg_next.count_axi_in_state_AXI_LOAD_PSUM            = reg_current.count_axi_in_state_AXI_LOAD_PSUM + 1;
      if(reg_current.axi_in_state == AXI_LOAD_SLICE_DATA      ) reg_next.count_axi_in_state_AXI_LOAD_SLICE_DATA      = reg_current.count_axi_in_state_AXI_LOAD_SLICE_DATA + 1;

      if(reg_current.work_compute_state == STATE_IDLE           ) reg_next.count_work_compute_state_STATE_IDLE            = reg_current.count_work_compute_state_STATE_IDLE + 1;
      if(reg_current.work_compute_state == STATE_DIST_CALC_START) reg_next.count_work_compute_state_STATE_DIST_CALC_START = reg_current.count_work_compute_state_STATE_DIST_CALC_START + 1;
      if(reg_current.work_compute_state == STATE_DIST_CALC_WAIT ) reg_next.count_work_compute_state_STATE_DIST_CALC_WAIT  = reg_current.count_work_compute_state_STATE_DIST_CALC_WAIT + 1;

      if(reg_current.work_store_state == STATE_IDLE               ) reg_next.count_work_store_state_STATE_IDLE              = reg_current.count_work_store_state_STATE_IDLE + 1;
      if(reg_current.work_store_state == STATE_STORE_PSUM_BUFFER  ) reg_next.count_work_store_state_STATE_STORE_PSUM_BUFFER = reg_current.count_work_store_state_STATE_STORE_PSUM_BUFFER + 1;
    end

    if( reg_current.command == COMMAND_COUNTER_STOP) begin 
     reg_next.count = 0;
    end
    if( reg_current.command == COMMAND_COUNTER_START) begin 
     reg_next.count = 1;
     reg_next.count_all = 0;
     reg_next.count_incoming_axi_data = 0;
     reg_next.count_axi_in_state_AXI_LOAD_ORDERING_VECTOR = 0;
     reg_next.count_axi_in_state_AXI_LOAD_PSUM = 0;
     reg_next.count_axi_in_state_AXI_LOAD_SLICE_DATA = 0;
     reg_next.count_work_compute_state_STATE_IDLE = 0;
     reg_next.count_work_compute_state_STATE_DIST_CALC_START = 0;
     reg_next.count_work_compute_state_STATE_DIST_CALC_WAIT = 0;
     reg_next.count_work_store_state_STATE_IDLE = 0;
     reg_next.count_work_store_state_STATE_STORE_PSUM_BUFFER = 0;
    end
    

    if(load_token_use == 1 && load_token_return == 0) reg_next.load_token = reg_current.load_token -1;
    if(load_token_use == 0 && load_token_return == 1) reg_next.load_token = reg_current.load_token +1;
    if(store_token_use == 1 && store_token_return == 0) reg_next.store_token = reg_current.store_token -1;
    if(store_token_use == 0 && store_token_return == 1) reg_next.store_token = reg_current.store_token +1;

    if(rstn == 0) begin
      reg_next.axi_in_state = AXI_LOAD_ORDERING_VECTOR;
      reg_next.axi_out_state = STATE_IDLE;
      reg_next.work_load_state = STATE_IDLE;
      reg_next.work_compute_state = STATE_IDLE;
      reg_next.work_store_state = STATE_IDLE;
      reg_next.work_item_compute0_valid = 0;
      reg_next.work_item_compute1_valid = 0;
      reg_next.work_item_store0_valid = 0;
      reg_next.work_item_store1_valid = 0;
      reg_next.load_token = 2;
      reg_next.store_token = 2;
      reg_next.phase_for_new_item = 0;
      reg_next.axi_loaded_ordering = 0;
      reg_next.load_phase = 0;
      reg_next.compute_phase = 0;
      reg_next.store_phase = 0;
      reg_next.axi_loaded_slice = 0;
      reg_next.axi_loaded_ordering = 0;
      reg_next.axi_loaded_psum = 0;
      reg_next.count = 0;
      reg_next.cutoff = 32'h7f000000; 
    end

  end
    
	always @( posedge clk ) begin
    reg_current <= reg_next;
	end 
  
endmodule
