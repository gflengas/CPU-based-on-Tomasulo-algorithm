library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mask is
    Port ( En : in  STD_LOGIC;
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           Rin : in  STD_LOGIC_VECTOR (31 downto 0);
           DataReg : out  STD_LOGIC_VECTOR (31 downto 0);
           TagReg : out  STD_LOGIC_VECTOR (4 downto 0));
end Mask;

architecture Behavioral of Mask is

begin

	with En select
		DataReg <= Rin when '1',
					  "00000000000000000000000000000000" when others;

	with En select
		TagReg <= Tag when '1',
					 "00000" when others;

end Behavioral;

