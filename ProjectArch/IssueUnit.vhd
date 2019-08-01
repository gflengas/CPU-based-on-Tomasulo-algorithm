library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity IssueUnit is
	Port ( Clk: in STD_LOGIC;
			 Rst: in STD_LOGIC;
			 IssueIn : in STD_LOGIC;
			 FUType : in STD_LOGIC_VECTOR (1 downto 0);
			 Fop : in STD_LOGIC_VECTOR (1 downto 0);
			 Ri : in STD_LOGIC_VECTOR (4 downto 0);
			 Rj : in STD_LOGIC_VECTOR (4 downto 0);
			 Rk : in STD_LOGIC_VECTOR (4 downto 0);
			 RFTag: out STD_LOGIC_VECTOR (4 downto 0);
			 RFAddrW: out STD_LOGIC_VECTOR (4 downto 0);
			 RFWrEn: out STD_LOGIC;
			 Accepted : out STD_LOGIC;
			 ArithmAvailable : in STD_LOGIC_VECTOR (2 downto 0);
			 ArithmIssue : out STD_LOGIC;
			 LogicAvailable : in STD_LOGIC_VECTOR (2 downto 0);
			 LogicIssue : out STD_LOGIC;
			 BufAvailable : in STD_LOGIC_VECTOR (2 downto 0);
			 BufIssue : out STD_LOGIC);   
end IssueUnit;

architecture Behavioral of IssueUnit is

begin

	process(Clk, IssueIn, FUType, Rst, Fop, Ri, Rj, Rk, ArithmAvailable, LogicAvailable,BufAvailable)
	begin
		if Rst='1' then
			ArithmIssue<='0';
         LogicIssue<='0';
			BufIssue<='0';
         RFTag<="00000";
         RFAddrW<="00000";
         RFWrEn<='0';
         Accepted<='0';

       else
			if IssueIn='1' and FUType="00" and LogicAvailable/="000" then 
				LogicIssue<='1' ;
            ArithmIssue<='0';
            BufIssue<='0';
				RFTag<=FUType & LogicAvailable;
            RFAddrW<=Ri;
            RFWrEn<='1';
            Accepted<='1';
			elsif IssueIn='1' and FUType="01" and ArithmAvailable/="000" then 
            LogicIssue<='0';
            ArithmIssue<='1';
				BufIssue<='0';
            RFTag<=FUType & ArithmAvailable;
            RFAddrW<=Ri;
            RFWrEn<='1';
            Accepted<='1';
			elsif IssueIn='1' and FUType="10" then 
            LogicIssue<='0';
            ArithmIssue<='1';
				BufIssue<='1';
            RFTag<=FUType & BufAvailable;
            RFAddrW<=Ri;
            RFWrEn<='1';
            Accepted<='1';
         else
            ArithmIssue<='0';
            LogicIssue<='0';
				BufIssue<='0';
            RFTag<="00000";
            RFAddrW<="00000";
            RFWrEn<='0';
            Accepted<='0';
			end if;
		end if;
	end process;
end Behavioral;