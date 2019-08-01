library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux2x1 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           X : out  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC);
end Mux2x1;

architecture Behavioral of Mux2x1 is

begin
	X <= A when (C = '0') else B;
end Behavioral;

