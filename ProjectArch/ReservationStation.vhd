library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;--

entity ReservationStation is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  ID : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Qj : in  STD_LOGIC_VECTOR (4 downto 0);
           Qk : in  STD_LOGIC_VECTOR (4 downto 0);
           Ex : in  STD_LOGIC;
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           OpOut : out  STD_LOGIC_VECTOR (1 downto 0);
           VjOut : out  STD_LOGIC_VECTOR (31 downto 0);
           VkOut : out  STD_LOGIC_VECTOR (31 downto 0);
           ReadyOut : out  STD_LOGIC;
           BusyOut : out  STD_LOGIC);
end ReservationStation;

architecture Behavioral of ReservationStation is
	
	component Compare is
    Port ( A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CmpOut : out  STD_LOGIC);
	end component;
	
	component Comparetozero is
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
	
	component Register5bits is
	port ( Data : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component Register32bits is
	port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	SIGNAL QjIn,QkIn,Qjmid,Qkmid : STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL VjIn,VkIn : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL QjR,QkR,VjWE,VkWE,QjWE,QkWE,CP0,CP1,CP2,CP3,CP4,CP5,CDBjCtr,CDBkCtr,BusyRegIn,BusyRegWE,MidBusyOut,BusyRst,rOut,rWE : STD_LOGIC;
	
begin
	BusyReg : Register1bit Port Map(
		Data=>BusyRegIn,
		WE=>BusyRegWE,
		CLK=>Clk,
		Reset=>BusyRst,
		Dout=>MidBusyOut);
		
	ReadyReg : Register1bit Port Map(
		Data=>WE,
		WE=>rWE,
		CLK=>Clk,
		Reset=>Rst,
		Dout=>rOut);
		
	VjREG : Register32bits Port Map(
		Data =>VjIn,
      WE =>VjWE,
      Clk =>Clk,
		Reset =>Rst,
      Dout =>VjOut);
			
	VkREG : Register32bits Port Map(
      Data =>VkIn,
      WE =>VkWE,
      Clk =>Clk,
		Reset =>Rst,
      Dout =>VkOut);
	
	QjReg : Register5bits Port Map(
		Data=>QjIn,
		WE=>QjWE,
		CLK=>Clk,
		Reset=>Rst,
		Dout=>Qjmid);
	
	QkReg : Register5bits Port Map(
		Data=>QkIn,
		WE=>QkWE,
		CLK=>Clk,
		Reset=>Rst,
		Dout=>Qkmid);	
	
	OpReg : Register2bits Port Map(
		Data=>Op,
		WE=>WE,
		CLK=>Clk,
		Reset=>Rst,
		Dout=>OpOut);
		
	Comp0 : Compare Port Map(
		A1=>CDBQ,
		A2=>Qjmid,
		CmpOut=>CP0);
		
	Comp1 : Compare Port Map(
		A1=>CDBQ,
		A2=>Qkmid,
		CmpOut=>CP1);
	
	Comp2 : Comparetozero Port Map(
		A1=>CDBQ,
		A2=>"00000",
		CmpOut=>CP2);
		
	Comp3 : Compare Port Map(
		A1=>CDBQ,
		A2=>Qj,
		CmpOut=>CP3);
		
	Comp4 : Compare Port Map(
		A1=>CDBQ,
		A2=>Qk,
		CmpOut=>CP4);
	
	Comp5 : Compare Port Map(
		A1=>CDBQ,
		A2=>ID,
		CmpOut=>CP5);
	
		
	VjWE <= WE OR (CP0 AND (NOT CP2)) ;
	VkWE <= WE OR (CP1 AND (NOT CP2)) ;
	QjWE <= WE OR (CP0 AND (NOT CP2)) ;
	QkWE <= WE OR (CP1 AND (NOT CP2)) ;
		
	BusyRst <= Rst OR CP5 ;  
	BusyRegWE <= WE ; 
	BusyRegIn <= WE;   
	BusyOut <= MidBusyOut;
	
	with Qjmid select
		QjR <= '1' when "00000",
				 '0' when others ;

	with Qkmid select
		QkR <= '1' when "00000",
				 '0' when others ;

	ReadyOut <= (QjR and QkR) AND rOut ;

	rWE <= WE OR Ex ;

	CDBjCtr <= (CP3 AND WE) OR CP0 ;
	CDBkCtr <= (CP4 AND WE) OR CP1 ;
	
	with CDBjCtr select
		VjIn <= Vj when '0',
				  CDBV when others;
				  
	with CDBjCtr select
		QjIn <= Qj when '0',
				  "00000" when others;
				  
	with CDBkCtr select
		VkIn <= Vk when '0',
				  CDBV when others;
	
	with CDBkCtr select
		QkIn <= Qk when '0',
				  "00000" when others;
	
	
end Behavioral;

