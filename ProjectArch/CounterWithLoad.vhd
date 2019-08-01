library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity CounterWithLoad is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Input : in  STD_LOGIC_VECTOR (3 downto 0);
           Load : in  STD_LOGIC;
           En : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (3 downto 0));
end CounterWithLoad;

architecture Behavioral of CounterWithLoad is
	 signal count :std_logic_vector (3 downto 0);
begin
	process(Clk,Rst)
	Begin
		if Rst = '1' then
			count <= "0000";
		elsif(rising_edge(Clk)) then
			if Load = '1' then
				count <= Input;
			else 
				if En = '1' then
					count <= count + 1;
				end if;
			end if;
		end if;
	end process;
	Output <= count;

end Behavioral;

