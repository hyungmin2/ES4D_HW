`timescale 1 ns / 1 ns

`include "defines.vh"

package RISA_PKG;

typedef struct packed {
    logic [`DDR_ADDR_WIDTH-1:0]     araddr;
    logic [1:0]                     arburst;
    logic [`DDR_ID_WIDTH-1:0]       arid;
    logic [7:0]                     arlen;
    logic [2:0]                     arsize;
    logic                           arvalid;
    logic [`DDR_ADDR_WIDTH-1:0]     awaddr;
    logic [1:0]                     awburst;
    logic [`DDR_ID_WIDTH-1:0]       awid;
    logic [7:0]                     awlen;
    logic [2:0]                     awsize;
    logic                           awvalid;
    logic                           bready;
    logic                           rready;
    logic [`DDR_DATA_WIDTH-1:0]     wdata;
    logic                           wlast;
    logic [`DDR_DATA_WIDTH/8-1:0]   wstrb;
    logic                           wvalid;
} axi_output;
    
typedef struct packed {
    logic                           arready;
    logic                           awready;
    logic [`DDR_ID_WIDTH-1:0]       bid;
    logic [1:0]                     bresp;
    logic                           bvalid;
    logic [`DDR_DATA_WIDTH-1:0]     rdata;
    logic [`DDR_ID_WIDTH-1:0]       rid;
    logic                           rlast;
    logic [1:0]                     rresp;
    logic                           rvalid;
    logic                           wready;
} axi_input;

    
typedef struct packed {
    logic arready;
    logic awready;
    logic [1:0]bresp;
    logic bvalid;
    logic [`GP_DATA_WIDTH-1:0]rdata;
    logic [1:0]rresp;
    logic rvalid;
    logic wready;
} axi_lite_input;
    
typedef struct packed {
    logic [`GP_ADDR_WIDTH-1:0]araddr;
    logic arvalid;
    logic [`GP_ADDR_WIDTH-1:0]awaddr;
    logic awvalid;
    logic bready;
    logic rready;
    logic [`GP_DATA_WIDTH-1:0]wdata;
    logic [`GP_DATA_WIDTH/8-1:0]wstrb;
    logic wvalid;
} axi_lite_output;

    
typedef struct packed {
    logic [`DDR_ADDR_WIDTH-1:0]     araddr;
    logic [1:0]                     arburst;
    logic [`DDR_ID_WIDTH-1:0]       arid;
    logic [7:0]                     arlen;
    logic [2:0]                     arsize;
    logic                           arvalid;
    logic                           rready;
} axi_read_output;

typedef struct packed {
    logic                           awready;
    logic [`DDR_ID_WIDTH-1:0]       bid;
    logic [1:0]                     bresp;
    logic                           bvalid;
    logic                           wready;
} axi_write_input;

typedef struct packed {
    logic [`DDR_ADDR_WIDTH-1:0]     awaddr;
    logic [1:0]                     awburst;
    logic [`DDR_ID_WIDTH-1:0]       awid;
    logic [7:0]                     awlen;
    logic [2:0]                     awsize;
    logic                           awvalid;
    logic                           bready;
    logic                           wlast;
    logic                           wvalid;
} axi_write_output_nodata;

typedef struct packed {
    logic                           arready;
    logic                           rlast;
    logic [1:0]                     rresp;
    logic                           rvalid;
} axi_read_input_nodata;


localparam AXI_LITE_WORD_WIDTH	= 32;
localparam AXI_LITE_ARG_NUM	  = 16;

localparam FLOAT_ADD_LATENCY = 11;
localparam FLOAT_SUB_LATENCY = 11;
localparam FLOAT_MUL_LATENCY = 8;
localparam FLOAT_ACCUM_LATENCY = 22;

localparam BUFFER_READ_LATENCY=2;

// localparam VECTOR_LEN=256;
// localparam VECTOR_LEN_PER_SLICE=VECTOR_LEN/4;
localparam SLICE_WORDS=4096;
localparam MAX_VECTOR_LEN=2048;
localparam MAX_VECTOR_LEN_PER_SLICE=MAX_VECTOR_LEN; //1024
localparam MIN_VECTOR_LEN_PER_SLICE=SLICE_WORDS/MAX_VECTOR_LEN_PER_SLICE; //4
// localparam VECTORS_PER_GROUP=SLICE_WORDS/VECTOR_LEN_PER_SLICE;
localparam MAX_VECTORS_PER_GROUP=SLICE_WORDS/MIN_VECTOR_LEN_PER_SLICE; //1024

localparam SLICE_BUFFER_SIZE = SLICE_WORDS;      
localparam ORDER_BUFFER_SIZE = MAX_VECTOR_LEN_PER_SLICE;
localparam QUERY_BUFFER_SIZE = MAX_VECTOR_LEN;
localparam PSUM_BUFFER_SIZE = MAX_VECTORS_PER_GROUP;
localparam MAX_BUFFER_SIZE = SLICE_BUFFER_SIZE;

localparam WORK_FIFO_DEPTH = 128;

localparam COMMAND_WIDTH=8;
localparam FSIZE=32;
localparam ASIZE=32;
localparam PE_COMMAND_WIDTH=4;
localparam STATE_WIDTH=4;


typedef struct  packed {
  logic valid;
  logic [COMMAND_WIDTH-1:0] command;
  logic [FSIZE-1:0] data0;
  logic [FSIZE-1:0] data1;
} CommandDataPort;

typedef struct  packed {
  logic [FSIZE-1:0] state0;	//will be connected to the axi in state
  logic [FSIZE-1:0] state1;	//will be connected to the axi out state
  logic [FSIZE-1:0] state2;	//will be connected to the pein state
  logic [FSIZE-1:0] state3;	//will be connected to the peout state
  logic [FSIZE-1:0] state4;	//will be connected to the peout state
  logic [FSIZE-1:0] state5;	//will be connected to the peout state
  logic [FSIZE-1:0] state6;	//will be connected to the peout state
  logic [FSIZE-1:0] state7;	//will be connected to the peout state
  logic [FSIZE-1:0] state8;	//will be connected to the peout state
  logic [FSIZE-1:0] state9;	//will be connected to the peout state
  logic [FSIZE-1:0] state10;	//will be connected to the peout state
  logic [FSIZE-1:0] state11;	//will be connected to the peout state
  logic [FSIZE-1:0] state12;	//will be connected to the peout state
  logic [FSIZE-1:0] state13;	//will be connected to the peout state
  logic [FSIZE-1:0] state14;	//will be connected to the peout state
  logic [FSIZE-1:0] state15;	//will be connected to the peout state
} StatePort;

typedef struct packed {
  logic [FSIZE-1:0] stream_id;
  logic [FSIZE-1:0] vector_count;
  logic [ASIZE-1:0] addr_ordering_vector;
  logic [ASIZE-1:0] addr_data_slice;
  logic [ASIZE-1:0] addr_partial_sum_in;
  logic [ASIZE-1:0] addr_partial_sum_out;
  logic [ASIZE-1:0] shard_size;
  logic phase;
  logic first_slice;
  logic below_cutoff;
} WorkItem;

localparam FLOAT_ONE  = 32'h3F800000;

localparam COMMAND_PE_RESET = 1;
localparam COMMAND_DIST_CALC1 = 2;
localparam COMMAND_DIST_CALC2 = 3;
localparam COMMAND_DIST_CALC3 = 4;
localparam COMMAND_POP_COMPLETED = 5;
localparam COMMAND_AXI_LOAD_QUERY = 6;
localparam COMMAND_AXI_LOAD = 7;
localparam COMMAND_AXI_STORE = 8;
localparam COMMAND_COUNTER_START = 9;
localparam COMMAND_COUNTER_STOP = 10;
localparam COMMAND_SET_VECTOR_LEN = 11;
localparam COMMAND_SET_VECTORS_PER_GROUP = 12;
localparam COMMAND_SET_VECTOR_LEN_PER_SLICE = 13;
localparam COMMAND_SET_CUTOFF = 14;
localparam COMMAND_DIST_CALC2_1 = 15;
localparam COMMAND_DIST_CALC3_FIRST = 16;


localparam STATE_IDLE = 0;
localparam STATE_QUERY_LOAD = 1;
localparam STATE_COMPLETED = 2;

endpackage: RISA_PKG

