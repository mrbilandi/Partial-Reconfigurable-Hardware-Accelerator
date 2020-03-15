----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:49 11/24/2014 
-- Design Name: 
-- Module Name:    par_trigger - rtl 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity par_trigger is
    Port ( reg16 : in  STD_LOGIC_VECTOR (31 downto 0);
           trigger_clk : in  STD_LOGIC;
           dct_op : out  STD_LOGIC;
           dct_op_lev : out  STD_LOGIC;
           idct_op : out  STD_LOGIC;
           idct_op_lev : out  STD_LOGIC);
end par_trigger;

architecture rtl of par_trigger is
	signal dct,dct_d1,idct,idct_d1 	: std_logic;
begin
	dct	<= '1' when (reg16 = X"0000FFFF") else
				'0';
	idct	<= '1' when (reg16 = X"FFFF0000") else
				'0';				
	process(trigger_clk)
		begin 
			if(trigger_clk'event and trigger_clk='1') then 
				dct_d1	<= dct;
				idct_d1	<= idct;
			end if;
	end process;	
	----
	dct_op	<= dct and (not(dct_d1));
	idct_op	<= idct and (not(idct_d1));	
	
	dct_op_lev	<= dct;
	idct_op_lev	<= idct;

end rtl;

