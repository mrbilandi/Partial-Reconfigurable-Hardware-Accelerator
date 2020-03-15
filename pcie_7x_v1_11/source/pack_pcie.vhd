library IEEE;
use IEEE.std_logic_1164.all;

package Pack_lan is

type std_logic_array32 	is array (natural range<>) of std_logic_vector(31 downto 0);
type std_logic_array8 	is array (natural range<>) of std_logic_vector(7 downto 0);

end Pack_lan;