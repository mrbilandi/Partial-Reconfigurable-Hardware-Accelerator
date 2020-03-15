-------------------------------------------------------------------------------
--
-- (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-------------------------------------------------------------------------------
-- Project    : Series-7 Integrated Block for PCI Express
-- File       : pcie_app_7x.vhd
-- Version    : 1.11
--
-- Description:  PCI Express Endpoint Core sample application design.
--
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
library work;
use work.pack_pcie.all;

entity pcie_app_7x is
generic (
  C_DATA_WIDTH : integer range 64 to 128 := 64;
  TCQ          : time                    := 1 ps
);
port  (
  user_clk                       : in  std_logic;
  user_reset                     : in  std_logic;
  user_lnk_up                    : in  std_logic;

  -- Tx
  tx_buf_av                      : in  std_logic_vector(5 downto 0);
  tx_cfg_req                     : in  std_logic;
  tx_err_drop                    : in  std_logic;
  tx_cfg_gnt_out                     : out std_logic;

  s_axis_tx_tready               : in  std_logic;
  s_axis_tx_tdata_out                : out std_logic_vector((C_DATA_WIDTH - 1) downto 0);
  s_axis_tx_tkeep_out                : out std_logic_vector((C_DATA_WIDTH/8)-1 downto 0);
  s_axis_tx_tuser_out                : out std_logic_vector(3 downto 0);
  s_axis_tx_tlast_out                : out std_logic;
  s_axis_tx_tvalid_out               : out std_logic;

  -- RX
  rx_np_ok_out                       : out std_logic;
  rx_np_req_out                      : out std_logic;
  m_axis_rx_tdata                : in std_logic_vector((C_DATA_WIDTH - 1) downto 0);
  m_axis_rx_tkeep                : in std_logic_vector((C_DATA_WIDTH/8)-1 downto 0);
  m_axis_rx_tlast                : in  std_logic;
  m_axis_rx_tvalid               : in  std_logic;
  m_axis_rx_tready_out               : out std_logic;
  m_axis_rx_tuser                : in std_logic_vector(21 downto 0);

  -- Flow Control
  fc_cpld                        : in  std_logic_vector(11 downto 0);
  fc_cplh                        : in  std_logic_vector(7 downto 0);
  fc_npd                         : in  std_logic_vector(11 downto 0);
  fc_nph                         : in  std_logic_vector(7 downto 0);
  fc_pd                          : in  std_logic_vector(11 downto 0);
  fc_ph                          : in  std_logic_vector(7 downto 0);
  fc_sel                         : out std_logic_vector(2 downto 0);

 -- CFG

  cfg_err_cor                    : out std_logic;
  cfg_err_ur                     : out std_logic;
  cfg_err_ecrc                   : out std_logic;
  cfg_err_cpl_timeout            : out std_logic;
  cfg_err_cpl_unexpect           : out std_logic;
  cfg_err_cpl_abort              : out std_logic;
  cfg_err_atomic_egress_blocked  : out std_logic;
  cfg_err_internal_cor           : out std_logic;
  cfg_err_malformed              : out std_logic;
  cfg_err_mc_blocked             : out std_logic;
  cfg_err_poisoned               : out std_logic;
  cfg_err_norecovery             : out std_logic;
  cfg_err_acs                    : out std_logic;
  cfg_err_internal_uncor         : out std_logic;
  cfg_pm_halt_aspm_l0s           : out std_logic;
  cfg_pm_halt_aspm_l1            : out std_logic;
  cfg_pm_force_state_en          : out std_logic;
  cfg_pm_force_state             : out std_logic_vector( 1 downto 0);
  cfg_err_posted                 : out std_logic;
  cfg_err_locked                 : out std_logic;
  cfg_err_tlp_cpl_header         : out std_logic_vector(47 downto 0);
  cfg_err_cpl_rdy                : in  std_logic;
  cfg_interrupt                  : out std_logic;
  cfg_interrupt_rdy              : in  std_logic;
  cfg_interrupt_assert           : out std_logic;
  cfg_interrupt_di               : out std_logic_vector( 7 downto 0);
  cfg_interrupt_do               : in  std_logic_vector( 7 downto 0);
  cfg_interrupt_mmenable         : in  std_logic_vector( 2 downto 0);
  cfg_interrupt_msienable        : in  std_logic;
  cfg_interrupt_msixenable       : in  std_logic;
  cfg_interrupt_msixfm           : in  std_logic;
  cfg_turnoff_ok                 : out std_logic;
  cfg_to_turnoff                 : in  std_logic;
  cfg_trn_pending                : out std_logic;
  cfg_pm_wake                    : out std_logic;
  cfg_bus_number                 : in  std_logic_vector( 7 downto 0);
  cfg_device_number              : in  std_logic_vector( 4 downto 0);
  cfg_function_number            : in  std_logic_vector( 2 downto 0);
  cfg_status                     : in  std_logic_vector(15 downto 0);
  cfg_command                    : in  std_logic_vector(15 downto 0);
  cfg_dstatus                    : in  std_logic_vector(15 downto 0);
  cfg_dcommand                   : in  std_logic_vector(15 downto 0);
  cfg_lstatus                    : in  std_logic_vector(15 downto 0);
  cfg_lcommand                   : in  std_logic_vector(15 downto 0);
  cfg_dcommand2                  : in  std_logic_vector(15 downto 0);
  cfg_pcie_link_state            : in  std_logic_vector( 2 downto 0);

  cfg_interrupt_stat             : out std_logic;
  cfg_pciecap_interrupt_msgnum   : out std_logic_vector( 4 downto 0);

  pl_directed_link_change        : out std_logic_vector( 1 downto 0);
  pl_ltssm_state                 : in  std_logic_vector( 5 downto 0);
  pl_directed_link_width         : out std_logic_vector( 1 downto 0);
  pl_directed_link_speed         : out std_logic;
  pl_directed_link_auton         : out std_logic;
  pl_upstream_prefer_deemph      : out std_logic;
  pl_sel_lnk_width               : in  std_logic_vector( 1 downto 0);
  pl_sel_lnk_rate                : in  std_logic;
  pl_link_gen2_cap               : in  std_logic;
  pl_link_partner_gen2_supported : in  std_logic;
  pl_initial_link_width          : in  std_logic_vector( 2 downto 0);
  pl_link_upcfg_cap              : in  std_logic;
  pl_lane_reversal_mode          : in  std_logic_vector( 1 downto 0);
  pl_received_hot_rst            : in  std_logic;

  cfg_err_aer_headerlog          : out std_logic_vector(127 downto 0);
  cfg_aer_interrupt_msgnum       : out std_logic_vector(4 downto 0);
  cfg_err_aer_headerlog_set      : in  std_logic;
  cfg_aer_ecrc_check_en          : in  std_logic;
  cfg_aer_ecrc_gen_en            : in  std_logic;

  cfg_mgmt_di                    : out std_logic_vector(31 downto 0);
  cfg_mgmt_byte_en               : out std_logic_vector( 3 downto 0);
  cfg_mgmt_dwaddr                : out std_logic_vector( 9 downto 0);
  cfg_mgmt_wr_en                 : out std_logic;
  cfg_mgmt_rd_en                 : out std_logic;
  cfg_mgmt_wr_readonly           : out std_logic;

  cfg_dsn                        : out std_logic_vector(63 downto 0);
  -- BPI Pins 
  bpi_data : in std_logic_vector(15 downto 0);
  bpi_addr : out std_logic_vector(25 downto 0);
  bpi_wen  : out std_logic;
  bpi_advn : out std_logic;
  bpi_oen  : out std_logic;
  bpi_cen  : out std_logic

);
end pcie_app_7x;

 architecture pcie_app of pcie_app_7x is

  constant PCI_EXP_EP_OUI      : std_logic_vector(23 downto 0) := x"000A35";
  constant PCI_EXP_EP_DSN_1    : std_logic_vector(31 downto 0) := x"01" & PCI_EXP_EP_OUI;
  constant PCI_EXP_EP_DSN_2    : std_logic_vector(31 downto 0) := x"00000001";


  signal cfg_completer_id       : std_logic_vector(15 downto 0);
  signal cfg_bus_mstr_enable    : std_logic;
  signal s_axis_tx_tready_i     : std_logic;
  ----------------------------------------------------------------------
  ------------ PCIE FSM TYPE and signal declaration --------------------
  ----------------------------------------------------------------------
  type pcie_state_type is (IDLE,
									RECV_QW1,RECV_QW2,
									MEM_RD_COMP_QW1,MEM_RD_COMP_QW2);
	signal pcie_state_reg,pcie_state_next : pcie_state_type := IDLE;
	signal current_state : std_logic_vector (3 downto 0);
	
  ----------------------------------------------------------------------
  ------------ Packet TYPE and signal declaration ----------------------
  ----------------------------------------------------------------------
  type pack_type is	(NON_REQ,MEM_WR_REQ,MEM_RD_REQ,IO_WR_REQ,IO_RD_REQ);
  signal req_type : pack_type := NON_REQ;
  signal current_packet : std_logic_vector(3 downto 0);

---------------------------------------------------------------------------------
--------------------- Write Counter signal --------------------------------------
---------------------------------------------------------------------------------
	signal wr_cnt_a_rst : std_logic;
	signal wr_cnt_a_en : std_logic;
	signal wr_cnt_b_rst : std_logic;
	signal wr_cnt_b_en : std_logic;
	signal wr_cnt_a_reg,wr_cnt_a_next : std_logic_vector(31 downto 0);
	signal wr_cnt_b_reg,wr_cnt_b_next : std_logic_vector(31 downto 0);
---------------------------------------------------------------------------------
--------------------- FIND SOF Signals ------------------------------------------
---------------------------------------------------------------------------------	
	signal trn_rsof : std_logic;
---------------------------------------------------------------------------------
--------------------- Req QW1 Decoder Signals -----------------------------------
---------------------------------------------------------------------------------		
	signal qw1_reg,qw1_next				: std_logic_vector(63 downto 0);
	signal fmt_req 		: std_logic_vector(1 downto 0);
	signal type_req		: std_logic_vector(4 downto 0);
	signal tc_req			: std_logic_vector(2 downto 0);
	signal td_req			: std_logic;
	signal ep_req			: std_logic;
	signal attr_req		: std_logic_vector(1 downto 0);
	signal length_req		: std_logic_vector(9 downto 0);
	
	signal req_id_req		: std_logic_vector(15 downto 0);
	signal tag_req			: std_logic_vector(7 downto 0);
	signal lastbe_req		: std_logic_vector(3 downto 0);
	signal firstbe_req	: std_logic_vector(3 downto 0);
	
	signal packet_type 	: std_logic_vector(7 downto 0);
	
	signal address_req_reg,address_req_next   : std_logic_vector(31 downto 0);
---------------------------------------------------------------------------------
--------------------- Req QW1 Decoder Signals -----------------------------------
---------------------------------------------------------------------------------
	signal qw1_rd_comp	: std_logic_vector(63 downto 0);
	signal byte_count		: std_logic_vector(11 downto 0);
	signal qw2_rd_comp	: std_logic_vector(31 downto 0);
	signal qw1_dma_comp	: std_logic_vector(63 downto 0);
	signal qw2_dma_comp	: std_logic_vector(31 downto 0);
	signal packet_size_reg,packet_size_next	: std_logic_vector(31 downto 0);
	signal tag_gen_reg,tag_gen_next	: std_logic_vector(7 downto 0);
	signal tag_gen_rst		: std_logic;
	signal tag_gen_en 		: std_logic;
  -------------------------------------------------------
  ---------------- Debug Component ----------------------
  component ICON
  PORT (
    CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0));

	end component;
	component ILA
	PORT (
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    CLK : IN STD_LOGIC;
    DATA : IN STD_LOGIC_VECTOR(1499 DOWNTO 0);
    TRIG0 : IN STD_LOGIC_VECTOR(49 DOWNTO 0));	
	 end component;
	 signal control : std_logic_vector(35 downto 0);
	 signal debug_data : std_logic_vector(1499 downto 0);
	 signal debug_trig : std_logic_vector(49 downto 0);
	 signal s_axis_tx_tdata                : std_logic_vector((C_DATA_WIDTH - 1) downto 0); 
	 signal s_axis_tx_tkeep                : std_logic_vector((C_DATA_WIDTH/8)-1 downto 0);
	 signal s_axis_tx_tuser                : std_logic_vector(3 downto 0);
    signal s_axis_tx_tlast                : std_logic;
    signal s_axis_tx_tvalid               : std_logic;

  -- RX
	 signal rx_np_ok                       : std_logic;
    signal rx_np_req                      : std_logic;
    signal m_axis_rx_tready               : std_logic;
	 signal tx_cfg_gnt                 : std_logic;
---------------------------------------------------------------------------------
--------------------- Control Register Signals ----------------------------------
---------------------------------------------------------------------------------	 
	signal ctl_regs_reg,ctl_regs_next	: std_logic_array32(31 downto 0); -- 31 => 0x7c
	alias tx_addr_start 						: std_logic_vector(31 downto 0) is ctl_regs_reg(0);
	alias tx_addr_end 						: std_logic_vector(31 downto 0) is ctl_regs_reg(1);
	alias rx_addr_start 						: std_logic_vector(31 downto 0) is ctl_regs_reg(2);
	alias rx_addr_end 						: std_logic_vector(31 downto 0) is ctl_regs_reg(3);
	alias polling_addr_start 				: std_logic_vector(31 downto 0) is ctl_regs_reg(4);
	alias trx_enable 							: std_logic_vector(31 downto 0) is ctl_regs_reg(5);
	alias device_enable 						: std_logic_vector(31 downto 0) is ctl_regs_reg(6);
	alias device_reset 						: std_logic_vector(31 downto 0) is ctl_regs_reg(7);
	alias int_addr_start	 					: std_logic_vector(31 downto 0) is ctl_regs_reg(8);
	alias int_addr_end	 					: std_logic_vector(31 downto 0) is ctl_regs_reg(9);
	alias tx_size_reg	 						: std_logic_vector(31 downto 0) is ctl_regs_reg(16);
	alias tx_size_next	 					: std_logic_vector(31 downto 0) is ctl_regs_next(16);
	alias time_out_check					 	: std_logic_vector(31 downto 0) is ctl_regs_reg(17);
	signal dma1_size						 	: std_logic_vector(31 downto 0);

	
	--------------------------------------------------------------------------
	signal reset_pcie									: std_logic;
------------------------------------------------------------------------------------------------
---------------------- Clock Divider Component -------------------------------------------------
------------------------------------------------------------------------------------------------
	 component	clk_div is
    generic( DIV : integer := 4); -- CLK_OUT = CLK_IN / (2^DIV)
	 Port ( en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_in : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
	end component;
	signal clk_1M										: std_logic;
	--------------------------------------------------------------------


	signal	buff_data					: std_logic_vector(255 downto 0);

	
	signal 	address_gen_reg,address_gen_next,counter_value			: std_logic_vector(31 downto 0);
	signal 	addr_gen_rst,addr_gen_en					: std_logic;
	-------------
	signal dw1_data_next,dw1_data_reg : std_logic_vector(31 downto 0);
	signal cfg_interrupt_sig                 	 : std_logic;
	signal addr_gen_mid					: std_logic_vector(31 downto 0);	
	------------------------------------------------------------------------------------------------
--	component FPU
--    Port ( in1 : in  STD_LOGIC_VECTOR (31 downto 0);
--           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
--           o1 : out  STD_LOGIC_VECTOR (31 downto 0));
--	end component;
--	signal in1 : std_logic_vector(31 downto 0);
--	signal in2 : std_logic_vector(31 downto 0);
--	signal o1 : std_logic_vector(31 downto 0);
	------------------------------------------------------------------------------------------------
		component PAR_Controller is
    generic ( 	ADDR1 : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
					ADDR2 : STD_LOGIC_VECTOR (31 downto 0) := X"00010000";
					ADDR3 : STD_LOGIC_VECTOR (31 downto 0) := X"00100000";
					ADDR4 : STD_LOGIC_VECTOR (31 downto 0) := X"01000000");
	 Port ( trig : in  STD_LOGIC;
			  addr_sel : in std_logic_vector(1 downto 0);	
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           bpi_addr : out  STD_LOGIC_VECTOR (25 downto 0);
           bpi_data : in  STD_LOGIC_VECTOR (15 downto 0);
           bpi_we_b  : out  STD_LOGIC;
           bpi_adv_b : out  STD_LOGIC;
           bpi_oe_b : out  STD_LOGIC;
           bpi_ce_b : out  STD_LOGIC;
           done : out  STD_LOGIC;
			  icap_state_debug : out std_logic_vector(3 downto 0);
			  icap_output_debug : out std_logic_vector(15 downto 0);
			  icap_cnt_reg_debug : out std_logic_vector(26 downto 0);
			  trig_pos_edge_debug : out std_logic;
			  db_detect_debug : out std_logic
			  );
	end component;
	signal  trig : STD_LOGIC;
	signal  addr_sel : std_logic_vector(1 downto 0);	
   signal  icap_clk : STD_LOGIC;
   --signal  rst : STD_LOGIC;
   signal  input_addr : STD_LOGIC_VECTOR (31 downto 0);
   signal  done : STD_LOGIC;
	signal  icap_state_debug : std_logic_vector(3 downto 0);
	signal  icap_output_debug : std_logic_vector(15 downto 0);
	signal  icap_cnt_reg_debug : std_logic_vector(26 downto 0);
	signal  trig_pos_edge_debug : std_logic;
	signal  db_detect_debug : std_logic;
	signal  par_done : std_logic;
	------------------------------------------------------------
	----------------- Par Trigger Component --------------------
	------------------------------------------------------------
	component par_trigger is
    Port ( reg16 : in  STD_LOGIC_VECTOR (31 downto 0);
           trigger_clk : in  STD_LOGIC;
           dct_op : out  STD_LOGIC;
           dct_op_lev : out  STD_LOGIC;
           idct_op : out  STD_LOGIC;
           idct_op_lev : out  STD_LOGIC);
	end component;
	signal dct_op 					: std_logic;
	signal dct_op_lev 			: std_logic;
	signal idct_op		 			: std_logic;
	signal idct_op_lev 			: std_logic;
	------------------------------------------------------------
	----------------- DCT iDCT rm Component --------------------
	------------------------------------------------------------	
	component rm is
	Port ( i0 : in  STD_LOGIC_VECTOR (31 downto 0);
           i1 : in  STD_LOGIC_VECTOR (31 downto 0);
           i2 : in  STD_LOGIC_VECTOR (31 downto 0);
           i3 : in  STD_LOGIC_VECTOR (31 downto 0);
           i4 : in  STD_LOGIC_VECTOR (31 downto 0);
           i5 : in  STD_LOGIC_VECTOR (31 downto 0);
           i6 : in  STD_LOGIC_VECTOR (31 downto 0);
           i7 : in  STD_LOGIC_VECTOR (31 downto 0);
           o0 : out  STD_LOGIC_VECTOR (31 downto 0);
           o1 : out  STD_LOGIC_VECTOR (31 downto 0);
           o2 : out  STD_LOGIC_VECTOR (31 downto 0);
           o3 : out  STD_LOGIC_VECTOR (31 downto 0);
           o4 : out  STD_LOGIC_VECTOR (31 downto 0);
           o5 : out  STD_LOGIC_VECTOR (31 downto 0);
           o6 : out  STD_LOGIC_VECTOR (31 downto 0);
           o7 : out  STD_LOGIC_VECTOR (31 downto 0);
			  reset,clk,en:in std_logic);
	end component;
	signal i0 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i1 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i2 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i3 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i4 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i5 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i6 :  STD_LOGIC_VECTOR (31 downto 0);
   signal i7 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o0 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o1 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o2 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o3 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o4 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o5 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o6 :  STD_LOGIC_VECTOR (31 downto 0);
   signal o7 :  STD_LOGIC_VECTOR (31 downto 0);
	signal rm_reset,rm_en: std_logic;
begin
	current_state <= 	X"0" when pcie_state_reg <= IDLE 					else
							X"1" when pcie_state_reg <= RECV_QW1 				else
							X"2" when pcie_state_reg <= RECV_QW2 				else
							X"3" when pcie_state_reg <= MEM_RD_COMP_QW1 		else
							X"4" when pcie_state_reg <= MEM_RD_COMP_QW2 		else
							X"5";
	current_packet <= X"0" when req_type <= MEM_WR_REQ else
							X"1" when req_type <= MEM_RD_REQ else	
							X"2" when req_type <= IO_WR_REQ 	else
							X"3" when req_type <= IO_RD_REQ 	else
							X"4" when req_type <= NON_REQ 	else
							X"5";
  ------------------------------------------------------------------------------------------------------------------//
  -- PCIe Block EP Tieoffs - Example PIO doesn't support the following inputs                                       //
  ------------------------------------------------------------------------------------------------------------------//
  s_axis_tx_tdata_out	<= s_axis_tx_tdata;
  s_axis_tx_tkeep_out	<= s_axis_tx_tkeep;
  s_axis_tx_tuser_out      <= s_axis_tx_tuser;
  s_axis_tx_tlast_out  <= s_axis_tx_tlast;
  s_axis_tx_tvalid_out  <= s_axis_tx_tvalid;

  -- RX
  rx_np_ok_out  <= rx_np_ok;
  rx_np_req_out  <= rx_np_req;
  m_axis_rx_tready_out  <= m_axis_rx_tready;
  tx_cfg_gnt_out	<= tx_cfg_gnt;
  
  fc_sel                       <= "000";

  rx_np_ok                     <= '1';      -- Allow Reception of Non-posted Traffic
  rx_np_req                    <= '1';      -- Always request Non-posted Traffic if available
  s_axis_tx_tuser(0)           <= '0';      -- Unused for V6
  s_axis_tx_tuser(1)           <= '0';      -- Error forward packet
  s_axis_tx_tuser(2)           <= '0';      -- Stream packet

  --tx_cfg_gnt                   <= tx_cfg_gnt;--'1';      -- Always allow transmission of Config traffic within block

  cfg_err_cor                  <= '0';      -- Never report Correctable Error
  cfg_err_ur                   <= '0';      -- Never report UR
  cfg_err_ecrc                 <= '0';      -- Never report ECRC Error
  cfg_err_cpl_timeout          <= '0';      -- Never report Completion Timeout
  cfg_err_cpl_abort            <= '0';      -- Never report Completion Abort
  cfg_err_cpl_unexpect         <= '0';      -- Never report unexpected completion
  cfg_err_posted               <= '0';      -- Never qualify cfg_err_* inputs
  cfg_err_locked               <= '0';      -- Never qualify cfg_err_ur or cfg_err_cpl_abort
  cfg_pm_wake                  <= '0';      -- Never direct the core to send a PM_PME Message
  cfg_trn_pending              <= '0';      -- Never set the transaction pending bit in the Device Status Register

  cfg_err_atomic_egress_blocked<= '0';      -- Never report Atomic TLP blocked
  cfg_err_internal_cor         <= '0';      -- Never report internal error occurred
  cfg_err_malformed            <= '0';      -- Never report malformed error
  cfg_err_mc_blocked           <= '0';      -- Never report multi-cast TLP blocked
  cfg_err_poisoned             <= '0';      -- Never report poisoned TLP received
  cfg_err_norecovery           <= '0';      -- Never qualify cfg_err_poisoned or cfg_err_cpl_timeout
  cfg_err_acs                  <= '0';      -- Never report an ACS violation
  cfg_err_internal_uncor       <= '0';      -- Never report internal uncorrectable error
  cfg_pm_halt_aspm_l0s         <= '0';      -- Allow entry into L0s
  cfg_pm_halt_aspm_l1          <= '0';      -- Allow entry into L1
  cfg_pm_force_state_en        <= '0';      -- Do not qualify cfg_pm_force_state
  cfg_pm_force_state           <= "00";     -- Do not move force core into specific PM state

  cfg_err_aer_headerlog        <= (others => '0');      -- Zero out the AER Header Log
  cfg_aer_interrupt_msgnum     <= "00000";  -- Zero out the AER Root Error Status Register

  cfg_interrupt_stat           <= '0';      -- Never set the Interrupt Status bit
  cfg_pciecap_interrupt_msgnum <= "00000";  -- Zero out Interrupt Message Number

        -- Always drive interrupt de-assert
  --cfg_interrupt                <= '0';      -- Never drive interrupt by qualifying cfg_interrupt_assert

  pl_directed_link_change      <= "00";     -- Never initiate link change
  pl_directed_link_width       <= "00";     -- Zero out directed link width
  pl_directed_link_speed       <= '0';      -- Zero out directed link speed
  pl_directed_link_auton       <= '0';      -- Zero out link autonomous input
  pl_upstream_prefer_deemph    <= '1';      -- Zero out preferred de-emphasis of upstream port

  cfg_interrupt_di             <= x"00";    -- Do not set interrupt fields

  cfg_err_tlp_cpl_header <= x"000000000000";-- Zero out the header information

  cfg_mgmt_di            <= x"00000000";    -- Zero out CFG MGMT input data bus
  cfg_mgmt_byte_en       <= x"0";           -- Zero out CFG MGMT byte enables
  cfg_mgmt_dwaddr        <= "0000000000";   -- Zero out CFG MGMT 10-bit address port
  cfg_mgmt_wr_en         <= '0';            -- Do not write CFG space
  cfg_mgmt_rd_en         <= '0';            -- Do not read CFG space
  cfg_mgmt_wr_readonly   <= '0';            -- Never treat RO bit as RW

  cfg_dsn  <= PCI_EXP_EP_DSN_2 & PCI_EXP_EP_DSN_1;  -- Assign the input DSN

  ------------------------------------------------------------------------------------------------------------------//
  -- Programmable I/O Module                                                                                        //
  ------------------------------------------------------------------------------------------------------------------//

  cfg_completer_id     <= (cfg_bus_number & cfg_device_number & cfg_function_number);
  cfg_bus_mstr_enable  <= cfg_command(2);

  process (user_clk)
  begin
   if (user_reset = '1') then
       s_axis_tx_tready_i <= '0' after TCQ;
   elsif (user_clk'event and user_clk = '1') then
       s_axis_tx_tready_i <= s_axis_tx_tready after TCQ;
   end if;
  end process;
  ------------------------------------------------------------------------------------------------------------------//
	process(user_clk)
		begin 
		if(user_reset='1') then
			pcie_state_reg		<= IDLE;
			qw1_reg 				<= (others=>'0'); 
			address_req_reg	<= (others=>'0');
			ctl_regs_reg		<= (others=>(others=>'0'));
--			tx_size_reg(31)	<= '1';
			--ctl_regs_reg(17) <= X"CCCCCCCC";
			packet_size_reg  <= (others=>'0');

			dw1_data_reg	 	<= (others=>'0');
			address_gen_reg	<= (others=>'0');
			
		elsif (user_clk'event and user_clk='1') then 
			pcie_state_reg		<= pcie_state_next;
			qw1_reg <= qw1_next;
			address_req_reg	<= address_req_next;
			ctl_regs_reg		<=ctl_regs_next;
			packet_size_reg  <= packet_size_next;

			dw1_data_reg		 <= dw1_data_next;
			address_gen_reg	<= address_gen_next;
		end if;	
	end process;
	------------------------------------------------------------
	----------- PCIe TRX FSM -----------------------------------
	------------------------------------------------------------
	process(pcie_state_reg,trn_rsof,m_axis_rx_tvalid,s_axis_tx_tready,cfg_interrupt_rdy,cfg_interrupt_msienable)
		begin 
			pcie_state_next	<= pcie_state_reg;
			
			address_req_next	<= address_req_reg;
			m_axis_rx_tready	<='0';
			
			s_axis_tx_tdata	<= (others=>'0');
			s_axis_tx_tvalid	<= '0';
			s_axis_tx_tlast	<= '0';
			s_axis_tx_tkeep	<= X"FF";
			
			tx_cfg_gnt        <= '1';	
			
			wr_cnt_a_rst 		<= '0';
			wr_cnt_a_en	 		<= '0';
			
			wr_cnt_b_rst 		<= '0';
			wr_cnt_b_en	 		<= '0';
			
			qw1_next 			<= qw1_reg;
			
			
			address_req_next	<= address_req_reg;
			
			ctl_regs_next(15 downto 0)		<=ctl_regs_reg(15 downto 0);

			cfg_interrupt <= '0';
			cfg_interrupt_assert         <= '0';
			
			tag_gen_rst <= '0';
			tag_gen_en	<= '0';
				
			addr_gen_rst <= '0';
			addr_gen_en <= '0';
			
			packet_size_next <= packet_size_reg;

			
			dw1_data_next <= dw1_data_reg;
			
			cfg_interrupt_sig <= '0';
			
			address_gen_next	<= address_gen_reg;
			 
			case pcie_state_reg is
				when IDLE =>
					if(trn_rsof='1') then 
						pcie_state_next	<= RECV_QW1;		
					end if;	
				when RECV_QW1 =>
					if (m_axis_rx_tvalid ='1') then 
						qw1_next	<=	m_axis_rx_tdata;
						m_axis_rx_tready	<=	'1';
						pcie_state_next	<= RECV_QW2;
					end if;	
				when RECV_QW2 =>
					if (m_axis_rx_tvalid ='1') then 
						address_req_next	<=	m_axis_rx_tdata(31 downto 0);
						m_axis_rx_tready	<=	'1';
						case req_type is 
							when NON_REQ =>
								pcie_state_next	<= IDLE;
							when MEM_WR_REQ =>								
								ctl_regs_next(conv_integer(m_axis_rx_tdata(5 downto 2))) 	<= m_axis_rx_tdata(39 downto 32) &
																													m_axis_rx_tdata(47 downto 40) & 
																													m_axis_rx_tdata(55 downto 48) & 
																													m_axis_rx_tdata(63 downto 56);
									pcie_state_next	<= IDLE;	
							when MEM_RD_REQ =>
								pcie_state_next	<= MEM_RD_COMP_QW1;
							when IO_WR_REQ =>
								pcie_state_next	<= IDLE;
							when IO_RD_REQ =>
								pcie_state_next	<= IDLE;
						end case;	
					end if;	
				when MEM_RD_COMP_QW1 =>
					if(s_axis_tx_tready = '1') then 
						s_axis_tx_tdata <= qw1_rd_comp;
						s_axis_tx_tvalid <= '1';
						s_axis_tx_tkeep <= X"FF";
						pcie_state_next	<= MEM_RD_COMP_QW2;
					end if;
				when MEM_RD_COMP_QW2 => 
					if(s_axis_tx_tready = '1') then 
						s_axis_tx_tdata(31 downto 0) 	<= qw2_rd_comp;
						s_axis_tx_tdata(63 downto 32) <= ctl_regs_reg(conv_integer(address_req_reg(7 downto 2)))(7 downto 0) &  
																	ctl_regs_reg(conv_integer(address_req_reg(7 downto 2)))(15 downto 8) &
																	ctl_regs_reg(conv_integer(address_req_reg(7 downto 2)))(23 downto 16) &
																	ctl_regs_reg(conv_integer(address_req_reg(7 downto 2)))(31 downto 24);
						s_axis_tx_tvalid <= '1';
						s_axis_tx_tlast <= '1';
						s_axis_tx_tkeep <= X"FF";		
						pcie_state_next	<= IDLE;						
					end if;
			end case;	
	end process;
---------------------------------------------------------------------------------
--------------------- Req QW1 Decoder -------------------------------------------
---------------------------------------------------------------------------------
 	fmt_req		<= qw1_reg(30 downto 29);
	type_req		<= qw1_reg(28 downto 24);
	tc_req		<= qw1_reg(22 downto 20);
	td_req		<= qw1_reg(15);
	ep_req		<= qw1_reg(14);
	attr_req		<= qw1_reg(13 downto 12);
	length_req	<= qw1_reg(9 downto 0);
	
	req_id_req	<= qw1_reg(63 downto 48);
	tag_req		<= qw1_reg(47 downto 40);
	lastbe_req	<= qw1_reg(39 downto 36);
	firstbe_req	<= qw1_reg(35 downto 32);
	
	packet_type <= '0' & fmt_req & type_req;
	req_type		<= MEM_WR_REQ when packet_type = X"40" else
						MEM_RD_REQ when packet_type = X"00" else
						IO_WR_REQ  when packet_type = X"42" else
						IO_RD_REQ  when packet_type = X"02" else
						NON_REQ;
---------------------------------------------------------------------------------
--------------------- Cpmp QW1 Generate -----------------------------------------
---------------------------------------------------------------------------------						
	qw1_rd_comp(31 downto 0)	<= X"4A" &
											qw1_reg(23 downto 16) &
											'0' &
											'0' &
											attr_req&
											"00" &
											length_req;
	qw1_rd_comp(63 downto 32)	<= cfg_completer_id &
											"000" &
											'0' &
											byte_count;
	byte_count	<= length_req & "00";
	
	qw2_rd_comp <= req_id_req &
						tag_req &
						'0' &
						address_req_reg(6 downto 0);
---------------------------------------------------------------------------------
--------------------- DMA Cpmp QW1,2 Generate -------------------------------------
---------------------------------------------------------------------------------						
	qw1_dma_comp(31 downto 0)	<= X"40" &
											X"00" &--qw1_reg(23 downto 16) &
											'0' &
											'0' &
											"00" &
											"00" &
											std_logic_vector(unsigned(packet_size_reg(9 downto 0))+1);--packet_size_reg(9 downto 0);--std_logic_vector(unsigned(packet_size_reg(9 downto 0))+1);
	qw1_dma_comp(63 downto 32)	<= cfg_completer_id &
											tag_gen_reg &
											X"FF";
	qw2_dma_comp <= address_gen_reg;	
---------------------------------------------------------------------------------
--------------------- Find SOF --------------------------------------------------
------------------------------------------------------------- --------------------						
	process(user_clk)
		begin 
			if (user_clk'event and user_clk='1') then 
				if(m_axis_rx_tlast = '1') then
					trn_rsof <= '0';
				elsif(m_axis_rx_tvalid = '1') then
					trn_rsof <= '1';
				end if;	
			end if;
	end process;
	------------------------------------------------------------------------
--	uut : FPU port map (in1=> in1,in2=> in2,o1=> o1);--X"3f74bc6a" X"40176944"
--	in1 <= ctl_regs_reg(3);
--	in2 <= ctl_regs_reg(4);
--	ctl_regs_next(16) <= o1;	
	dctidct : rm
	Port map( 
			  i0 => i0,
           i1 => i1,
           i2 => i2,
           i3 => i3,
           i4 => i4,
           i5 => i5,
           i6 => i6,
           i7 => i7,
           o0 => o0,
           o1 => o1,
           o2 => o2,
           o3 => o3,
           o4 => o4,
           o5 => o5,
           o6 => o6,
           o7 => o7,
			  reset => user_reset,
			  clk => icap_clk,
			  en => '1');
			  
			  i0 <= ctl_regs_reg(3);
           i1 <= ctl_regs_reg(4);
           i2 <= ctl_regs_reg(5);
           i3 <= ctl_regs_reg(6);
           i4 <= ctl_regs_reg(7);
           i5 <= ctl_regs_reg(8);
           i6 <= ctl_regs_reg(9);
           i7 <= ctl_regs_reg(10);
           ctl_regs_next(16) <= o0;
           ctl_regs_next(17) <= o1;
           ctl_regs_next(18) <= o2;
           ctl_regs_next(19) <= o3;
           ctl_regs_next(20) <= o4;
           ctl_regs_next(21) <= o5;
           ctl_regs_next(22) <= o6;
           ctl_regs_next(23) <= o7;
	------------------------------------------------------------
	----------------- Par Trigger Component --------------------
	------------------------------------------------------------
	 par_trigger_uut : par_trigger 
    Port map( 
					reg16 => ctl_regs_reg(0),
					trigger_clk => icap_clk,
					dct_op => dct_op,
					dct_op_lev => dct_op_lev,
					idct_op => idct_op,
					idct_op_lev => idct_op_lev
				);	
	trig <= dct_op;			
----------------------------------------------------------------------------------------------
-------------------- PAR_Controller Instance -------------------------------------------------
----------------------------------------------------------------------------------------------				
		PAR_Controller_inst :PAR_Controller 
    generic map( 	
					ADDR1 => X"00000000",
					ADDR2 => X"00010000",
					ADDR3 => X"00100000",
					ADDR4 => X"01000000")
	 Port map ( trig => trig,
			  addr_sel => addr_sel,	
           clk => icap_clk,
           rst => user_reset,
           input_addr => input_addr,
           bpi_addr => bpi_addr,
           bpi_data => bpi_data,
           bpi_we_b => bpi_wen,
           bpi_adv_b => bpi_advn,
           bpi_oe_b => bpi_oen,
           bpi_ce_b => bpi_cen,
           done => done,
			  icap_state_debug => icap_state_debug,
			  icap_output_debug => icap_output_debug,
			  icap_cnt_reg_debug => icap_cnt_reg_debug,
			  trig_pos_edge_debug => trig_pos_edge_debug,
			  db_detect_debug => db_detect_debug
			  );			
	addr_sel <= ctl_regs_reg(1)(1 downto 0);
	input_addr <= ctl_regs_reg(2);
----------------------------------------------------------------------------------------------
-------------------- 1MHz Clock Generator Instance -------------------------------------------
----------------------------------------------------------------------------------------------
	inst_clk_div : clk_div 
					generic map ( DIV => 4) -- CLK_OUT = CLK_IN / (2^DIV)
					Port map ( 
								en 			=>'1',
								reset 		=> reset_pcie,
								clk_in 		=> user_clk,
								clk_out 		=> icap_clk
								);								
  -------------------------------------------------------
  ---------------- Debug Component ----------------------
  debug_icon: ICON
  port map (
    CONTROL0 => control);
  debug_ila	 : ILA
  port map (
    CONTROL => control,
    CLK => user_clk,
    DATA => debug_data,
    TRIG0 => debug_trig);
  -------------------------------------------------------
  ------------------- Debug data ------------------------	 
  debug_data(0)<= trn_rsof;--sys_rst_n_c;
  debug_data(1)<= user_reset;
  debug_data(2)<= user_lnk_up;
  
  debug_data(10 downto 3)<= cfg_bus_number;
  debug_data(15 downto 11)<= cfg_device_number;
  debug_data(18 downto 16)<= cfg_function_number;
  
  debug_data(24 downto 19)<= tx_buf_av;
  debug_data(25)<= tx_cfg_req;
  debug_data(26)<= tx_err_drop;
  debug_data(27)<= s_axis_tx_tready;
  debug_data(91 downto 28)<= s_axis_tx_tdata;
  debug_data(99 downto 92)<= s_axis_tx_tkeep;
  debug_data(100)<= s_axis_tx_tlast;
  debug_data(101)<= s_axis_tx_tvalid;
  debug_data(105 downto 102)<= s_axis_tx_tuser;
  
  debug_data(169 downto 106)<= m_axis_rx_tdata;
  debug_data(177 downto 170)<= m_axis_rx_tkeep;                            
  debug_data(178)<= m_axis_rx_tlast;
  debug_data(179)<= m_axis_rx_tvalid;
  debug_data(180)<= m_axis_rx_tready;
  debug_data(202 downto 181)<= m_axis_rx_tuser;
  debug_data(203)<= rx_np_ok;
  debug_data(204)<= rx_np_req;
  debug_data(205)<= tx_cfg_gnt;
  debug_data(209 downto 206) <= current_state;
  debug_data(213 downto 210) <= current_packet;
  
  debug_data(215 downto 214) <= fmt_req;
  debug_data(220 downto 216) <= type_req;
  debug_data(223 downto 221) <=	tc_req;
  debug_data(224) <= td_req;
  debug_data(225) <=	ep_req;
  debug_data(227 downto 226) <=	attr_req;
  debug_data(237 downto 228) <= length_req;
	
  debug_data(253 downto 238) <= req_id_req;
  debug_data(261 downto 254) <= tag_req;
  debug_data(265 downto 262) <=	lastbe_req;
  debug_data(269 downto 266) <= firstbe_req;
  
  debug_data(333 downto 270) <= qw1_rd_comp;
  debug_data(345 downto 334) <= byte_count;
  debug_data(377 downto 346) <= qw2_rd_comp;
  
  debug_data(378) <= wr_cnt_a_rst;
  debug_data(379) <= wr_cnt_a_en;

  debug_data(395 downto 380) <= cfg_command;
  debug_data(403 downto 396) <= cfg_interrupt_do;
  debug_data(404) <= cfg_interrupt_rdy;

  debug_data(412 downto 405) <= tag_gen_reg;
  debug_data(468 downto 437) <= address_gen_reg;
  debug_data(532 downto 469) <= qw1_reg;
  
  debug_data(533) <= cfg_interrupt_msienable;
  debug_data(534)  <= cfg_interrupt_msixenable; 
  debug_data(566 downto 535)  <= ctl_regs_reg(conv_integer(address_req_reg(7 downto 2))) ;
  


  
  debug_data(630 downto 599) <= wr_cnt_a_reg;
  debug_data(662 downto 631) <= wr_cnt_b_reg;
  
  debug_data(694 downto 663) <= tx_addr_start;--dma1_addr32;
  debug_data(726 downto 695) <= tx_addr_end;--dma1_addr64;
  debug_data(758 downto 727) <= rx_addr_start;--dma1_size;
  debug_data(790 downto 759) <= rx_addr_end;--dma1_control;
  debug_data(822 downto 791) <= polling_addr_start;--write_reg_addr;
  debug_data(854 downto 823) <= trx_enable;--write_reg_data;
  debug_data(886 downto 855) <= device_enable;--dma0_addr32;--read_reg_addr;
  debug_data(918 downto 887) <= device_reset;--dma0_addr64;--read_reg_data;
  debug_data(951 downto 920) <= int_addr_start;--dma0_size;--dma0_int;
  debug_data(983 downto 952) <= int_addr_end;--dma0_control;--dma1_int;
  debug_data(1050 downto 1019) <= tx_size_reg;
  debug_data(1082 downto 1051) <= time_out_check;
  



  debug_data(1018 downto 987) <= packet_size_reg;
  debug_data(1098 downto 1083) <= cfg_dcommand;
  debug_data(1114 downto 1099) <= cfg_dcommand2;
  debug_data(1115) <=	cfg_interrupt_sig;
  debug_data(1147 downto 1116) <= addr_gen_mid;
  debug_data(1179 downto 1148) <= o1;
  -------------------------------------------------------
  ------------------- Debug data ------------------------	 
  debug_trig(0)<= trn_rsof;--sys_rst_n_c;
  debug_trig(1)<= user_reset;
  debug_trig(2)<= user_lnk_up;
  
  debug_trig(3)<= tx_cfg_req;
  debug_trig(4)<= tx_err_drop;
  debug_trig(5)<= s_axis_tx_tready;
  debug_trig(13 downto 6)<= s_axis_tx_tkeep;
  debug_trig(14)<= s_axis_tx_tlast;
  debug_trig(15)<= s_axis_tx_tvalid;
  debug_trig(19 downto 16)<= s_axis_tx_tuser;
 
  debug_trig(27 downto 20)<= m_axis_rx_tkeep;                            
  debug_trig(28)<= m_axis_rx_tlast;
  debug_trig(29)<= m_axis_rx_tvalid;
  debug_trig(30)<= m_axis_rx_tready;
  debug_trig(31)<= rx_np_ok;
  debug_trig(32)<= rx_np_req;
  
  debug_trig(33)<= tx_cfg_gnt;	
	
  debug_trig(37 downto 34) <= current_state;
  debug_trig(41 downto 38) <= current_packet;	
  
  debug_trig(42) <= cfg_interrupt_msienable;
  debug_trig(43)  <= cfg_interrupt_msixenable; 
	
  debug_trig(45)<= cfg_interrupt_rdy;
  debug_trig(46) <=	cfg_interrupt_sig;
end; -- pcie_app
