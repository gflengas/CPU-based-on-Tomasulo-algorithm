library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Compare is
    Port ( A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CmpOut : out  STD_LOGIC);
end Compare;

architecture Behavioral of Compare is

begin
	CmpOut <= '1' when ((A1=A2) AND A2 /="00000")	 else '0';
end Behavioral;

