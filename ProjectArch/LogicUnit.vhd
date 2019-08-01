library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; --biblio8ikes gia grhgoroterh ektelesh pra3ewn
use ieee.NUMERIC_STD.all;

entity LogicUnit is
    Port ( Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           LUOut : out  STD_LOGIC_VECTOR (31 downto 0));
end LogicUnit;

architecture Behavioral of LogicUnit is

begin
process(Vj,Vk,Op)
	Begin
	case(Op) is 
		when "00" =>
			LUOut <= Vj OR Vk;
		
		when "01" =>
			LUOut <= Vj AND Vk;
		
		when "10" =>
			LUOut <= NOT Vj;
			
		when others => 
			LUOut<= "00000000000000000000000000000000";
	
	end case;
end process;		

end Behavioral;

