library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimpleCm is
	Port ( A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CmpOut : out  STD_LOGIC);
end SimpleCm;

architecture Behavioral of SimpleCm is

begin
	
	CmpOut <= '1' when A1=A2 else '0';

end Behavioral;

