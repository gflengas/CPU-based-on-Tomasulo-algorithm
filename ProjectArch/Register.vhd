library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register1bit is
	Port ( Data : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC);
end Register1bit;

architecture Behavioral of Register1bit is

begin
process(CLK,Reset)
	begin
		if Reset = '1' then 
			Dout<='0';
		elsif rising_edge(CLK) then 
			if WE='1' then 
				Dout<=Data;
			end if;
		end if;
	end process;

end Behavioral;

