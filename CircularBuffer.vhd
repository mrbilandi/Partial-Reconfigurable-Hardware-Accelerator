----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:25:09 08/27/2014 
-- Design Name: 
-- Module Name:    CircularBuffer - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity CircularBuffer is
	 generic(  	wr_data_width 	: integer := 256;
					wr_addr_width 	: integer := 13;
					rd_data_width 	: integer := 32;
					rd_addr_width 	: integer := 16
				);	
	 Port ( din 				: in  STD_LOGIC_VECTOR (wr_data_width-1 downto 0);
           wr 				: in  STD_LOGIC;
           clk_in 			: in  STD_LOGIC;
           dout 				: out  STD_LOGIC_VECTOR (rd_data_width-1 downto 0);
           rd 				: in  STD_LOGIC;
           full 				: out  STD_LOGIC;
           empty 				: out  STD_LOGIC;
           full_value_rdy 	: out  STD_LOGIC_VECTOR (rd_addr_width-1 downto 0);
           clk_out 			: in  STD_LOGIC;
			  reset   			: in  STD_LOGIC;
			  addr_write      : out std_logic_vector(12 downto 0);
			  addr_read       : out std_logic_vector(15 downto 0);
			  rd_temp_out			: out std_logic
			  );
end CircularBuffer;

architecture Behavioral of CircularBuffer is
------------- DPRAM Component -------------------- 
COMPONENT dpram
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
	signal 	wr_allow										: std_logic:='1';
	signal	rd_allow										: std_logic:='0';	
---------------------------------------------------------------------------------------------
	signal	empty_sig									: std_logic:='1';
	signal	full_sig										: std_logic:='0';
	signal 	wr_pointer_reg,wr_pointer_next 		: std_logic_vector(wr_addr_width-1 downto 0);
	signal 	rd_pointer_reg,rd_pointer_next 		: std_logic_vector(rd_addr_width-1 downto 0);
	signal  	sub_pointer									: std_logic_vector(wr_addr_width-1 downto 0);--(wr_pointer_reg'range);
	signal	rd_pointer_1								: std_logic_vector(wr_addr_width-1 downto 0);--(wr_pointer_reg'range);
	signal 	zero_position								: std_logic;
	signal 	wr_gt_rd,rd_gt_wr							: std_logic;
	signal 	rd_temp										: std_logic;
begin
	process(clk_in,reset,wr_allow)
		begin 
			if (reset='1') then 
				wr_pointer_reg <= (others=>'0');
			elsif (clk_in'event and clk_in='1') then 
				if(wr_allow='1') then 
					wr_pointer_reg <= wr_pointer_next;
				end if;
			end if;	
	end process;
		process(clk_out,reset,rd_allow)
		begin 
			if (reset='1') then 
				rd_pointer_reg <= (others=>'0');
			elsif (clk_out'event and clk_out='1') then
				if(rd_allow='1') then
					rd_pointer_reg <= rd_pointer_next;
				end if;	
			end if;	
	end process;
	-----
	wr_pointer_next <= std_logic_vector(unsigned(wr_pointer_reg)+1);
	rd_pointer_next <= std_logic_vector(unsigned(rd_pointer_reg)+1);
	addr_write<= wr_pointer_reg;
	addr_read <= rd_pointer_reg;
	--------------------------------------------------------------------------------------
	wr_allow <= '1' when (wr = '1') else--and (full_sig = '0')) else
					'0';
	rd_allow <= '1' when (rd = '1') else-- and (empty_sig = '0')) else --and (rd_temp='1'))else--
					'0';
	---------------------------------------------------------------------------------------
	wr_gt_rd 		<= '1' when wr_pointer_reg > rd_pointer_reg(15 downto 3)  else
							'0';
	rd_gt_wr 		<= '1' when rd_pointer_reg(15 downto 3) > wr_pointer_reg  else
							'0';
	full_value_rdy <= (wr_pointer_reg&"000") - rd_pointer_reg;--std_logic_vector(unsigned(wr_pointer_reg&"0000")-unsigned(rd_pointer_reg));			--	when wr_gt_rd = '1' 	else
							--std_logic_vector(unsigned(rd_pointer_reg)- unsigned(wr_pointer_reg&"0000")) 	when rd_gt_wr = '1'	else--262144 -
							--(others=>'0');
	rd_temp <= 	'1'  when (rd_pointer_reg- (wr_pointer_reg&"000") >= ("1000000000000000"))else --((unsigned(rd_pointer_reg) - unsigned(wr_pointer_reg&"0000"))>= 64) else --)>= ("010000000000000000")) else
					'0';
	rd_temp_out <= rd_temp;				
	sub_pointer   	<=  std_logic_vector(unsigned(wr_pointer_reg)-unsigned(rd_pointer_reg(15 downto 3)));
	
	zero_position 	<=  '1' when ((wr_pointer_reg = "0000000000000") and 	(rd_pointer_reg = "0000000000000000")) else
							'0';
	rd_pointer_1  	<= 	(others=>'1')	 when (rd_pointer_reg(15 downto 3) = "0000000000000") else ---0000") else
							std_logic_vector(unsigned(rd_pointer_reg(15 downto 3))-1);					
	
	full_sig 		<= '1'		when 	((wr_pointer_reg = rd_pointer_1) and (zero_position = '0'))	else
							'0';
	empty_sig 		<=	'1'		when 	zero_position 	= '1' 						     else
							'1'		when  (rd_pointer_reg = (wr_pointer_reg&"000"))  else
							'0';
	full				<= full_sig;
	empty				<= empty_sig;
	-----------------------------------------------------------------------------------
	uut_dpram : dpram
				PORT MAP (
								clka => clk_in,
								wea (0)=> wr_allow,
								addra => wr_pointer_reg,
								dina => din,
								clkb => clk_out,
								addrb => rd_pointer_reg,
								doutb => dout
							);
	---------------------------------------------------------------------------------------
--	process(clk,reset)
--		begin
--			if(reset='1') then
--				full_reg	<=	'0';
--				empty_reg <= '1';
--			elsif(clk'event and clk ='1') then 
--				full_reg	<=	full_next;
--				empty_reg <= empty_next;
--			end if;
--	end process;
--	op <= wr & rd;
--	process (op,full_reg,empty_reg,wr_pointer_reg,rd_pointer_reg)
--		begin 
--			full_next <= full_reg;
--			empty_next <= empty_reg;
--			wr_pointer_next <= wr_pointer_reg;
--			rd_pointer_next <= rd_pointer_reg;
--			case op is 
--				when "00" => 
--				when "01" =>
--					if (empty_reg /='1') then 
--						rd_pointer_next <= std_logic_vector(unsigned(rd_pointer_reg)+1);
--						full_next <= '0';
--						if(rd_pointer_reg = wr_pointer_reg) then
--							empty_next <= '1';
--						end if;	
--					end if;	
--				when "10" =>
--					if (full_reg /='1') then 
--						wr_pointer_next <= std_logic_vector(unsigned(wr_pointer_reg)+1);
--						empty_next <= '0';
--						if(wr_pointer_reg = rd_pointer_reg)
--					end if;
--				when "11" => 	
--	end process;	
end Behavioral;

