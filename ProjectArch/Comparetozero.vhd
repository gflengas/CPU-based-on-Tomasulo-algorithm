library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; --biblio8ikes gia grhgoroterh ektelesh pra3ewn
use ieee.NUMERIC_STD.all;

entity Comparetozero is
    Port ( A1 : in  STD_LOGIC_VECTOR (4 downto 0);
			  A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CmpOut : out  STD_LOGIC);
end Comparetozero;

architecture Behavioral of Comparetozero is

begin
	CmpOut <= '1' when (A1=A2)	 else '0';
end Behavioral;

