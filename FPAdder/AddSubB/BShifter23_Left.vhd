----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:23 05/12/2014 
-- Design Name: 
-- Module Name:    BShifter23_Left - Behavioral 
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

entity BShifter23_Left is
    Port ( in1 : in  STD_LOGIC_VECTOR (22 downto 0);
           amt : in  STD_LOGIC_VECTOR (4 downto 0);
           o1 : out  STD_LOGIC_VECTOR (22 downto 0));
end BShifter23_Left;

architecture rtl of BShifter23_Left is
	signal s0,s1,s2,s3,s4: std_logic_vector (22 downto 0);
begin
	s0<= in1(21 downto 0) & '0' when amt(0)='1' else
			in1;
	s1<= s0(20 downto 0) & "00" when amt(1)='1' else
			s0;		
	s2<= s1(18 downto 0) & "0000" when amt(2)='1' else
			s1;				
	s3<= s2(14 downto 0) & "00000000" when amt(3)='1' else
			s2;						
	s4<= s3(6 downto 0) & "0000000000000000" when amt(4)='1' else
			s3;
	o1<=s4;			
			
end rtl;

