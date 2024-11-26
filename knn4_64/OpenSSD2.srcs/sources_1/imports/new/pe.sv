`timescale 1 ns / 1 ns

`include "defines.vh"


import RISA_PKG::*;

module PE #(
		parameter ID        = 0
	) (
	
	  input logic	clk,	    
	  input logic	rstn,
    input logic input_valid,
    input logic input_last,
    input logic [FSIZE-1:0] A_data,
    input logic [FSIZE-1:0] B_data,
    output logic output_valid,
    output logic [FSIZE-1:0] out_data
  );
  
  typedef struct packed {
    logic[4:0] rstn_counter;
  } Registers;
  
  Registers reg_current,reg_next;

  logic fsub_in_valid;
  logic fsub_in_tlast;
  logic fsub_res_valid;
  logic [31:0] fsub_in_A;
  logic [31:0] fsub_in_B;
  logic [31:0] fsub_res;
  logic fsub_res_tlast;

  float_sub float_sub (
    .aclk(clk),	    
    .s_axis_a_tvalid(fsub_in_valid),
    .s_axis_a_tdata(fsub_in_A),
    .s_axis_a_tlast(fsub_in_tlast),
    .s_axis_b_tvalid(fsub_in_valid),
    .s_axis_b_tdata(fsub_in_B),
    .m_axis_result_tlast(fsub_res_tlast),
    .m_axis_result_tvalid(fsub_res_valid),
    .m_axis_result_tdata(fsub_res)
  );
  
  logic fmul_in_valid;
  logic fmul_in_tlast;
  logic fmul_res_valid;
  logic [31:0] fmul_in_A;
  logic [31:0] fmul_in_B;
  logic [31:0] fmul_res;
  logic fmul_res_tlast;

  float_mul float_mul (
    .aclk(clk),	    
    .s_axis_a_tvalid(fmul_in_valid),
    .s_axis_a_tdata(fmul_in_A),
    .s_axis_a_tlast(fmul_in_tlast),
    .s_axis_b_tvalid(fmul_in_valid),
    .s_axis_b_tdata(fmul_in_B),
    .m_axis_result_tlast(fmul_res_tlast),
    .m_axis_result_tvalid(fmul_res_valid),
    .m_axis_result_tdata(fmul_res)
  );

  logic faccum_rstn;
  logic faccum_in_valid;
  logic faccum_res_valid;
  logic faccum_in_tlast;
  logic faccum_res_tlast;
  logic [31:0] faccum_in_A;
  logic [31:0] faccum_res;

  float_accum float_accum (
    .aclk(clk),	    
    .aresetn(faccum_rstn),
    .s_axis_a_tvalid(faccum_in_valid),
    .s_axis_a_tlast(faccum_in_tlast),
    .s_axis_a_tdata (faccum_in_A),
    .m_axis_result_tvalid(faccum_res_valid),
    .m_axis_result_tlast(faccum_res_tlast),
    .m_axis_result_tdata(faccum_res)
  );

  always_comb begin

    reg_next = reg_current;

    fsub_in_valid = input_valid;
    fsub_in_tlast = input_last;
    fsub_in_A = A_data;
    fsub_in_B = B_data;
    
    fmul_in_valid = fsub_res_valid;
    fmul_in_tlast = fsub_res_tlast;
    fmul_in_A = fsub_res;
    fmul_in_B = fsub_res;

    faccum_in_valid = fmul_res_valid;
    faccum_in_tlast = fmul_res_tlast;
    faccum_in_A = fmul_res;

    output_valid = faccum_res_valid && faccum_res_tlast;
    out_data = faccum_res;

    //reset logic for the accumulator: need to assert LOW for more than 2 cycles -> assert for 3 cycles. 
    if(rstn==0) begin
      reg_next.rstn_counter = 10;      
    end

    faccum_rstn = 1;
    if(reg_current.rstn_counter != 0) begin
      faccum_rstn = 0;
      reg_next.rstn_counter = reg_current.rstn_counter - 1;
    end
  end
        
    
  always @ (posedge clk) begin
    reg_current <= reg_next;
	end

endmodule

`ifdef verilator
////++++ Fake Floating Point IPs for verilator - need DPI functions in C code
module float_add (
		input  logic			aclk,	
    
    input logic         s_axis_a_tvalid,
    input logic         s_axis_a_tlast,
    input logic[31:0]   s_axis_a_tdata,
    input logic         s_axis_b_tvalid,
    input logic[31:0]   s_axis_b_tdata,
    output logic         m_axis_result_tvalid,
    output logic         m_axis_result_tlast,
    output logic[31:0]   m_axis_result_tdata
	);

  import "DPI-C" function bit[31:0] fadd (input bit[31:0] a, input bit[31:0] b);

  logic [FLOAT_ADD_LATENCY-1:0][31:0] result;
  logic [FLOAT_ADD_LATENCY-1:0] valid;
  logic [FLOAT_ADD_LATENCY-1:0] tlast;

  always@(posedge aclk) begin
    result[0] <= fadd(s_axis_a_tdata,s_axis_b_tdata);    
    valid[0] <= s_axis_a_tvalid;    
    tlast[0] <= s_axis_a_tlast;    
    for(int i = 0; i < FLOAT_ADD_LATENCY-1; i ++) begin
      result[i+1] <= result[i];
      valid[i+1] <=  valid[i];
      tlast[i+1] <=  tlast[i];
    end
  end

  assign m_axis_result_tdata = result[FLOAT_ADD_LATENCY-1];
  assign m_axis_result_tvalid = valid[FLOAT_ADD_LATENCY-1];
  assign m_axis_result_tlast = tlast[FLOAT_ADD_LATENCY-1];
endmodule


module float_sub (
		input  logic			aclk,	
    
    input logic         s_axis_a_tvalid,
    input logic         s_axis_a_tlast,
    input logic[31:0]   s_axis_a_tdata,
    input logic         s_axis_b_tvalid,
    input logic[31:0]   s_axis_b_tdata,
    output logic         m_axis_result_tvalid,
    output logic         m_axis_result_tlast,
    output logic[31:0]   m_axis_result_tdata
	);

  import "DPI-C" function bit[31:0] fsub (input bit[31:0] a, input bit[31:0] b);

  logic [FLOAT_SUB_LATENCY-1:0][31:0] result;
  logic [FLOAT_SUB_LATENCY-1:0] valid;
  logic [FLOAT_SUB_LATENCY-1:0] tlast;

  always@(posedge aclk) begin
    result[0] <= fsub(s_axis_a_tdata,s_axis_b_tdata);    
    valid[0] <= s_axis_a_tvalid;    
    tlast[0] <= s_axis_a_tlast;    
    for(int i = 0; i < FLOAT_SUB_LATENCY-1; i ++) begin
      result[i+1] <= result[i];
      valid[i+1] <=  valid[i];
      tlast[i+1] <=  tlast[i];
    end
  end

  assign m_axis_result_tdata = result[FLOAT_SUB_LATENCY-1];
  assign m_axis_result_tvalid = valid[FLOAT_SUB_LATENCY-1];
  assign m_axis_result_tlast = tlast[FLOAT_SUB_LATENCY-1];
endmodule


module float_mul (
		input  logic			aclk,	
    
    input logic         s_axis_a_tvalid,
    input logic         s_axis_a_tlast,
    input logic[31:0]   s_axis_a_tdata,
    input logic         s_axis_b_tvalid,
    input logic[31:0]   s_axis_b_tdata,
    output logic         m_axis_result_tvalid,
    output logic         m_axis_result_tlast,
    output logic[31:0]   m_axis_result_tdata
	);

  import "DPI-C" function bit[31:0] fmul (input bit[31:0] a, input bit[31:0] b);

  logic [FLOAT_MUL_LATENCY-1:0][31:0] result;
  logic [FLOAT_MUL_LATENCY-1:0] valid;
  logic [FLOAT_MUL_LATENCY-1:0] tlast;

  always@(posedge aclk) begin
    result[0] <= fmul(s_axis_a_tdata,s_axis_b_tdata);    
    valid[0] <= s_axis_a_tvalid;    
    tlast[0] <= s_axis_a_tlast;    
    for(int i = 0; i < FLOAT_MUL_LATENCY-1; i ++) begin
      result[i+1] <= result[i];
      valid[i+1] <=  valid[i];
      tlast[i+1] <=  tlast[i];
    end
  end

  assign m_axis_result_tdata = result[FLOAT_MUL_LATENCY-1];
  assign m_axis_result_tvalid = valid[FLOAT_MUL_LATENCY-1];
  assign m_axis_result_tlast = tlast[FLOAT_MUL_LATENCY-1];
endmodule

module float_accum #(
		parameter ID_V        = 0,
		parameter ID_H        = 0
	) (
		input logic			    aclk,	
    input logic         aresetn,

    input logic         s_axis_a_tvalid,
    input logic         s_axis_a_tlast,
    input logic[31:0]   s_axis_a_tdata,

    output logic         m_axis_result_tvalid,
    output logic         m_axis_result_tlast,
    output logic[31:0]   m_axis_result_tdata
	);

  import "DPI-C" function bit[31:0] fadd (input bit[31:0] a, input bit[31:0] b);

  logic [FLOAT_ACCUM_LATENCY-1:0][31:0] result;
  logic [FLOAT_ACCUM_LATENCY-1:0] valid;
  logic [FLOAT_ACCUM_LATENCY-1:0] tlast;

  always@(posedge aclk) begin
    if(s_axis_a_tvalid) begin
      if(tlast[0]) begin
        result[0] <= s_axis_a_tdata;
      end
      else begin
        result[0] <= fadd(s_axis_a_tdata,result[0]);
      end
    end
    else begin
      if(valid[0] && tlast[0]) begin
        result[0] <= 0;
      end
    end

    valid[0] <= s_axis_a_tvalid;    
    tlast[0] <= s_axis_a_tlast;

    for(int i = 0; i < FLOAT_ACCUM_LATENCY-1; i ++) begin
      result[i+1] <= result[i];
      valid[i+1] <=  valid[i];
      tlast[i+1] <=  tlast[i];
    end

    if(aresetn==0) begin
      for(int i = 0; i < FLOAT_ACCUM_LATENCY; i ++) begin
        result[i] <= 0;
        valid[i] <= 0;
        tlast[i] <= 0;
      end
    end
  end

  assign m_axis_result_tdata = result[FLOAT_ACCUM_LATENCY-1];
  assign m_axis_result_tvalid = valid[FLOAT_ACCUM_LATENCY-1];
  assign m_axis_result_tlast = tlast[FLOAT_ACCUM_LATENCY-1];
endmodule
`endif
////---- Fake Floating Point IPs