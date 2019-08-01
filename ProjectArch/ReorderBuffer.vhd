library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ROBArrays.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;
entity ReorderBuffer is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           ReadAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           ReadAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (4 downto 0);
           Fu_type : in  STD_LOGIC_VECTOR (1 downto 0);
           Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Exception : in  STD_LOGIC;
           DataOut1 : out  STD_LOGIC_VECTOR (31 downto 0);
           DataOut2 : out  STD_LOGIC_VECTOR (31 downto 0);
           TagOut1 : out  STD_LOGIC_VECTOR (4 downto 0);
           TagOut2 : out  STD_LOGIC_VECTOR (4 downto 0);
			  Available1 : out  STD_LOGIC;
			  Available2 : out  STD_LOGIC;
           RFaddr : out  STD_LOGIC_VECTOR (4 downto 0);
           RFData : out  STD_LOGIC_VECTOR (31 downto 0);
           RFWE : out  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           ExceptionOut : out  STD_LOGIC);
end ReorderBuffer;

architecture Behavioral of ReorderBuffer is
	
	COMPONENT ROBMem
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Fu_type : IN std_logic_vector(1 downto 0);
		Tag : IN std_logic_vector(4 downto 0);
		Input : IN std_logic_vector(31 downto 0);
		Addr : IN std_logic_vector(4 downto 0);
		WE : IN std_logic;
		GenWE : IN std_logic;
		CDBQ : IN std_logic_vector(4 downto 0);
		CDBVin : IN std_logic_vector(31 downto 0);
		Clear : IN std_logic;
		Exception : IN std_logic;          
		TagOut : OUT std_logic_vector(4 downto 0);
		Output : OUT std_logic_vector(31 downto 0);
		Latest : OUT std_logic;
		ExceptionOut : OUT std_logic;
		Ready : OUT std_logic;
		CDBVout : OUT std_logic_vector(31 downto 0);
		AddrOut : OUT std_logic_vector(4 downto 0);
		Fu_type_out : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ROBRead
	PORT(
		ReadAddr : IN std_logic_vector(4 downto 0);
		Latest : IN std_logic_vector(15 downto 0);
		Input : in Array16x32;
      Catalog : in  Array16x5;
      TagsIn : in  Array16x5;          
		Available : OUT std_logic;
		ReadOut : OUT std_logic_vector(31 downto 0);
		TagOut : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Demux1x16
	PORT(
		Input : IN std_logic;
		Ctr : IN std_logic_vector(3 downto 0);
		Output : OUT std_logic_vector(15 downto 0)       
		);
	END COMPONENT;
	
	COMPONENT CounterWithLoad
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Input : IN std_logic_vector(3 downto 0);
		Load : IN std_logic;
		En : IN std_logic;          
		Output : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SimpleCm
	PORT(
		A1 : IN std_logic_vector(4 downto 0);
		A2 : IN std_logic_vector(4 downto 0);          
		CmpOut : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Mux16x2
	PORT(
		i : IN Array16x2;
		S : IN std_logic_vector(3 downto 0);          
		Dout : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux16x32
	PORT(
		i : IN Array16x32;
		S : IN std_logic_vector(3 downto 0);          
		Dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux16x5
	PORT(
		i : IN Array16x5;
		S : IN std_logic_vector(3 downto 0);          
		Dout : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux16
	PORT(
		i : IN std_logic_vector(15 downto 0);
		S : IN std_logic_vector(3 downto 0);          
		Dout : OUT std_logic
		);
	END COMPONENT;

	signal HeadEn,TailEn,empty,full,IsReady,Excep : std_logic;
	signal HeadOut,TailOut : std_logic_vector(3 downto 0);
	signal Fu_type_out : STD_LOGIC_VECTOR(1 downto 0);
	signal cmpHead,cmpTailE,cmpTailF,TagOut : STD_LOGIC_VECTOR(4 downto 0);
	signal WEPick,ClearPick,Clear,LatestS,ReadyS,ExceptionOutS : std_logic_vector(15 downto 0);
	signal Fu_type_outS : Array16x2;
	signal TagOutS,CatalogS : Array16x5;
	signal OutputS,CDBVoutS : Array16x32;
begin
	
	ROBMemsGenerator:
	for i in 0 to 15 generate
		Clear(i) <= ClearPick(i) OR Excep;
		Memory: ROBMem PORT MAP(
			Clk => Clk,
			Rst => Rst,
			Fu_type => Fu_type,
			Tag => Tag,
			Input => Input,
			Addr => Addr,
			WE => WEPick(i),
			GenWE => WE,
			CDBQ => CDBQ,
			CDBVin => CDBV,
			Clear => Clear(i),
			Exception => Exception,
			TagOut => TagOutS(i),
			Output => OutputS(i),
			Latest => LatestS(i),
			ExceptionOut => ExceptionOutS(i),
			Ready => ReadyS(i),
			CDBVout => CDBVoutS(i),
			AddrOut => CatalogS(i),
			Fu_type_out => Fu_type_outS(i)
		);
	end generate;
	
	Reader1: ROBRead PORT MAP(
		ReadAddr => ReadAddr1,
		Latest => LatestS,
		Input => CDBVoutS,
		Catalog => CatalogS,
		TagsIn => TagOutS,
		Available => Available1,
		ReadOut => DataOut1,
		TagOut => TagOut1
	);
	
	Reader2: ROBRead PORT MAP(
		ReadAddr => ReadAddr2,
		Latest => LatestS,
		Input => CDBVoutS,
		Catalog => CatalogS,
		TagsIn => TagOutS,
		Available => Available2,
		ReadOut => DataOut2,
		TagOut => TagOut2
	);
	
	Head: CounterWithLoad PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Input => "0000",
		Load => '0',
		En => HeadEn,
		Output => HeadOut
	);
	
	Tail: CounterWithLoad PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Input => HeadOut,
		Load => Excep,
		En => TailEn,
		Output => TailOut 
	);
	
	cmpHead <= '0'&HeadOut;
	cmpTailE <= '0'&TailOut;
	
	EmptyCm: SimpleCm PORT MAP(
		A1 => cmpHead,
		A2 => cmpTailE,
		CmpOut => empty
	);
	
	cmpTailF <= '0'&(TailOut+1);
	FullCm: SimpleCm PORT MAP(
		A1 => cmpHead,
		A2 => cmpTailF,
		CmpOut => Full
	);
	
	WEPicker: Demux1x16 PORT MAP(
		Input => WE,
		Ctr => TailOut,
		Output => WEPick
	);
	
	ClearPicker: Demux1x16 PORT MAP(
		Input => HeadEn,
		Ctr => HeadOut,
		Output => ClearPick
	);
	
	TagOutSel: Mux16x5 PORT MAP(
		i => TagOutS,
		S => HeadOut,
		Dout => TagOut
	);
	
	CatalogSel: Mux16x5 PORT MAP(
		i => CatalogS,
		S => HeadOut,
		Dout => RFaddr
	);

	OutputSel: Mux16x32 PORT MAP(
		i => OutputS,
		S => HeadOut,
		Dout => Output
	);
	
	CDBVoutSel: Mux16x32 PORT MAP(
		i => CDBVoutS,
		S => HeadOut,
		Dout => RFData
	);
	
	Fu_type_outSel: Mux16x2 PORT MAP(
		i => Fu_type_outS,
		S => HeadOut,
		Dout => Fu_type_out
	);
	
	ReadySel: Mux16 PORT MAP(
		i => ReadyS,
		S => HeadOut,
		Dout => IsReady
	);
	
	ExceptionOutSel: Mux16 PORT MAP(
		i => ExceptionOutS,
		S => HeadOut,
		Dout => Excep
	);

	--Counters Enable
	HeadEn <= (NOT empty) AND (NOT Excep) AND (IsReady);
	TailEn <= WE AND (NOT full);
	
	--Outputs
	ExceptionOut <= Excep;
	RFWE <= HeadEn;
end Behavioral;

