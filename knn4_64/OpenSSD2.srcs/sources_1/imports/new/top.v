`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/31 22:52:26
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    DDR_addr,
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
    pcie_perst_n,
    pcie_ref_clk_n,
    pcie_ref_clk_p,
    pcie_rx_n,
    pcie_rx_p,
    pcie_tx_n,
    pcie_tx_p);

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

    input pcie_perst_n;
    input pcie_ref_clk_n;
    input pcie_ref_clk_p;
    input [7:0]pcie_rx_n;
    input [7:0]pcie_rx_p;
    output [7:0]pcie_tx_n;
    output [7:0]pcie_tx_p;

    wire user_clk;
    wire user_rstn;

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

    OpenSSD2_wrapper OpenSSD2_wrapper_i
    (
        .DDR_addr(DDR_addr),
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
        .user_rstn(user_rstn)
    );
    axi_output AXI_HP0_output      ;    
    axi_input AXI_HP0_input        ;    

    assign S_AXI_HP0_awcache = '1;

    assign S_AXI_HP0_araddr    =  AXI_HP0_output.araddr   ;
    assign S_AXI_HP0_arburst   =  AXI_HP0_output.arburst  ;
    assign S_AXI_HP0_arcache   = '1;
    assign S_AXI_HP0_arid      =  AXI_HP0_output.arid     ;
    assign S_AXI_HP0_arlen     =  AXI_HP0_output.arlen    ;
    assign S_AXI_HP0_arlock    = '0;
    assign S_AXI_HP0_arprot    = '0;
    assign S_AXI_HP0_arqos     = '0;
    assign S_AXI_HP0_arsize    =  AXI_HP0_output.arsize   ;
    assign S_AXI_HP0_arvalid   =  AXI_HP0_output.arvalid  ;
    assign S_AXI_HP0_awaddr    =  AXI_HP0_output.awaddr   ;
    assign S_AXI_HP0_awburst   =  AXI_HP0_output.awburst  ;
    assign S_AXI_HP0_awid      =  AXI_HP0_output.awid     ;
    assign S_AXI_HP0_awlen     =  AXI_HP0_output.awlen    ;
    assign S_AXI_HP0_awlock    = '0;
    assign S_AXI_HP0_awprot    = '0;
    assign S_AXI_HP0_awqos     = '0;
    assign S_AXI_HP0_awlock    = '0;
    assign S_AXI_HP0_awsize    =  AXI_HP0_output.awsize   ;
    assign S_AXI_HP0_awvalid   =  AXI_HP0_output.awvalid  ;
    assign S_AXI_HP0_bready    =  AXI_HP0_output.bready   ;
    assign S_AXI_HP0_rready    =  AXI_HP0_output.rready   ;
    assign S_AXI_HP0_wdata     =  AXI_HP0_output.wdata    ;
    assign S_AXI_HP0_wlast     =  AXI_HP0_output.wlast    ;
    assign S_AXI_HP0_wstrb     =  AXI_HP0_output.wstrb    ;
    assign S_AXI_HP0_wvalid    =  AXI_HP0_output.wvalid   ;
    assign AXI_HP0_input.arready   = S_AXI_HP0_arready    ;
    assign AXI_HP0_input.awready   = S_AXI_HP0_awready    ;
    assign AXI_HP0_input.bid       = 0                    ;
    assign AXI_HP0_input.bresp     = S_AXI_HP0_bresp      ;
    assign AXI_HP0_input.bvalid    = S_AXI_HP0_bvalid     ;
    assign AXI_HP0_input.rdata     = S_AXI_HP0_rdata      ;
    assign AXI_HP0_input.rid       = 0                    ;
    assign AXI_HP0_input.rlast     = S_AXI_HP0_rlast      ;
    assign AXI_HP0_input.rresp     = S_AXI_HP0_rresp      ;
    assign AXI_HP0_input.rvalid    = S_AXI_HP0_rvalid     ;
    assign AXI_HP0_input.wready    = S_AXI_HP0_wready     ;
        
                
    axi_lite_output AXI_LITE0_output      ;    
    axi_lite_input AXI_LITE0_input        ;    

    assign M_AXI_GP0_arready = AXI_LITE0_input.arready;
    assign M_AXI_GP0_awready = AXI_LITE0_input.awready;
    assign M_AXI_GP0_bresp   = AXI_LITE0_input.bresp  ;
    assign M_AXI_GP0_bvalid  = AXI_LITE0_input.bvalid ;
    assign M_AXI_GP0_rdata   = AXI_LITE0_input.rdata  ;
    assign M_AXI_GP0_rresp   = AXI_LITE0_input.rresp  ;
    assign M_AXI_GP0_rvalid  = AXI_LITE0_input.rvalid ;
    assign M_AXI_GP0_wready  = AXI_LITE0_input.wready ;

    assign AXI_LITE0_output.araddr   = M_AXI_GP0_araddr ;
    assign AXI_LITE0_output.arvalid  = M_AXI_GP0_arvalid;
    assign AXI_LITE0_output.awaddr   = M_AXI_GP0_awaddr ;
    assign AXI_LITE0_output.awvalid  = M_AXI_GP0_awvalid;
    assign AXI_LITE0_output.bready   = M_AXI_GP0_bready ;
    assign AXI_LITE0_output.rready   = M_AXI_GP0_rready ;
    assign AXI_LITE0_output.wdata    = M_AXI_GP0_wdata  ;
    assign AXI_LITE0_output.wstrb    = M_AXI_GP0_wstrb  ;
    assign AXI_LITE0_output.wvalid   = M_AXI_GP0_wvalid ;

    axi_output AXI_HP1_output      ;    
    axi_input AXI_HP1_input        ;    

    assign S_AXI_HP1_awcache = '1;

    assign S_AXI_HP1_araddr    =  AXI_HP1_output.araddr   ;
    assign S_AXI_HP1_arburst   =  AXI_HP1_output.arburst  ;
    assign S_AXI_HP1_arcache   = '1;
    assign S_AXI_HP1_arid      =  AXI_HP1_output.arid     ;
    assign S_AXI_HP1_arlen     =  AXI_HP1_output.arlen    ;
    assign S_AXI_HP1_arlock    = '0;
    assign S_AXI_HP1_arprot    = '0;
    assign S_AXI_HP1_arqos     = '0;
    assign S_AXI_HP1_arsize    =  AXI_HP1_output.arsize   ;
    assign S_AXI_HP1_arvalid   =  AXI_HP1_output.arvalid  ;
    assign S_AXI_HP1_awaddr    =  AXI_HP1_output.awaddr   ;
    assign S_AXI_HP1_awburst   =  AXI_HP1_output.awburst  ;
    assign S_AXI_HP1_awid      =  AXI_HP1_output.awid     ;
    assign S_AXI_HP1_awlen     =  AXI_HP1_output.awlen    ;
    assign S_AXI_HP1_awlock    = '0;
    assign S_AXI_HP1_awprot    = '0;
    assign S_AXI_HP1_awqos     = '0;
    assign S_AXI_HP1_awlock    = '0;
    assign S_AXI_HP1_awsize    =  AXI_HP1_output.awsize   ;
    assign S_AXI_HP1_awvalid   =  AXI_HP1_output.awvalid  ;
    assign S_AXI_HP1_bready    =  AXI_HP1_output.bready   ;
    assign S_AXI_HP1_rready    =  AXI_HP1_output.rready   ;
    assign S_AXI_HP1_wdata     =  AXI_HP1_output.wdata    ;
    assign S_AXI_HP1_wlast     =  AXI_HP1_output.wlast    ;
    assign S_AXI_HP1_wstrb     =  AXI_HP1_output.wstrb    ;
    assign S_AXI_HP1_wvalid    =  AXI_HP1_output.wvalid   ;
    assign AXI_HP1_input.arready   = S_AXI_HP1_arready    ;
    assign AXI_HP1_input.awready   = S_AXI_HP1_awready    ;
    assign AXI_HP1_input.bid       = 0                    ;
    assign AXI_HP1_input.bresp     = S_AXI_HP1_bresp      ;
    assign AXI_HP1_input.bvalid    = S_AXI_HP1_bvalid     ;
    assign AXI_HP1_input.rdata     = S_AXI_HP1_rdata      ;
    assign AXI_HP1_input.rid       = 0                    ;
    assign AXI_HP1_input.rlast     = S_AXI_HP1_rlast      ;
    assign AXI_HP1_input.rresp     = S_AXI_HP1_rresp      ;
    assign AXI_HP1_input.rvalid    = S_AXI_HP1_rvalid     ;
    assign AXI_HP1_input.wready    = S_AXI_HP1_wready     ;

                
    axi_lite_output AXI_LITE1_output      ;    
    axi_lite_input AXI_LITE1_input        ;    

    assign M_AXI_GP1_arready = AXI_LITE1_input.arready;
    assign M_AXI_GP1_awready = AXI_LITE1_input.awready;
    assign M_AXI_GP1_bresp   = AXI_LITE1_input.bresp  ;
    assign M_AXI_GP1_bvalid  = AXI_LITE1_input.bvalid ;
    assign M_AXI_GP1_rdata   = AXI_LITE1_input.rdata  ;
    assign M_AXI_GP1_rresp   = AXI_LITE1_input.rresp  ;
    assign M_AXI_GP1_rvalid  = AXI_LITE1_input.rvalid ;
    assign M_AXI_GP1_wready  = AXI_LITE1_input.wready ;

    assign AXI_LITE1_output.araddr   = M_AXI_GP1_araddr ;
    assign AXI_LITE1_output.arvalid  = M_AXI_GP1_arvalid;
    assign AXI_LITE1_output.awaddr   = M_AXI_GP1_awaddr ;
    assign AXI_LITE1_output.awvalid  = M_AXI_GP1_awvalid;
    assign AXI_LITE1_output.bready   = M_AXI_GP1_bready ;
    assign AXI_LITE1_output.rready   = M_AXI_GP1_rready ;
    assign AXI_LITE1_output.wdata    = M_AXI_GP1_wdata  ;
    assign AXI_LITE1_output.wstrb    = M_AXI_GP1_wstrb  ;
    assign AXI_LITE1_output.wvalid   = M_AXI_GP1_wvalid ;


    pl_main pl_main1 (
        .AXI_HP0_output   (AXI_HP0_output        ),
        .AXI_HP0_input    (AXI_HP0_input         ),
                
        .AXI_LITE_output  (AXI_LITE0_output),
        .AXI_LITE_input   (AXI_LITE0_input),

        .clk(user_clk),
        .rstn(user_rstn)
    ) ;
    pl_main pl_main2 (
        .AXI_HP0_output   (AXI_HP1_output        ),
        .AXI_HP0_input    (AXI_HP1_input         ),
                
        .AXI_LITE_output  (AXI_LITE1_output),
        .AXI_LITE_input   (AXI_LITE1_input),

        .clk(user_clk),
        .rstn(user_rstn)
    ) ;
endmodule
