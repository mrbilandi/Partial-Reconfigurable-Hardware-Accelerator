----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:02 01/05/2015 
-- Design Name: 
-- Module Name:    PAR_Controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity PAR_Controller is
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
end PAR_Controller;

architecture Behavioral of PAR_Controller is
	
component ICAPE2
   generic(
      DEVICE_ID : string := X"3651093";     -- Specifies the pre-programmed Device ID value to be used for simulation
                
      ICAP_WIDTH : string := "X16";         -- Specifies the input and output data width.
      SIM_CFG_FILE_NAME : string := "None"  -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
                                   
   );
   port (
      O : out std_logic_vector(15 downto 0);         -- 32-bit output: Configuration data output bus
      CLK : in std_logic;     -- 1-bit input: Clock Input
      CSIB : in std_logic;   -- 1-bit input: Active-Low ICAP Enable
      I : in std_logic_vector(15 downto 0);         -- 32-bit input: Configuration data input bus
      RDWRB : in std_logic  -- 1-bit input: Read/Write Select input
   );
	end component;
	signal icap_output : std_logic_vector(15 downto 0);
	signal icap_clk : std_logic;
	signal icap_input : std_logic_vector(15 downto 0);
	signal icap_csib : std_logic;
	signal icap_rdwrb : std_logic;
	--------------------------------------------------
	type state is (IDLE,s1,PAGE_WAIT1,PAGE_WAIT2,PAGE_WAIT3,FINISH);
	signal icap_state_reg,icap_state_next : state := IDLE;
	signal icap_rst : std_logic:='0';
	-------------------------------------------------------------------
	signal icap_cnt_rst : std_logic;
	signal icap_cnt_en : std_logic;
	signal icap_cnt_reg,icap_cnt_next : std_logic_vector(26 downto 0);
	signal icap_state : std_logic_vector(3 downto 0);
	---------------------------------------------------------------------
	signal trig_pos_edge,trig_d : std_logic;
	----------------------------------------------------------
	signal page_cnt_rst,page_cnt_en : std_logic;
	signal page_cnt_reg,page_cnt_next : std_logic_vector(3 downto 0);
	-----------------------------------------------------------------
	signal db_detect_next,db_detect_reg : std_logic:='0';
	signal done_reg,done_next : std_logic:='0';
	-----------------------------------------------------------------
	signal start_addr : std_logic_vector(25 downto 0);
begin
	icap_clk <= clk;
	icap_state <=  X"0" when icap_state_reg = IDLE else
						X"1" when icap_state_reg = s1 else
						X"2" when icap_state_reg = PAGE_WAIT1 else
						X"3" when icap_state_reg = PAGE_WAIT2 else
						X"4" when icap_state_reg = PAGE_WAIT3 else
						X"5" when icap_state_reg = FINISH else
						X"6";
	 ------------------------------------------
	 ICAPE2_inst : ICAPE2
   generic map (
      DEVICE_ID => X"3651093",     -- Specifies the pre-programmed Device ID value to be used for simulation
                                   -- purposes.
      ICAP_WIDTH => "X16",         -- Specifies the input and output data width.
      SIM_CFG_FILE_NAME => "None"  -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
                                   -- model.
   )
   port map (
      O => icap_output,         -- 32-bit output: Configuration data output bus
      CLK => icap_clk,     -- 1-bit input: Clock Input
      CSIB => icap_csib,   -- 1-bit input: Active-Low ICAP Enable
      I => icap_input,--(7 downto 0) & icap_input(15 downto 8),         -- 32-bit input: Configuration data input bus
      RDWRB => icap_rdwrb  -- 1-bit input: Read/Write Select input
   );
	icap_input <= bpi_data;
	icap_output_debug <= icap_output;
	------------------------------------------------------------------------
	start_addr <= 	ADDR1(25 downto 0) when (addr_sel = "00") else --"00000000000000000000000000";--
						ADDR2(25 downto 0) when (addr_sel = "01") else
						ADDR3(25 downto 0) when (addr_sel = "10") else
						input_addr(25 downto 0);
	------------------------------------------------------------------------
	process(icap_clk)
	begin 
		if(icap_clk'event and icap_clk='1') then 
			trig_d <= trig;
		end if;
	end process;
	trig_pos_edge <= trig and (not(trig_d));
	----------------------------------------------------------------------------	
	process(icap_clk,icap_rst)
	begin 
		if(icap_rst = '1') then
			icap_state_reg <= IDLE;
			done_reg <= '0';
			db_detect_reg <= '0';
		elsif(icap_clk'event and icap_clk = '1') then 
			icap_state_reg <= icap_state_next;
			done_reg <= done_next;
			db_detect_reg <= db_detect_next;
		end if;
	end process;
	
	process(icap_state_reg,trig_pos_edge,icap_cnt_reg,db_detect_reg,icap_output,page_cnt_reg)
	begin 
		icap_state_next <= icap_state_reg;
		
		icap_csib  <= '1';
		icap_rdwrb <= '1';
		icap_cnt_en <= '0';
		icap_cnt_rst <= '0';
		
		bpi_we_b  <= '1';
		bpi_adv_b <= '1';
		bpi_oe_b  <= '1';
		bpi_ce_b  <= '1';
		
		page_cnt_rst <= '1';
		page_cnt_en  <= '0';
		
		db_detect_next <= db_detect_reg;
		done_next <= done_reg;
		
		case(icap_state_reg) is
			when IDLE =>
				if(trig_pos_edge = '1') then 	
					icap_state_next <= s1;
				end if;	
			when s1 =>
				bpi_adv_b <= '0';
				bpi_oe_b  <= '0';
				bpi_ce_b  <= '0';
				bpi_addr <= (icap_cnt_reg(25 downto 0)+ start_addr);--   - ("00"&X"00000B") cnt + start addr of revision2
				
				icap_csib  <= '0';
				icap_rdwrb <= '0';
				icap_cnt_en <= '1';
								
				page_cnt_en <= '1';
				page_cnt_rst <= '0';
				
				if(icap_output(7 downto 0) = X"DB") then 
					db_detect_next <= '1';
				end if;
				
				if((icap_output(7 downto 0) = X"9B") and (db_detect_reg = '1')) then 
					icap_state_next <= FINISH; 
				elsif(page_cnt_reg = X"F") then
					icap_state_next <= PAGE_WAIT1; 
				end if;	
			when PAGE_WAIT1 =>
				bpi_adv_b <= '0';
				bpi_oe_b  <= '0';
				bpi_ce_b  <= '0';
				bpi_addr <= (icap_cnt_reg(25 downto 0) + start_addr);-- - ("00"&X"00000C") cnt + start addr of revision2
				
--				page_cnt_rst <= '1';
				
				icap_state_next <= PAGE_WAIT2;
			when PAGE_WAIT2 =>
				bpi_adv_b <= '0';
				bpi_oe_b  <= '0';
				bpi_ce_b  <= '0';
				bpi_addr <= (icap_cnt_reg(25 downto 0) + start_addr );--- ("00"&X"00000B")cnt + start addr of revision2
				
				icap_state_next <= PAGE_WAIT3;
			when PAGE_WAIT3 =>
				bpi_adv_b <= '0';
				bpi_oe_b  <= '0';
				bpi_ce_b  <= '0';
				bpi_addr <= (icap_cnt_reg(25 downto 0) + start_addr);-- - ("00"&X"00000B") cnt + start addr of revision2
							
				icap_state_next <= s1;
			when FINISH => 			
				icap_cnt_rst <= '1';
				
				db_detect_next <='0';
	
				if(trig_pos_edge = '1') then 
					done_next <= '0';
					icap_state_next <= s1;
				else
					done_next <= '1';
				end if;
		end case;
	end process;
	done <= done_reg;
	
	-----------------------------------------------------------------------
	process(icap_clk,icap_cnt_rst)
	begin 
		if(icap_cnt_rst = '1') then 
			icap_cnt_reg <= (others=>'0');
		elsif(icap_clk'event and icap_clk = '1') then 
			if(icap_cnt_en = '1') then
				icap_cnt_reg <= icap_cnt_next;
			end if;	
		end if;
	end process;
	icap_cnt_next <= std_logic_vector(unsigned(icap_cnt_reg) + 1);
	------------------------------------------------------------------------
	process(icap_clk,page_cnt_rst)
		begin 
			if(page_cnt_rst = '1') then 
				page_cnt_reg <= (others => '0');
			elsif(icap_clk'event and icap_clk = '1') then
				if(page_cnt_en = '1') then 
					page_cnt_reg <= page_cnt_next;
				end if;	
			end if;	
	end process;	
	page_cnt_next <= std_logic_vector(unsigned(page_cnt_reg)+1);
	-------------------------------------------------------------------------
	icap_state_debug <= icap_state;
	icap_output_debug <= icap_output; 
	icap_cnt_reg_debug <= icap_cnt_reg;
	trig_pos_edge_debug <= trig_pos_edge;
	db_detect_debug <= db_detect_reg;
end Behavioral;

