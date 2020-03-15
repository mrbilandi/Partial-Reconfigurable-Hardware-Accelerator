----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:13:08 05/14/2014 
-- Design Name: 
-- Module Name:    encoder - Behavioral 
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

entity encoder is
    Port ( in1 : in  STD_LOGIC_VECTOR (23 downto 0);
           o1 : out  STD_LOGIC_VECTOR (4 downto 0));
end encoder;

architecture rtl of encoder is

begin
	o1<=	"00000" when in1(23)='1' else 
			"00001" when in1(22)='1' else 
			"00010" when in1(21)='1' else
			"00011" when in1(20)='1' else
			"00100" when in1(19)='1' else
			"00101" when in1(18)='1' else
			"00110" when in1(17)='1' else
			"00111" when in1(16)='1' else
			"01000" when in1(15)='1' else
			"01001" when in1(14)='1' else
			"01010" when in1(13)='1' else 
			"01011" when in1(12)='1' else 
			"01100" when in1(11)='1' else
			"01101" when in1(10)='1' else
			"01110" when in1(9)='1' else
			"01111" when in1(8)='1' else
			"10000" when in1(7)='1' else
			"10001" when in1(6)='1' else
			"10001" when in1(5)='1' else
			"10010" when in1(4)='1' else
			"10011" when in1(3)='1' else
			"10100" when in1(2)='1' else
			"10101" when in1(1)='1' else
			"10110" when in1(0)='1' else
			"00000";
end rtl;

