library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ROBArrays.ALL;

entity Mux16x32 is
    Port ( i : in  Array16x32;
           S : in  STD_LOGIC_VECTOR (3 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux16x32;

architecture Behavioral of Mux16x32 is

begin
with S select
	Dout <= i(0) when "0000",
			  i(1) when "0001",
			  i(2) when "0010",
			  i(3) when "0011",
			  i(4) when "0100",
			  i(5) when "0101",
			  i(6) when "0110",
			  i(7) when "0111",
			  i(8) when "1000",
			  i(9) when "1001",
			  i(10) when "1010",
			  i(11) when "1011",
			  i(12) when "1100",
			  i(13) when "1101",
			  i(14) when "1110",
			  i(15) when others;

end Behavioral;

