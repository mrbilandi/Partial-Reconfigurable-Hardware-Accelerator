----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:01 08/27/2014 
-- Design Name: 
-- Module Name:    clk_div - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div is
    generic( DIV : integer := 4); -- CLK_OUT = CLK_IN / (2^DIV)
	 Port ( en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_in : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is
	signal cnt_reg,cnt_next				: std_logic_vector(DIV-1 downto 0);
begin
	process(clk_in,reset,en)
		begin 
			if(reset='1') then 
				cnt_reg<= (others=>'0');
			elsif(clk_in'event and clk_in='1') then 
				if(en='1') then 
					cnt_reg <= cnt_next;
				end if;	
			end if;
	end process;
	--
	cnt_next <= std_logic_vector(unsigned(cnt_reg)+1);
	------------------------------------------------------
	clk_out <= cnt_reg(DIV-1);
end Behavioral;

