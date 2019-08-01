library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicCtr is
    Port ( Clk : in Std_Logic;
			  Rst : in  STD_LOGIC;
			  Ready : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS1Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS2Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS1Vj : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS2Vj : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS1Vk : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS2Vk : in  STD_LOGIC_VECTOR (31 downto 0);
			  Busy : in  STD_LOGIC;
			  Tag : out  STD_LOGIC_VECTOR (4 downto 0);
			  Op : out  STD_LOGIC_VECTOR (1 downto 0);
			  Vj : out  STD_LOGIC_VECTOR (31 downto 0);
			  Vk : out  STD_LOGIC_VECTOR (31 downto 0);
			  En : out STD_LOGIC;
			  RsEx : out  STD_LOGIC_VECTOR (1 downto 0));
           
end LogicCtr;

architecture Behavioral of LogicCtr is

signal Prio,Enb: STD_LOGIC;
signal Ctr,Ex : STD_LOGIC_VECTOR (1 downto 0);

begin
	process(Ready,Rst,Clk)
	begin
		if Rst='1' then
			Prio<='0';
			Ctr<="00";
		else
			if Prio='0' then
				if Ready(0)='1' then
					Prio<='1';
					Ctr<="01";
				elsif Ready(1)='1' then
					Prio<='1';
					Ctr<="10";
				else
					Ctr<="00";
				end if;
			else
				if Ready(1)='1' then
					Prio<='0';
					Ctr<="10";
				elsif Ready(0)='1' then
					Prio<='0';
					Ctr<="01";
				else
					Ctr<="00";
				end if;
			end if;
		end if;
	end process;
	
	Tag <= "000" & Ctr ; 
	
	with Ctr Select	
		Ex <= "01" when "01",
            "10" when "10",
            "00" when others;

	with Ctr Select
		Vj <= RS1Vj when "01",
				RS2Vj when "10",
            "00000000000000000000000000000000" when others;

	with Ctr Select
		Vk <=  RS1Vk when "01",
             RS2Vk when "10",
             "00000000000000000000000000000000" when others;

	with Ctr Select
		Op <= RS1Op when "01",
            RS2Op when "10",
            "00" when others;                  

	Enb <= (Ctr(0) OR Ctr(1)) AND (NOT Busy) ;
	En <= Enb;
	RsEx(0) <= Enb AND Ex(0);
	RsEx(1) <= Enb AND Ex(1);
	
end Behavioral;

