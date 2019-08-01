library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopModule is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Issue : in  STD_LOGIC;
           Fu_type : in  STD_LOGIC_VECTOR (1 downto 0);
           Fop : in  STD_LOGIC_VECTOR (1 downto 0);
           Ri : in  STD_LOGIC_VECTOR (4 downto 0);
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			  Exception : in STD_LOGIC;
			  PCIn : in STD_LOGIC_VECTOR (31 downto 0);
			  QBuf : in  STD_LOGIC_VECTOR (4 downto 0);
           VBuf : in  STD_LOGIC_VECTOR (31 downto 0);
			  BufReq : in  STD_LOGIC;
			  BufAvailable : in STD_LOGIC_VECTOR (2 downto 0);
			  ExceptionOut : out STD_LOGIC;
			  PCOut : out STD_LOGIC_VECTOR (31 downto 0 );
           Accepted : out  STD_LOGIC);
end TopModule;

architecture Behavioral of TopModule is
component IssueUnit is
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
end component;

Component CommonDataBus is
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
end Component;

COMPONENT ReorderBuffer
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		ReadAddr1 : IN std_logic_vector(4 downto 0);
		ReadAddr2 : IN std_logic_vector(4 downto 0);
		CDBQ : IN std_logic_vector(4 downto 0);
		CDBV : IN std_logic_vector(31 downto 0);
		Tag : IN std_logic_vector(4 downto 0);
		WE : IN std_logic;
		Addr : IN std_logic_vector(4 downto 0);
		Fu_type : IN std_logic_vector(1 downto 0);
		Input : IN std_logic_vector(31 downto 0);
		Exception : IN std_logic;          
		DataOut1 : OUT std_logic_vector(31 downto 0);
		DataOut2 : OUT std_logic_vector(31 downto 0);
		TagOut1 : OUT std_logic_vector(4 downto 0);
		TagOut2 : OUT std_logic_vector(4 downto 0);
		Available1 : OUT std_logic;
		Available2 : OUT std_logic;
		RFaddr : OUT std_logic_vector(4 downto 0);
		RFData : OUT std_logic_vector(31 downto 0);
		RFWE : OUT std_logic;
		Output : OUT std_logic_vector(31 downto 0);
		ExceptionOut : OUT std_logic
		);
	END COMPONENT;

COMPONENT RegisterFile
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		ReadAddr1 : IN std_logic_vector(4 downto 0);
		ReadAddr2 : IN std_logic_vector(4 downto 0);
		CDBV : IN std_logic_vector(31 downto 0);
		WE : IN std_logic;
		WrAddr : IN std_logic_vector(4 downto 0);          
		DataOut1 : OUT std_logic_vector(31 downto 0);
		DataOut2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

component Arithm is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Issue : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Qj : in  STD_LOGIC_VECTOR (4 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Qk : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           Grant : in  STD_LOGIC;
           Available : out  STD_LOGIC_VECTOR (2 downto 0);
           VOut : out  STD_LOGIC_VECTOR (31 downto 0);
           QOut : out  STD_LOGIC_VECTOR (4 downto 0);
           Request : out  STD_LOGIC);
end component;

component Logic is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Issue : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Qj : in  STD_LOGIC_VECTOR (4 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Qk : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           Grant : in  STD_LOGIC;
           Available : out  STD_LOGIC_VECTOR (2 downto 0);
           VOut : out  STD_LOGIC_VECTOR (31 downto 0);
           QOut : out  STD_LOGIC_VECTOR (4 downto 0);
           Request : out  STD_LOGIC);
end component;


Signal RFWrEnS,ArithmIssueS,LogicIssueS,ArithmReqS,LogicReqS,GrantArithmS,GrantLogicS,
ROBRFWE,ROBAvailable1,ROBAvailable2,BufIssueS,GrantBufS : std_logic ;
--Signal  : STD_LOGIC_VECTOR (1 downto 0);
Signal ArithmAvailableS,LogicAvailableS : STD_LOGIC_VECTOR (2 downto 0);
Signal RFTagS,RFAddrWS,QArithmS,QLogicS,QOutS,Q1,QjS,QkS,ROBRFaddr, ROBTagOut1, ROBTagOut2 : STD_LOGIC_VECTOR (4 downto 0);
Signal VArithmS,VLogicS,VOutS,VkS,VjS,V1,ROBRFData,
ROBDataOut1,ROBDataOut2,RFDataOut1,RFDataOut2 : STD_LOGIC_VECTOR (31 downto 0);

begin
	IU : IssueUnit port map(
		Clk => Clk,
	   Rst => Rst,
		IssueIn => Issue,
		FUType => Fu_type,
   	Fop => Fop,
		Ri => Ri,
		Rj => Rj,
		Rk => Rk,
		RFTag => RFTagS,
		RFAddrW => RFAddrWS,
		RFWrEn => RFWrEnS,
	   Accepted => Accepted,
	   ArithmAvailable => ArithmAvailableS, 
		ArithmIssue => ArithmIssueS,
		LogicAvailable => LogicAvailableS,
		LogicIssue => LogicIssueS,
		BufAvailable => BufAvailable,
		BufIssue => BufIssueS);
		
	CDB : CommonDataBus port map( 
		Clk => Clk,
      Rst => Rst,
      QArithm => QArithmS, 
      VArithm => VArithmS,
      QLogic => QLogicS,
      VLogic => VLogicS,
      QBuf => QBuf,
      VBuf => VBuf,
	   ArithmReq => ArithmReqS,
	   LogicReq => LogicReqS,
		BufReq => BufReq,
	   QOut => QOutS,
	   VOut => VOutS,
	   GrantArithm => GrantArithmS,
	   GrantLogic => GrantLogicS,
		GrantBuf => GrantBufS);
		
	Ar : Arithm port map( 
		  Clk => Clk,
		  Rst => Rst,
		  Issue => ArithmIssueS,
		  Op => Fop,
		  Vj => VjS,
		  Qj => QjS,
		  Vk => VkS,
		  Qk => QkS,
		  CDBV => VOutS,
		  CDBQ => QOutS,
		  Grant => GrantArithmS,
		  Available => ArithmAvailableS,
		  VOut => VArithmS,
		  QOut => QArithmS,
		  Request => ArithmReqS);
		  
	Lg : Logic port map(
		  Clk => Clk,
		  Rst => Rst,
		  Issue => LogicIssueS,
		  Op => Fop,
		  Vj => VjS,
		  Qj => QjS,
		  Vk => VkS,
		  Qk => QkS,
		  CDBV => VOutS,
		  CDBQ => QOutS,
		  Grant => GrantLogicS,
		  Available => LogicAvailableS,
		  VOut => VLogicS,
		  QOut => QLogicS,
		  Request => LogicReqS);
		  
	  
	Rf: RegisterFile PORT MAP(
		Clk => Clk,
		Rst => Rst,
		ReadAddr1 => Rj,
		ReadAddr2 => Rk,
		CDBV => ROBRFData,
		WE => ROBRFWE,
		WrAddr => ROBRFaddr,
		DataOut1 => RFDataOut1,
		DataOut2 => RFDataOut2
	);
	  
	 ROB: ReorderBuffer PORT MAP(
		Clk => Clk,
		Rst => Rst,
		ReadAddr1 => Rj,
		ReadAddr2 => Rk,
		CDBQ => QOutS,
		CDBV => VOutS,
		Tag => RFTagS,
		WE => RFWrEnS,
		Addr => RFAddrWS,
		Fu_type => Fu_type,
		Input => PCIn,
		Exception => Exception,
		DataOut1 => ROBDataOut1,
		DataOut2 => ROBDataOut2,
		TagOut1 => ROBTagOut1,
		TagOut2 => ROBTagOut2,
		Available1 => ROBAvailable1,
		Available2 => ROBAvailable2,
		RFaddr => ROBRFaddr,
		RFData => ROBRFData,
		RFWE => ROBRFWE,
		Output => PCOut,
		ExceptionOut => ExceptionOut
	);
	
	VjS <= ROBDataOut1 when ROBAvailable1='1' else RFDataOut1 ;
	QjS <= ROBTagOut1 when ROBAvailable1='1' else "00000" ;
	
	VkS <= ROBDataOut2 when ROBAvailable2='1' else RFDataOut2 ;
	QkS <= ROBTagOut2 when ROBAvailable2='1' else "00000" ;

end Behavioral;

