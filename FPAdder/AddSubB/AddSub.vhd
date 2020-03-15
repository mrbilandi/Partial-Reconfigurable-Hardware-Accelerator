----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:24:51 05/13/2014 
-- Design Name: 
-- Module Name:    AddSub - Behavioral 
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

entity FPU is --AddSub is
    Port ( in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
           o1 : out  STD_LOGIC_VECTOR (31 downto 0));
end FPU; --AddSub;

architecture Behavioral of FPU is --AddSub is
	signal s1,s2,s_l,s_last: std_logic;
	signal e1,e2,e_l,e_s,e_bl,e_last:std_logic_vector(7 downto 0);
	signal m1,m2,m_bl,m_last:std_logic_vector(22 downto 0);
	signal m_l,m_s,m_s_shr:std_logic_vector(23 downto 0);	
	signal m_o:std_logic_vector(24 downto 0);
	signal diff : std_logic_vector (7 downto 0);
	signal a_sb,e1gte2,in1eqin2: std_logic;
	signal sh_left,shl_val:std_logic_vector(4 downto 0);
	--
	signal addsubb :  STD_LOGIC := '1';
begin
	
	s1<=in1(31);
	s2<=in2(31);
	e1<=in1(30 downto 23);
	e2<=in2(30 downto 23);
	m1<=in1(22 downto 0);
	m2<=in2(22 downto 0);
	----------------------------------------------
	e1gte2<= '1' when ((e1>e2)or((e1=e2)and(m1>m2)))  else 
				'0';
	in1eqin2<=	'1' when ((e1=e2) and (m1=m2)) else
					'0';
	----------------------------------------------
	process(e1gte2,e1,e2,m1,m2,s1,s2)
		begin
			if(e1gte2='1') then 
				e_l<=e1;
				e_s<=e2;
				m_l<='1' & m1;
				m_s<='1' & m2;
				s_l<=s1;
			else 
				e_l<=e2;
				e_s<=e1;
				m_l<='1' & m2;
				m_s<='1' & m1;
				s_l<=s2;
			end if;
	end process;
	---------------------------------------------
	e_bl<= std_logic_vector(unsigned(e_l)+1) when m_o(24)='1' else 
				e_l;
	e_last<=	(others=>'0') when ((in1eqin2='1') and (a_sb='0')) else
				std_logic_vector(unsigned(e_bl)-unsigned("000"&shl_val)) when a_sb='0' else 				
				e_bl;		
	---------------------------------------------
	s_last<= s_l when addsubb='1' else 
				(s1 and not(s2))or(s1 and e1gte2)or(not(s1) and not(s2) and not(e1gte2));
	----------------------------------------------------------------------------------
	a_sb<= s1 xor s2 xor addsubb;
	------------------------------
	diff<= std_logic_vector(unsigned(e_l)-unsigned(e_s));
	-----------------------------------
	shr: entity work.BShifter23_Right(rtl)
			port map(m_s,diff(4 downto 0),m_s_shr);
	---------------------------------------------------
	m_o<= std_logic_vector(unsigned('0'&m_l)+unsigned('0'&m_s_shr)) when a_sb='1' else 
			(others=>'0') when ((in1eqin2='1') and (a_sb='0')) else 
			std_logic_vector(unsigned('0'&m_l)-unsigned('0'&m_s_shr));
	------------------------------------------------------------------------------
   m_bl<= m_o(23 downto 1) when m_o(24)='1' else 				
				m_o(22 downto 0);
	--------------------------------------------------------
	enc: entity work.encoder(rtl)
			port map(m_o(23 downto 0),sh_left);
	shl_val<= sh_left when a_sb='0' else 
					(others=>'0');
	--------------------------------------------------------
	shl: entity work.BShifter23_Left(rtl)
			port map(m_bl,shl_val,m_last);
	--------------------------------------------------------	
	o1<= s_last & e_last & m_last;	
end Behavioral;

