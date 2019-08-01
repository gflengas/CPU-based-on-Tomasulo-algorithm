library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register32bits is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Register32bits;

architecture Behavioral of Register32bits is

begin
	process(CLK,Reset)
	begin
		if Reset = '1' then 
			Dout<="00000000000000000000000000000000";
		elsif rising_edge(CLK) then 
			if WE='1' then 
				Dout<=Data;
			end if;
		end if;
	end process;	
end Behavioral;