library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SimpleReg is
    Port ( Data : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (1 downto 0));
end SimpleReg;

architecture Behavioral of SimpleReg is

begin
process(CLK,Reset)
	begin
		if Reset = '1' then 
			Dout<="00";
		elsif rising_edge(CLK) then 
			Dout<=Data;
		end if;
	end process;

end Behavioral;

