library IEEE;
use IEEE.STD_LOGIC_1164.all;

package ROBArrays is
	type Array16x32 is array (15 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
	type Array16x5 is array (15 downto 0) of STD_LOGIC_VECTOR (4 downto 0);
	type Array16x2 is array (15 downto 0) of STD_LOGIC_VECTOR (1 downto 0);
end ROBArrays;

package body ROBArrays is

end ROBArrays;
