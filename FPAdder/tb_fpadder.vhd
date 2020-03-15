--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:43:00 01/06/2015
-- Design Name:   
-- Module Name:   D:/MUTProject/KC705/PartialReconfigWithout9B/FPAdder/tb_fpadder.vhd
-- Project Name:  FPAdder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AddSub
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_fpadder IS
END tb_fpadder;
 
ARCHITECTURE behavior OF tb_fpadder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AddSub
    PORT(
         in1 : IN  std_logic_vector(31 downto 0);
         in2 : IN  std_logic_vector(31 downto 0);
         o1 : OUT  std_logic_vector(31 downto 0)
--         addsubb : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in1 : std_logic_vector(31 downto 0) := (others => '0');
   signal in2 : std_logic_vector(31 downto 0) := (others => '0');
--   signal addsubb : std_logic := '0';

 	--Outputs
   signal o1 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
-- 
--   constant <clock>_period : time := 10 ns;
-- 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AddSub PORT MAP (
          in1 => in1,
          in2 => in2,
          o1 => o1
--          addsubb => addsubb
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      in1 <= X"3f74bc6a";--0.956
      in2 <= X"40176944";--2.3658
--      addsubb <= '1';
		-- o must be equal 3.3218 or 0x4054985f
      wait for 100 ns;	

   end process;

END;
