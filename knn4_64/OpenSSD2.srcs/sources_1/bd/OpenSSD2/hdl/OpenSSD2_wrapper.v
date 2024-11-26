//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (lin64) Build 1071353 Tue Nov 18 16:47:07 MST 2014
//Date        : Fri Nov 19 01:24:36 2021
//Host        : 9900K running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target OpenSSD2_wrapper.bd
//Design      : OpenSSD2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module OpenSSD2_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    IO_NAND_CH0_DQ,
    IO_NAND_CH0_DQS_N,
    IO_NAND_CH0_DQS_P,
    IO_NAND_CH1_DQ,
    IO_NAND_CH1_DQS_N,
    IO_NAND_CH1_DQS_P,
    IO_NAND_CH2_DQ,
    IO_NAND_CH2_DQS_N,
    IO_NAND_CH2_DQS_P,
    IO_NAND_CH3_DQ,
    IO_NAND_CH3_DQS_N,
    IO_NAND_CH3_DQS_P,
    IO_NAND_CH4_DQ,
    IO_NAND_CH4_DQS_N,
    IO_NAND_CH4_DQS_P,
    IO_NAND_CH5_DQ,
    IO_NAND_CH5_DQS_N,
    IO_NAND_CH5_DQS_P,
    IO_NAND_CH6_DQ,
    IO_NAND_CH6_DQS_N,
    IO_NAND_CH6_DQS_P,
    IO_NAND_CH7_DQ,
    IO_NAND_CH7_DQS_N,
    IO_NAND_CH7_DQS_P,
    I_NAND_CH0_RB,
    I_NAND_CH1_RB,
    I_NAND_CH2_RB,
    I_NAND_CH3_RB,
    I_NAND_CH4_RB,
    I_NAND_CH5_RB,
    I_NAND_CH6_RB,
    I_NAND_CH7_RB,
    M_AXI_GP0_araddr,
    M_AXI_GP0_arprot,
    M_AXI_GP0_arready,
    M_AXI_GP0_arvalid,
    M_AXI_GP0_awaddr,
    M_AXI_GP0_awprot,
    M_AXI_GP0_awready,
    M_AXI_GP0_awvalid,
    M_AXI_GP0_bready,
    M_AXI_GP0_bresp,
    M_AXI_GP0_bvalid,
    M_AXI_GP0_rdata,
    M_AXI_GP0_rready,
    M_AXI_GP0_rresp,
    M_AXI_GP0_rvalid,
    M_AXI_GP0_wdata,
    M_AXI_GP0_wready,
    M_AXI_GP0_wstrb,
    M_AXI_GP0_wvalid,
    M_AXI_GP1_araddr,
    M_AXI_GP1_arprot,
    M_AXI_GP1_arready,
    M_AXI_GP1_arvalid,
    M_AXI_GP1_awaddr,
    M_AXI_GP1_awprot,
    M_AXI_GP1_awready,
    M_AXI_GP1_awvalid,
    M_AXI_GP1_bready,
    M_AXI_GP1_bresp,
    M_AXI_GP1_bvalid,
    M_AXI_GP1_rdata,
    M_AXI_GP1_rready,
    M_AXI_GP1_rresp,
    M_AXI_GP1_rvalid,
    M_AXI_GP1_wdata,
    M_AXI_GP1_wready,
    M_AXI_GP1_wstrb,
    M_AXI_GP1_wvalid,
    O_DEBUG,
    O_NAND_CH0_ALE,
    O_NAND_CH0_CE,
    O_NAND_CH0_CLE,
    O_NAND_CH0_RE_N,
    O_NAND_CH0_RE_P,
    O_NAND_CH0_WE,
    O_NAND_CH0_WP,
    O_NAND_CH1_ALE,
    O_NAND_CH1_CE,
    O_NAND_CH1_CLE,
    O_NAND_CH1_RE_N,
    O_NAND_CH1_RE_P,
    O_NAND_CH1_WE,
    O_NAND_CH1_WP,
    O_NAND_CH2_ALE,
    O_NAND_CH2_CE,
    O_NAND_CH2_CLE,
    O_NAND_CH2_RE_N,
    O_NAND_CH2_RE_P,
    O_NAND_CH2_WE,
    O_NAND_CH2_WP,
    O_NAND_CH3_ALE,
    O_NAND_CH3_CE,
    O_NAND_CH3_CLE,
    O_NAND_CH3_RE_N,
    O_NAND_CH3_RE_P,
    O_NAND_CH3_WE,
    O_NAND_CH3_WP,
    O_NAND_CH4_ALE,
    O_NAND_CH4_CE,
    O_NAND_CH4_CLE,
    O_NAND_CH4_RE_N,
    O_NAND_CH4_RE_P,
    O_NAND_CH4_WE,
    O_NAND_CH4_WP,
    O_NAND_CH5_ALE,
    O_NAND_CH5_CE,
    O_NAND_CH5_CLE,
    O_NAND_CH5_RE_N,
    O_NAND_CH5_RE_P,
    O_NAND_CH5_WE,
    O_NAND_CH5_WP,
    O_NAND_CH6_ALE,
    O_NAND_CH6_CE,
    O_NAND_CH6_CLE,
    O_NAND_CH6_RE_N,
    O_NAND_CH6_RE_P,
    O_NAND_CH6_WE,
    O_NAND_CH6_WP,
    O_NAND_CH7_ALE,
    O_NAND_CH7_CE,
    O_NAND_CH7_CLE,
    O_NAND_CH7_RE_N,
    O_NAND_CH7_RE_P,
    O_NAND_CH7_WE,
    O_NAND_CH7_WP,
    S_AXI_HP0_araddr,
    S_AXI_HP0_arburst,
    S_AXI_HP0_arcache,
    S_AXI_HP0_arlen,
    S_AXI_HP0_arlock,
    S_AXI_HP0_arprot,
    S_AXI_HP0_arqos,
    S_AXI_HP0_arready,
    S_AXI_HP0_arregion,
    S_AXI_HP0_arsize,
    S_AXI_HP0_arvalid,
    S_AXI_HP0_awaddr,
    S_AXI_HP0_awburst,
    S_AXI_HP0_awcache,
    S_AXI_HP0_awlen,
    S_AXI_HP0_awlock,
    S_AXI_HP0_awprot,
    S_AXI_HP0_awqos,
    S_AXI_HP0_awready,
    S_AXI_HP0_awregion,
    S_AXI_HP0_awsize,
    S_AXI_HP0_awvalid,
    S_AXI_HP0_bready,
    S_AXI_HP0_bresp,
    S_AXI_HP0_bvalid,
    S_AXI_HP0_rdata,
    S_AXI_HP0_rlast,
    S_AXI_HP0_rready,
    S_AXI_HP0_rresp,
    S_AXI_HP0_rvalid,
    S_AXI_HP0_wdata,
    S_AXI_HP0_wlast,
    S_AXI_HP0_wready,
    S_AXI_HP0_wstrb,
    S_AXI_HP0_wvalid,
    S_AXI_HP1_araddr,
    S_AXI_HP1_arburst,
    S_AXI_HP1_arcache,
    S_AXI_HP1_arlen,
    S_AXI_HP1_arlock,
    S_AXI_HP1_arprot,
    S_AXI_HP1_arqos,
    S_AXI_HP1_arready,
    S_AXI_HP1_arregion,
    S_AXI_HP1_arsize,
    S_AXI_HP1_arvalid,
    S_AXI_HP1_awaddr,
    S_AXI_HP1_awburst,
    S_AXI_HP1_awcache,
    S_AXI_HP1_awlen,
    S_AXI_HP1_awlock,
    S_AXI_HP1_awprot,
    S_AXI_HP1_awqos,
    S_AXI_HP1_awready,
    S_AXI_HP1_awregion,
    S_AXI_HP1_awsize,
    S_AXI_HP1_awvalid,
    S_AXI_HP1_bready,
    S_AXI_HP1_bresp,
    S_AXI_HP1_bvalid,
    S_AXI_HP1_rdata,
    S_AXI_HP1_rlast,
    S_AXI_HP1_rready,
    S_AXI_HP1_rresp,
    S_AXI_HP1_rvalid,
    S_AXI_HP1_wdata,
    S_AXI_HP1_wlast,
    S_AXI_HP1_wready,
    S_AXI_HP1_wstrb,
    S_AXI_HP1_wvalid,
    pcie_perst_n,
    pcie_ref_clk_n,
    pcie_ref_clk_p,
    pcie_rx_n,
    pcie_rx_p,
    pcie_tx_n,
    pcie_tx_p,
    user_clk,
    user_rstn);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  inout [7:0]IO_NAND_CH0_DQ;
  inout IO_NAND_CH0_DQS_N;
  inout IO_NAND_CH0_DQS_P;
  inout [7:0]IO_NAND_CH1_DQ;
  inout IO_NAND_CH1_DQS_N;
  inout IO_NAND_CH1_DQS_P;
  inout [7:0]IO_NAND_CH2_DQ;
  inout IO_NAND_CH2_DQS_N;
  inout IO_NAND_CH2_DQS_P;
  inout [7:0]IO_NAND_CH3_DQ;
  inout IO_NAND_CH3_DQS_N;
  inout IO_NAND_CH3_DQS_P;
  inout [7:0]IO_NAND_CH4_DQ;
  inout IO_NAND_CH4_DQS_N;
  inout IO_NAND_CH4_DQS_P;
  inout [7:0]IO_NAND_CH5_DQ;
  inout IO_NAND_CH5_DQS_N;
  inout IO_NAND_CH5_DQS_P;
  inout [7:0]IO_NAND_CH6_DQ;
  inout IO_NAND_CH6_DQS_N;
  inout IO_NAND_CH6_DQS_P;
  inout [7:0]IO_NAND_CH7_DQ;
  inout IO_NAND_CH7_DQS_N;
  inout IO_NAND_CH7_DQS_P;
  input [7:0]I_NAND_CH0_RB;
  input [7:0]I_NAND_CH1_RB;
  input [7:0]I_NAND_CH2_RB;
  input [7:0]I_NAND_CH3_RB;
  input [7:0]I_NAND_CH4_RB;
  input [7:0]I_NAND_CH5_RB;
  input [7:0]I_NAND_CH6_RB;
  input [7:0]I_NAND_CH7_RB;
  output [31:0]M_AXI_GP0_araddr;
  output [2:0]M_AXI_GP0_arprot;
  input M_AXI_GP0_arready;
  output M_AXI_GP0_arvalid;
  output [31:0]M_AXI_GP0_awaddr;
  output [2:0]M_AXI_GP0_awprot;
  input M_AXI_GP0_awready;
  output M_AXI_GP0_awvalid;
  output M_AXI_GP0_bready;
  input [1:0]M_AXI_GP0_bresp;
  input M_AXI_GP0_bvalid;
  input [31:0]M_AXI_GP0_rdata;
  output M_AXI_GP0_rready;
  input [1:0]M_AXI_GP0_rresp;
  input M_AXI_GP0_rvalid;
  output [31:0]M_AXI_GP0_wdata;
  input M_AXI_GP0_wready;
  output [3:0]M_AXI_GP0_wstrb;
  output M_AXI_GP0_wvalid;
  output [31:0]M_AXI_GP1_araddr;
  output [2:0]M_AXI_GP1_arprot;
  input M_AXI_GP1_arready;
  output M_AXI_GP1_arvalid;
  output [31:0]M_AXI_GP1_awaddr;
  output [2:0]M_AXI_GP1_awprot;
  input M_AXI_GP1_awready;
  output M_AXI_GP1_awvalid;
  output M_AXI_GP1_bready;
  input [1:0]M_AXI_GP1_bresp;
  input M_AXI_GP1_bvalid;
  input [31:0]M_AXI_GP1_rdata;
  output M_AXI_GP1_rready;
  input [1:0]M_AXI_GP1_rresp;
  input M_AXI_GP1_rvalid;
  output [31:0]M_AXI_GP1_wdata;
  input M_AXI_GP1_wready;
  output [3:0]M_AXI_GP1_wstrb;
  output M_AXI_GP1_wvalid;
  output [31:0]O_DEBUG;
  output O_NAND_CH0_ALE;
  output [7:0]O_NAND_CH0_CE;
  output O_NAND_CH0_CLE;
  output O_NAND_CH0_RE_N;
  output O_NAND_CH0_RE_P;
  output O_NAND_CH0_WE;
  output O_NAND_CH0_WP;
  output O_NAND_CH1_ALE;
  output [7:0]O_NAND_CH1_CE;
  output O_NAND_CH1_CLE;
  output O_NAND_CH1_RE_N;
  output O_NAND_CH1_RE_P;
  output O_NAND_CH1_WE;
  output O_NAND_CH1_WP;
  output O_NAND_CH2_ALE;
  output [7:0]O_NAND_CH2_CE;
  output O_NAND_CH2_CLE;
  output O_NAND_CH2_RE_N;
  output O_NAND_CH2_RE_P;
  output O_NAND_CH2_WE;
  output O_NAND_CH2_WP;
  output O_NAND_CH3_ALE;
  output [7:0]O_NAND_CH3_CE;
  output O_NAND_CH3_CLE;
  output O_NAND_CH3_RE_N;
  output O_NAND_CH3_RE_P;
  output O_NAND_CH3_WE;
  output O_NAND_CH3_WP;
  output O_NAND_CH4_ALE;
  output [7:0]O_NAND_CH4_CE;
  output O_NAND_CH4_CLE;
  output O_NAND_CH4_RE_N;
  output O_NAND_CH4_RE_P;
  output O_NAND_CH4_WE;
  output O_NAND_CH4_WP;
  output O_NAND_CH5_ALE;
  output [7:0]O_NAND_CH5_CE;
  output O_NAND_CH5_CLE;
  output O_NAND_CH5_RE_N;
  output O_NAND_CH5_RE_P;
  output O_NAND_CH5_WE;
  output O_NAND_CH5_WP;
  output O_NAND_CH6_ALE;
  output [7:0]O_NAND_CH6_CE;
  output O_NAND_CH6_CLE;
  output O_NAND_CH6_RE_N;
  output O_NAND_CH6_RE_P;
  output O_NAND_CH6_WE;
  output O_NAND_CH6_WP;
  output O_NAND_CH7_ALE;
  output [7:0]O_NAND_CH7_CE;
  output O_NAND_CH7_CLE;
  output O_NAND_CH7_RE_N;
  output O_NAND_CH7_RE_P;
  output O_NAND_CH7_WE;
  output O_NAND_CH7_WP;
  input [31:0]S_AXI_HP0_araddr;
  input [1:0]S_AXI_HP0_arburst;
  input [3:0]S_AXI_HP0_arcache;
  input [7:0]S_AXI_HP0_arlen;
  input [0:0]S_AXI_HP0_arlock;
  input [2:0]S_AXI_HP0_arprot;
  input [3:0]S_AXI_HP0_arqos;
  output S_AXI_HP0_arready;
  input [3:0]S_AXI_HP0_arregion;
  input [2:0]S_AXI_HP0_arsize;
  input S_AXI_HP0_arvalid;
  input [31:0]S_AXI_HP0_awaddr;
  input [1:0]S_AXI_HP0_awburst;
  input [3:0]S_AXI_HP0_awcache;
  input [7:0]S_AXI_HP0_awlen;
  input [0:0]S_AXI_HP0_awlock;
  input [2:0]S_AXI_HP0_awprot;
  input [3:0]S_AXI_HP0_awqos;
  output S_AXI_HP0_awready;
  input [3:0]S_AXI_HP0_awregion;
  input [2:0]S_AXI_HP0_awsize;
  input S_AXI_HP0_awvalid;
  input S_AXI_HP0_bready;
  output [1:0]S_AXI_HP0_bresp;
  output S_AXI_HP0_bvalid;
  output [31:0]S_AXI_HP0_rdata;
  output S_AXI_HP0_rlast;
  input S_AXI_HP0_rready;
  output [1:0]S_AXI_HP0_rresp;
  output S_AXI_HP0_rvalid;
  input [31:0]S_AXI_HP0_wdata;
  input S_AXI_HP0_wlast;
  output S_AXI_HP0_wready;
  input [3:0]S_AXI_HP0_wstrb;
  input S_AXI_HP0_wvalid;
  input [31:0]S_AXI_HP1_araddr;
  input [1:0]S_AXI_HP1_arburst;
  input [3:0]S_AXI_HP1_arcache;
  input [7:0]S_AXI_HP1_arlen;
  input [0:0]S_AXI_HP1_arlock;
  input [2:0]S_AXI_HP1_arprot;
  input [3:0]S_AXI_HP1_arqos;
  output S_AXI_HP1_arready;
  input [3:0]S_AXI_HP1_arregion;
  input [2:0]S_AXI_HP1_arsize;
  input S_AXI_HP1_arvalid;
  input [31:0]S_AXI_HP1_awaddr;
  input [1:0]S_AXI_HP1_awburst;
  input [3:0]S_AXI_HP1_awcache;
  input [7:0]S_AXI_HP1_awlen;
  input [0:0]S_AXI_HP1_awlock;
  input [2:0]S_AXI_HP1_awprot;
  input [3:0]S_AXI_HP1_awqos;
  output S_AXI_HP1_awready;
  input [3:0]S_AXI_HP1_awregion;
  input [2:0]S_AXI_HP1_awsize;
  input S_AXI_HP1_awvalid;
  input S_AXI_HP1_bready;
  output [1:0]S_AXI_HP1_bresp;
  output S_AXI_HP1_bvalid;
  output [31:0]S_AXI_HP1_rdata;
  output S_AXI_HP1_rlast;
  input S_AXI_HP1_rready;
  output [1:0]S_AXI_HP1_rresp;
  output S_AXI_HP1_rvalid;
  input [31:0]S_AXI_HP1_wdata;
  input S_AXI_HP1_wlast;
  output S_AXI_HP1_wready;
  input [3:0]S_AXI_HP1_wstrb;
  input S_AXI_HP1_wvalid;
  input pcie_perst_n;
  input pcie_ref_clk_n;
  input pcie_ref_clk_p;
  input [7:0]pcie_rx_n;
  input [7:0]pcie_rx_p;
  output [7:0]pcie_tx_n;
  output [7:0]pcie_tx_p;
  output user_clk;
  output [0:0]user_rstn;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [7:0]IO_NAND_CH0_DQ;
  wire IO_NAND_CH0_DQS_N;
  wire IO_NAND_CH0_DQS_P;
  wire [7:0]IO_NAND_CH1_DQ;
  wire IO_NAND_CH1_DQS_N;
  wire IO_NAND_CH1_DQS_P;
  wire [7:0]IO_NAND_CH2_DQ;
  wire IO_NAND_CH2_DQS_N;
  wire IO_NAND_CH2_DQS_P;
  wire [7:0]IO_NAND_CH3_DQ;
  wire IO_NAND_CH3_DQS_N;
  wire IO_NAND_CH3_DQS_P;
  wire [7:0]IO_NAND_CH4_DQ;
  wire IO_NAND_CH4_DQS_N;
  wire IO_NAND_CH4_DQS_P;
  wire [7:0]IO_NAND_CH5_DQ;
  wire IO_NAND_CH5_DQS_N;
  wire IO_NAND_CH5_DQS_P;
  wire [7:0]IO_NAND_CH6_DQ;
  wire IO_NAND_CH6_DQS_N;
  wire IO_NAND_CH6_DQS_P;
  wire [7:0]IO_NAND_CH7_DQ;
  wire IO_NAND_CH7_DQS_N;
  wire IO_NAND_CH7_DQS_P;
  wire [7:0]I_NAND_CH0_RB;
  wire [7:0]I_NAND_CH1_RB;
  wire [7:0]I_NAND_CH2_RB;
  wire [7:0]I_NAND_CH3_RB;
  wire [7:0]I_NAND_CH4_RB;
  wire [7:0]I_NAND_CH5_RB;
  wire [7:0]I_NAND_CH6_RB;
  wire [7:0]I_NAND_CH7_RB;
  wire [31:0]M_AXI_GP0_araddr;
  wire [2:0]M_AXI_GP0_arprot;
  wire M_AXI_GP0_arready;
  wire M_AXI_GP0_arvalid;
  wire [31:0]M_AXI_GP0_awaddr;
  wire [2:0]M_AXI_GP0_awprot;
  wire M_AXI_GP0_awready;
  wire M_AXI_GP0_awvalid;
  wire M_AXI_GP0_bready;
  wire [1:0]M_AXI_GP0_bresp;
  wire M_AXI_GP0_bvalid;
  wire [31:0]M_AXI_GP0_rdata;
  wire M_AXI_GP0_rready;
  wire [1:0]M_AXI_GP0_rresp;
  wire M_AXI_GP0_rvalid;
  wire [31:0]M_AXI_GP0_wdata;
  wire M_AXI_GP0_wready;
  wire [3:0]M_AXI_GP0_wstrb;
  wire M_AXI_GP0_wvalid;
  wire [31:0]M_AXI_GP1_araddr;
  wire [2:0]M_AXI_GP1_arprot;
  wire M_AXI_GP1_arready;
  wire M_AXI_GP1_arvalid;
  wire [31:0]M_AXI_GP1_awaddr;
  wire [2:0]M_AXI_GP1_awprot;
  wire M_AXI_GP1_awready;
  wire M_AXI_GP1_awvalid;
  wire M_AXI_GP1_bready;
  wire [1:0]M_AXI_GP1_bresp;
  wire M_AXI_GP1_bvalid;
  wire [31:0]M_AXI_GP1_rdata;
  wire M_AXI_GP1_rready;
  wire [1:0]M_AXI_GP1_rresp;
  wire M_AXI_GP1_rvalid;
  wire [31:0]M_AXI_GP1_wdata;
  wire M_AXI_GP1_wready;
  wire [3:0]M_AXI_GP1_wstrb;
  wire M_AXI_GP1_wvalid;
  wire [31:0]O_DEBUG;
  wire O_NAND_CH0_ALE;
  wire [7:0]O_NAND_CH0_CE;
  wire O_NAND_CH0_CLE;
  wire O_NAND_CH0_RE_N;
  wire O_NAND_CH0_RE_P;
  wire O_NAND_CH0_WE;
  wire O_NAND_CH0_WP;
  wire O_NAND_CH1_ALE;
  wire [7:0]O_NAND_CH1_CE;
  wire O_NAND_CH1_CLE;
  wire O_NAND_CH1_RE_N;
  wire O_NAND_CH1_RE_P;
  wire O_NAND_CH1_WE;
  wire O_NAND_CH1_WP;
  wire O_NAND_CH2_ALE;
  wire [7:0]O_NAND_CH2_CE;
  wire O_NAND_CH2_CLE;
  wire O_NAND_CH2_RE_N;
  wire O_NAND_CH2_RE_P;
  wire O_NAND_CH2_WE;
  wire O_NAND_CH2_WP;
  wire O_NAND_CH3_ALE;
  wire [7:0]O_NAND_CH3_CE;
  wire O_NAND_CH3_CLE;
  wire O_NAND_CH3_RE_N;
  wire O_NAND_CH3_RE_P;
  wire O_NAND_CH3_WE;
  wire O_NAND_CH3_WP;
  wire O_NAND_CH4_ALE;
  wire [7:0]O_NAND_CH4_CE;
  wire O_NAND_CH4_CLE;
  wire O_NAND_CH4_RE_N;
  wire O_NAND_CH4_RE_P;
  wire O_NAND_CH4_WE;
  wire O_NAND_CH4_WP;
  wire O_NAND_CH5_ALE;
  wire [7:0]O_NAND_CH5_CE;
  wire O_NAND_CH5_CLE;
  wire O_NAND_CH5_RE_N;
  wire O_NAND_CH5_RE_P;
  wire O_NAND_CH5_WE;
  wire O_NAND_CH5_WP;
  wire O_NAND_CH6_ALE;
  wire [7:0]O_NAND_CH6_CE;
  wire O_NAND_CH6_CLE;
  wire O_NAND_CH6_RE_N;
  wire O_NAND_CH6_RE_P;
  wire O_NAND_CH6_WE;
  wire O_NAND_CH6_WP;
  wire O_NAND_CH7_ALE;
  wire [7:0]O_NAND_CH7_CE;
  wire O_NAND_CH7_CLE;
  wire O_NAND_CH7_RE_N;
  wire O_NAND_CH7_RE_P;
  wire O_NAND_CH7_WE;
  wire O_NAND_CH7_WP;
  wire [31:0]S_AXI_HP0_araddr;
  wire [1:0]S_AXI_HP0_arburst;
  wire [3:0]S_AXI_HP0_arcache;
  wire [7:0]S_AXI_HP0_arlen;
  wire [0:0]S_AXI_HP0_arlock;
  wire [2:0]S_AXI_HP0_arprot;
  wire [3:0]S_AXI_HP0_arqos;
  wire S_AXI_HP0_arready;
  wire [3:0]S_AXI_HP0_arregion;
  wire [2:0]S_AXI_HP0_arsize;
  wire S_AXI_HP0_arvalid;
  wire [31:0]S_AXI_HP0_awaddr;
  wire [1:0]S_AXI_HP0_awburst;
  wire [3:0]S_AXI_HP0_awcache;
  wire [7:0]S_AXI_HP0_awlen;
  wire [0:0]S_AXI_HP0_awlock;
  wire [2:0]S_AXI_HP0_awprot;
  wire [3:0]S_AXI_HP0_awqos;
  wire S_AXI_HP0_awready;
  wire [3:0]S_AXI_HP0_awregion;
  wire [2:0]S_AXI_HP0_awsize;
  wire S_AXI_HP0_awvalid;
  wire S_AXI_HP0_bready;
  wire [1:0]S_AXI_HP0_bresp;
  wire S_AXI_HP0_bvalid;
  wire [31:0]S_AXI_HP0_rdata;
  wire S_AXI_HP0_rlast;
  wire S_AXI_HP0_rready;
  wire [1:0]S_AXI_HP0_rresp;
  wire S_AXI_HP0_rvalid;
  wire [31:0]S_AXI_HP0_wdata;
  wire S_AXI_HP0_wlast;
  wire S_AXI_HP0_wready;
  wire [3:0]S_AXI_HP0_wstrb;
  wire S_AXI_HP0_wvalid;
  wire [31:0]S_AXI_HP1_araddr;
  wire [1:0]S_AXI_HP1_arburst;
  wire [3:0]S_AXI_HP1_arcache;
  wire [7:0]S_AXI_HP1_arlen;
  wire [0:0]S_AXI_HP1_arlock;
  wire [2:0]S_AXI_HP1_arprot;
  wire [3:0]S_AXI_HP1_arqos;
  wire S_AXI_HP1_arready;
  wire [3:0]S_AXI_HP1_arregion;
  wire [2:0]S_AXI_HP1_arsize;
  wire S_AXI_HP1_arvalid;
  wire [31:0]S_AXI_HP1_awaddr;
  wire [1:0]S_AXI_HP1_awburst;
  wire [3:0]S_AXI_HP1_awcache;
  wire [7:0]S_AXI_HP1_awlen;
  wire [0:0]S_AXI_HP1_awlock;
  wire [2:0]S_AXI_HP1_awprot;
  wire [3:0]S_AXI_HP1_awqos;
  wire S_AXI_HP1_awready;
  wire [3:0]S_AXI_HP1_awregion;
  wire [2:0]S_AXI_HP1_awsize;
  wire S_AXI_HP1_awvalid;
  wire S_AXI_HP1_bready;
  wire [1:0]S_AXI_HP1_bresp;
  wire S_AXI_HP1_bvalid;
  wire [31:0]S_AXI_HP1_rdata;
  wire S_AXI_HP1_rlast;
  wire S_AXI_HP1_rready;
  wire [1:0]S_AXI_HP1_rresp;
  wire S_AXI_HP1_rvalid;
  wire [31:0]S_AXI_HP1_wdata;
  wire S_AXI_HP1_wlast;
  wire S_AXI_HP1_wready;
  wire [3:0]S_AXI_HP1_wstrb;
  wire S_AXI_HP1_wvalid;
  wire pcie_perst_n;
  wire pcie_ref_clk_n;
  wire pcie_ref_clk_p;
  wire [7:0]pcie_rx_n;
  wire [7:0]pcie_rx_p;
  wire [7:0]pcie_tx_n;
  wire [7:0]pcie_tx_p;
  wire user_clk;
  wire [0:0]user_rstn;

OpenSSD2 OpenSSD2_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .IO_NAND_CH0_DQ(IO_NAND_CH0_DQ),
        .IO_NAND_CH0_DQS_N(IO_NAND_CH0_DQS_N),
        .IO_NAND_CH0_DQS_P(IO_NAND_CH0_DQS_P),
        .IO_NAND_CH1_DQ(IO_NAND_CH1_DQ),
        .IO_NAND_CH1_DQS_N(IO_NAND_CH1_DQS_N),
        .IO_NAND_CH1_DQS_P(IO_NAND_CH1_DQS_P),
        .IO_NAND_CH2_DQ(IO_NAND_CH2_DQ),
        .IO_NAND_CH2_DQS_N(IO_NAND_CH2_DQS_N),
        .IO_NAND_CH2_DQS_P(IO_NAND_CH2_DQS_P),
        .IO_NAND_CH3_DQ(IO_NAND_CH3_DQ),
        .IO_NAND_CH3_DQS_N(IO_NAND_CH3_DQS_N),
        .IO_NAND_CH3_DQS_P(IO_NAND_CH3_DQS_P),
        .IO_NAND_CH4_DQ(IO_NAND_CH4_DQ),
        .IO_NAND_CH4_DQS_N(IO_NAND_CH4_DQS_N),
        .IO_NAND_CH4_DQS_P(IO_NAND_CH4_DQS_P),
        .IO_NAND_CH5_DQ(IO_NAND_CH5_DQ),
        .IO_NAND_CH5_DQS_N(IO_NAND_CH5_DQS_N),
        .IO_NAND_CH5_DQS_P(IO_NAND_CH5_DQS_P),
        .IO_NAND_CH6_DQ(IO_NAND_CH6_DQ),
        .IO_NAND_CH6_DQS_N(IO_NAND_CH6_DQS_N),
        .IO_NAND_CH6_DQS_P(IO_NAND_CH6_DQS_P),
        .IO_NAND_CH7_DQ(IO_NAND_CH7_DQ),
        .IO_NAND_CH7_DQS_N(IO_NAND_CH7_DQS_N),
        .IO_NAND_CH7_DQS_P(IO_NAND_CH7_DQS_P),
        .I_NAND_CH0_RB(I_NAND_CH0_RB),
        .I_NAND_CH1_RB(I_NAND_CH1_RB),
        .I_NAND_CH2_RB(I_NAND_CH2_RB),
        .I_NAND_CH3_RB(I_NAND_CH3_RB),
        .I_NAND_CH4_RB(I_NAND_CH4_RB),
        .I_NAND_CH5_RB(I_NAND_CH5_RB),
        .I_NAND_CH6_RB(I_NAND_CH6_RB),
        .I_NAND_CH7_RB(I_NAND_CH7_RB),
        .M_AXI_GP0_araddr(M_AXI_GP0_araddr),
        .M_AXI_GP0_arprot(M_AXI_GP0_arprot),
        .M_AXI_GP0_arready(M_AXI_GP0_arready),
        .M_AXI_GP0_arvalid(M_AXI_GP0_arvalid),
        .M_AXI_GP0_awaddr(M_AXI_GP0_awaddr),
        .M_AXI_GP0_awprot(M_AXI_GP0_awprot),
        .M_AXI_GP0_awready(M_AXI_GP0_awready),
        .M_AXI_GP0_awvalid(M_AXI_GP0_awvalid),
        .M_AXI_GP0_bready(M_AXI_GP0_bready),
        .M_AXI_GP0_bresp(M_AXI_GP0_bresp),
        .M_AXI_GP0_bvalid(M_AXI_GP0_bvalid),
        .M_AXI_GP0_rdata(M_AXI_GP0_rdata),
        .M_AXI_GP0_rready(M_AXI_GP0_rready),
        .M_AXI_GP0_rresp(M_AXI_GP0_rresp),
        .M_AXI_GP0_rvalid(M_AXI_GP0_rvalid),
        .M_AXI_GP0_wdata(M_AXI_GP0_wdata),
        .M_AXI_GP0_wready(M_AXI_GP0_wready),
        .M_AXI_GP0_wstrb(M_AXI_GP0_wstrb),
        .M_AXI_GP0_wvalid(M_AXI_GP0_wvalid),
        .M_AXI_GP1_araddr(M_AXI_GP1_araddr),
        .M_AXI_GP1_arprot(M_AXI_GP1_arprot),
        .M_AXI_GP1_arready(M_AXI_GP1_arready),
        .M_AXI_GP1_arvalid(M_AXI_GP1_arvalid),
        .M_AXI_GP1_awaddr(M_AXI_GP1_awaddr),
        .M_AXI_GP1_awprot(M_AXI_GP1_awprot),
        .M_AXI_GP1_awready(M_AXI_GP1_awready),
        .M_AXI_GP1_awvalid(M_AXI_GP1_awvalid),
        .M_AXI_GP1_bready(M_AXI_GP1_bready),
        .M_AXI_GP1_bresp(M_AXI_GP1_bresp),
        .M_AXI_GP1_bvalid(M_AXI_GP1_bvalid),
        .M_AXI_GP1_rdata(M_AXI_GP1_rdata),
        .M_AXI_GP1_rready(M_AXI_GP1_rready),
        .M_AXI_GP1_rresp(M_AXI_GP1_rresp),
        .M_AXI_GP1_rvalid(M_AXI_GP1_rvalid),
        .M_AXI_GP1_wdata(M_AXI_GP1_wdata),
        .M_AXI_GP1_wready(M_AXI_GP1_wready),
        .M_AXI_GP1_wstrb(M_AXI_GP1_wstrb),
        .M_AXI_GP1_wvalid(M_AXI_GP1_wvalid),
        .O_DEBUG(O_DEBUG),
        .O_NAND_CH0_ALE(O_NAND_CH0_ALE),
        .O_NAND_CH0_CE(O_NAND_CH0_CE),
        .O_NAND_CH0_CLE(O_NAND_CH0_CLE),
        .O_NAND_CH0_RE_N(O_NAND_CH0_RE_N),
        .O_NAND_CH0_RE_P(O_NAND_CH0_RE_P),
        .O_NAND_CH0_WE(O_NAND_CH0_WE),
        .O_NAND_CH0_WP(O_NAND_CH0_WP),
        .O_NAND_CH1_ALE(O_NAND_CH1_ALE),
        .O_NAND_CH1_CE(O_NAND_CH1_CE),
        .O_NAND_CH1_CLE(O_NAND_CH1_CLE),
        .O_NAND_CH1_RE_N(O_NAND_CH1_RE_N),
        .O_NAND_CH1_RE_P(O_NAND_CH1_RE_P),
        .O_NAND_CH1_WE(O_NAND_CH1_WE),
        .O_NAND_CH1_WP(O_NAND_CH1_WP),
        .O_NAND_CH2_ALE(O_NAND_CH2_ALE),
        .O_NAND_CH2_CE(O_NAND_CH2_CE),
        .O_NAND_CH2_CLE(O_NAND_CH2_CLE),
        .O_NAND_CH2_RE_N(O_NAND_CH2_RE_N),
        .O_NAND_CH2_RE_P(O_NAND_CH2_RE_P),
        .O_NAND_CH2_WE(O_NAND_CH2_WE),
        .O_NAND_CH2_WP(O_NAND_CH2_WP),
        .O_NAND_CH3_ALE(O_NAND_CH3_ALE),
        .O_NAND_CH3_CE(O_NAND_CH3_CE),
        .O_NAND_CH3_CLE(O_NAND_CH3_CLE),
        .O_NAND_CH3_RE_N(O_NAND_CH3_RE_N),
        .O_NAND_CH3_RE_P(O_NAND_CH3_RE_P),
        .O_NAND_CH3_WE(O_NAND_CH3_WE),
        .O_NAND_CH3_WP(O_NAND_CH3_WP),
        .O_NAND_CH4_ALE(O_NAND_CH4_ALE),
        .O_NAND_CH4_CE(O_NAND_CH4_CE),
        .O_NAND_CH4_CLE(O_NAND_CH4_CLE),
        .O_NAND_CH4_RE_N(O_NAND_CH4_RE_N),
        .O_NAND_CH4_RE_P(O_NAND_CH4_RE_P),
        .O_NAND_CH4_WE(O_NAND_CH4_WE),
        .O_NAND_CH4_WP(O_NAND_CH4_WP),
        .O_NAND_CH5_ALE(O_NAND_CH5_ALE),
        .O_NAND_CH5_CE(O_NAND_CH5_CE),
        .O_NAND_CH5_CLE(O_NAND_CH5_CLE),
        .O_NAND_CH5_RE_N(O_NAND_CH5_RE_N),
        .O_NAND_CH5_RE_P(O_NAND_CH5_RE_P),
        .O_NAND_CH5_WE(O_NAND_CH5_WE),
        .O_NAND_CH5_WP(O_NAND_CH5_WP),
        .O_NAND_CH6_ALE(O_NAND_CH6_ALE),
        .O_NAND_CH6_CE(O_NAND_CH6_CE),
        .O_NAND_CH6_CLE(O_NAND_CH6_CLE),
        .O_NAND_CH6_RE_N(O_NAND_CH6_RE_N),
        .O_NAND_CH6_RE_P(O_NAND_CH6_RE_P),
        .O_NAND_CH6_WE(O_NAND_CH6_WE),
        .O_NAND_CH6_WP(O_NAND_CH6_WP),
        .O_NAND_CH7_ALE(O_NAND_CH7_ALE),
        .O_NAND_CH7_CE(O_NAND_CH7_CE),
        .O_NAND_CH7_CLE(O_NAND_CH7_CLE),
        .O_NAND_CH7_RE_N(O_NAND_CH7_RE_N),
        .O_NAND_CH7_RE_P(O_NAND_CH7_RE_P),
        .O_NAND_CH7_WE(O_NAND_CH7_WE),
        .O_NAND_CH7_WP(O_NAND_CH7_WP),
        .S_AXI_HP0_araddr(S_AXI_HP0_araddr),
        .S_AXI_HP0_arburst(S_AXI_HP0_arburst),
        .S_AXI_HP0_arcache(S_AXI_HP0_arcache),
        .S_AXI_HP0_arlen(S_AXI_HP0_arlen),
        .S_AXI_HP0_arlock(S_AXI_HP0_arlock),
        .S_AXI_HP0_arprot(S_AXI_HP0_arprot),
        .S_AXI_HP0_arqos(S_AXI_HP0_arqos),
        .S_AXI_HP0_arready(S_AXI_HP0_arready),
        .S_AXI_HP0_arregion(S_AXI_HP0_arregion),
        .S_AXI_HP0_arsize(S_AXI_HP0_arsize),
        .S_AXI_HP0_arvalid(S_AXI_HP0_arvalid),
        .S_AXI_HP0_awaddr(S_AXI_HP0_awaddr),
        .S_AXI_HP0_awburst(S_AXI_HP0_awburst),
        .S_AXI_HP0_awcache(S_AXI_HP0_awcache),
        .S_AXI_HP0_awlen(S_AXI_HP0_awlen),
        .S_AXI_HP0_awlock(S_AXI_HP0_awlock),
        .S_AXI_HP0_awprot(S_AXI_HP0_awprot),
        .S_AXI_HP0_awqos(S_AXI_HP0_awqos),
        .S_AXI_HP0_awready(S_AXI_HP0_awready),
        .S_AXI_HP0_awregion(S_AXI_HP0_awregion),
        .S_AXI_HP0_awsize(S_AXI_HP0_awsize),
        .S_AXI_HP0_awvalid(S_AXI_HP0_awvalid),
        .S_AXI_HP0_bready(S_AXI_HP0_bready),
        .S_AXI_HP0_bresp(S_AXI_HP0_bresp),
        .S_AXI_HP0_bvalid(S_AXI_HP0_bvalid),
        .S_AXI_HP0_rdata(S_AXI_HP0_rdata),
        .S_AXI_HP0_rlast(S_AXI_HP0_rlast),
        .S_AXI_HP0_rready(S_AXI_HP0_rready),
        .S_AXI_HP0_rresp(S_AXI_HP0_rresp),
        .S_AXI_HP0_rvalid(S_AXI_HP0_rvalid),
        .S_AXI_HP0_wdata(S_AXI_HP0_wdata),
        .S_AXI_HP0_wlast(S_AXI_HP0_wlast),
        .S_AXI_HP0_wready(S_AXI_HP0_wready),
        .S_AXI_HP0_wstrb(S_AXI_HP0_wstrb),
        .S_AXI_HP0_wvalid(S_AXI_HP0_wvalid),
        .S_AXI_HP1_araddr(S_AXI_HP1_araddr),
        .S_AXI_HP1_arburst(S_AXI_HP1_arburst),
        .S_AXI_HP1_arcache(S_AXI_HP1_arcache),
        .S_AXI_HP1_arlen(S_AXI_HP1_arlen),
        .S_AXI_HP1_arlock(S_AXI_HP1_arlock),
        .S_AXI_HP1_arprot(S_AXI_HP1_arprot),
        .S_AXI_HP1_arqos(S_AXI_HP1_arqos),
        .S_AXI_HP1_arready(S_AXI_HP1_arready),
        .S_AXI_HP1_arregion(S_AXI_HP1_arregion),
        .S_AXI_HP1_arsize(S_AXI_HP1_arsize),
        .S_AXI_HP1_arvalid(S_AXI_HP1_arvalid),
        .S_AXI_HP1_awaddr(S_AXI_HP1_awaddr),
        .S_AXI_HP1_awburst(S_AXI_HP1_awburst),
        .S_AXI_HP1_awcache(S_AXI_HP1_awcache),
        .S_AXI_HP1_awlen(S_AXI_HP1_awlen),
        .S_AXI_HP1_awlock(S_AXI_HP1_awlock),
        .S_AXI_HP1_awprot(S_AXI_HP1_awprot),
        .S_AXI_HP1_awqos(S_AXI_HP1_awqos),
        .S_AXI_HP1_awready(S_AXI_HP1_awready),
        .S_AXI_HP1_awregion(S_AXI_HP1_awregion),
        .S_AXI_HP1_awsize(S_AXI_HP1_awsize),
        .S_AXI_HP1_awvalid(S_AXI_HP1_awvalid),
        .S_AXI_HP1_bready(S_AXI_HP1_bready),
        .S_AXI_HP1_bresp(S_AXI_HP1_bresp),
        .S_AXI_HP1_bvalid(S_AXI_HP1_bvalid),
        .S_AXI_HP1_rdata(S_AXI_HP1_rdata),
        .S_AXI_HP1_rlast(S_AXI_HP1_rlast),
        .S_AXI_HP1_rready(S_AXI_HP1_rready),
        .S_AXI_HP1_rresp(S_AXI_HP1_rresp),
        .S_AXI_HP1_rvalid(S_AXI_HP1_rvalid),
        .S_AXI_HP1_wdata(S_AXI_HP1_wdata),
        .S_AXI_HP1_wlast(S_AXI_HP1_wlast),
        .S_AXI_HP1_wready(S_AXI_HP1_wready),
        .S_AXI_HP1_wstrb(S_AXI_HP1_wstrb),
        .S_AXI_HP1_wvalid(S_AXI_HP1_wvalid),
        .pcie_perst_n(pcie_perst_n),
        .pcie_ref_clk_n(pcie_ref_clk_n),
        .pcie_ref_clk_p(pcie_ref_clk_p),
        .pcie_rx_n(pcie_rx_n),
        .pcie_rx_p(pcie_rx_p),
        .pcie_tx_n(pcie_tx_n),
        .pcie_tx_p(pcie_tx_p),
        .user_clk(user_clk),
        .user_rstn(user_rstn));
endmodule
