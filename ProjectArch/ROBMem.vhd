library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity ROBMem is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Fu_type : in  STD_LOGIC_VECTOR (1 downto 0);
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Addr : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           GenWE : in  STD_LOGIC;
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBVin : in  STD_LOGIC_VECTOR (31 downto 0);
           Clear : in  STD_LOGIC;
           Exception : in  STD_LOGIC;
           TagOut : out  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Latest : out  STD_LOGIC;
           ExceptionOut : out  STD_LOGIC;
           Ready : out  STD_LOGIC;
           CDBVout : out  STD_LOGIC_VECTOR (31 downto 0);--?
           AddrOut : out  STD_LOGIC_VECTOR (4 downto 0);--?
           Fu_type_out: out  STD_LOGIC_VECTOR (1 downto 0));--?
end ROBMem;

architecture Behavioral of ROBMem is

	component Compare is
    Port ( A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CmpOut : out  STD_LOGIC);
	end component;
	
	component Register1bit is
	Port ( Data : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC);
	end component;
	
	component Register2bits is
	port ( Data : in  STD_LOGIC_VECTOR (1 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	COMPONENT Register5bits is
	Port ( Data : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
	end COMPONENT;
	
	COMPONENT Register32bits IS
		PORT( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
Signal  CDBWE,readyS,TagCmp,AddrCmp,TagWE,Rdy,RdyWE,ExcWE,Lt : std_logic ;
Signal  TagInS,TagOutS,AddrS : STD_LOGIC_VECTOR (4 downto 0);

begin
	FUTreg : Register2bits Port Map(
		Data => Fu_type,
		WE => WE,
		CLK => Clk,
		Reset => Rst,
		Dout => Fu_type_out);
		
	TagReg : Register5bits Port Map(
		Data => TagInS,
		WE => TagWE,
		CLK => Clk,
		Reset => Rst,
		Dout => TagOutS);
	
	InputReg : Register32bits Port Map(
		Data => Input,
		WE => WE,
		CLK => Clk,
		Reset => Rst,
		Dout => Output);
		
	AddrReg : Register5bits Port Map(
		Data => Addr,
		WE => WE,
		CLK => Clk,
		Reset => Rst,
		Dout => AddrS);
	
	CDBVReg : Register32bits Port Map(
		Data => CDBVin,
		WE => CDBWE,
		CLK => Clk,
		Reset => Rst,
		Dout => CDBVout);
	
	ReadyReg : Register1bit Port Map(
		Data => Rdy,
		WE => RdyWE,
		CLK => Clk,
		Reset => Rst,
		Dout => readyS);
		
	ExceptionReg : Register1bit Port Map(
		Data => Exception,
		WE => ExcWE,
		CLK => Clk,
		Reset => Rst,
		Dout => ExceptionOut);
	
	LatestReg : Register1bit Port Map(
		Data => WE,
		WE => Lt,
		CLK => Clk,
		Reset => Rst,
		Dout => Latest);
		
	TagComp : Compare Port Map(
		A1 => CDBQ,
		A2 => TagOutS,
		CmpOut => TagCmp);
		
	AddrComp : Compare Port Map(
		A1 => AddrS,
		A2 => Addr,
		CmpOut => AddrCmp);
		
	--Tag Control
	CDBWE <= TagCmp AND (NOT ReadyS);
	TagWE <= WE OR CDBWE;
	
	with CDBWE select
		TagInS <= Tag when '0',
					 "00000" when others;
	
	--Ready
	Rdy <= Clear NOR WE;
	RdyWE <= WE OR CDBWE OR Clear;
	
	--Exception
	ExcWE <= WE OR Clear;
	
	--Latest
	Lt <= (AddrCmp and GenWE) or WE;
	
	--Outputs
	TagOut <= TagOutS;
	Ready <= ReadyS;
	AddrOut <= AddrS;
	
end Behavioral;

