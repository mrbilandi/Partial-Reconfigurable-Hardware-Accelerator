----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:20 05/12/2014 
-- Design Name: 
-- Module Name:    BShifter23 - RTL 
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

entity BShifter23_Right is
    Port ( in1 : in  STD_LOGIC_VECTOR (23 downto 0);
           amt : in  STD_LOGIC_VECTOR (4 downto 0);
           o1 : out  STD_LOGIC_VECTOR (23 downto 0));
end BShifter23_Right;

architecture RTL of BShifter23_Right is
	signal s0,s1,s2,s3,s4: std_logic_vector(23 downto 0);
begin
	s0<= '0' & in1(23 downto 1) when amt(0)='1' else
			in1;
	s1<= "00" & s0(23 downto 2) when amt(1)='1' else
			s0;		
	s2<= "0000" & s1(23 downto 4) when amt(2)='1' else
			s1;
	s3<= "00000000" & s2(23 downto 8) when amt(3)='1' else
			s2;		
	s4<= "0000000000000000" & s3(23 downto 16) when amt(4)='1' else
			s3;
	o1<=s4;		

end RTL;

