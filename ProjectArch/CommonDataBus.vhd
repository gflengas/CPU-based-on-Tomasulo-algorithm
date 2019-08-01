library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CommonDataBus is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           QArithm : in  STD_LOGIC_VECTOR (4 downto 0);
           VArithm : in  STD_LOGIC_VECTOR (31 downto 0);
           QLogic : in  STD_LOGIC_VECTOR (4 downto 0);
           VLogic : in  STD_LOGIC_VECTOR (31 downto 0);
			  QBuf : in  STD_LOGIC_VECTOR (4 downto 0);
           VBuf : in  STD_LOGIC_VECTOR (31 downto 0);
           ArithmReq : in  STD_LOGIC;
           LogicReq : in  STD_LOGIC;
			  BufReq : in  STD_LOGIC;
           QOut : out  STD_LOGIC_VECTOR (4 downto 0);
           VOut : out  STD_LOGIC_VECTOR (31 downto 0);
           GrantArithm : out  STD_LOGIC;
           GrantLogic : out  STD_LOGIC;
			  GrantBuf : out STD_LOGIC);
end CommonDataBus;

architecture Behavioral of CommonDataBus is
	Signal prio, currentS, nextS: std_logic_vector(1 downto 0);
begin
process(Clk, Rst)
	begin
			
		if rising_edge(clk) then
			if Rst='1' then
			prio<="00";
			GrantArithm<='0';
			GrantLogic<='0';
			GrantBuf<='0';
   		nextS<="00";
			
			elsif prio="00" then
				if ArithmReq='1' then
					GrantArithm<='1';
					GrantLogic<='0';
					GrantBuf<='0';
					prio<="01";
					nextS<="01";
					
				elsif LogicReq='1' then
					GrantArithm<='0';
					GrantLogic<='1';
					GrantBuf<='0';
					prio<="01";
					nextS<="10";
					
				elsif BufReq='1' then
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='1';
					prio<="01";
					nextS<="11";
					
				else
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='0';
					nextS<="00";

				end if;
				
			elsif prio="01" then
				if LogicReq='1' then
					GrantArithm<='0';
					GrantLogic<='1';
					GrantBuf<='0';
					prio<="10";
					nextS<="10";
				
				elsif BufReq='1' then
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='1';
					prio<="10";
					nextS<="11";
					
				elsif ArithmReq='1' then
					GrantArithm<='1';
					GrantLogic<='0';
					GrantBuf<='0';
					prio<="10";	
					nextS<="01";
					
				else
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='0';
					nextS<="00";
					
				end if;
				
			else
				if BufReq='1' then 
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='1';
					prio<="00";
					nextS<="11";
				
				elsif ArithmReq='1' then
					GrantArithm<='1';
					GrantLogic<='0';
					GrantBuf<='0';
					prio<="00";	
					nextS<="01";
				
				elsif LogicReq='1' then
					GrantArithm<='0';
					GrantLogic<='1';
					GrantBuf<='0';
					prio<="10";
					nextS<="10";
					
				else
					GrantArithm<='0';
					GrantLogic<='0';
					GrantBuf<='0';
					nextS<="00";

				end if;
			end if;
		end if;
	end process;
	
	with currentS select
		QOut <= QArithm when "01",
				  QLogic when "10",
				  QBuf when "11",
				  "00000" when others;
	
	with currentS select
		VOut <= VArithm when "01",
				  VLogic when "10",
				  VBuf when "11",
				  "00000000000000000000000000000000" when others;

	process(Clk, Rst,currentS,nextS)
	begin
		if Rst='1' then
			currentS<="00";
		elsif rising_edge(Clk) then
			currentS<=nextS;
		end if;
	end process;

end Behavioral;

