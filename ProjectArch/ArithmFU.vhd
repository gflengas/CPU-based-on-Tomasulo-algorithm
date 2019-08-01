library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ArithmFU is
	Port ( Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           En : in  STD_LOGIC;
           Grant : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           ReqOut : out  STD_LOGIC;
           BusyOut : out  STD_LOGIC;
           ResOut : out  STD_LOGIC_VECTOR (31 downto 0);
           TagOut : out  STD_LOGIC_VECTOR (4 downto 0));
end ArithmFU;

architecture Behavioral of ArithmFU is
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
	
	component ArithmUnit is
    Port ( Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           LUOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Mask is
    Port ( En : in  STD_LOGIC;
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           Rin : in  STD_LOGIC_VECTOR (31 downto 0);
           DataReg : out  STD_LOGIC_VECTOR (31 downto 0);
           TagReg : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;

	signal LUOutp,DReg1,DReg2,DReg3 : STD_LOGIC_VECTOR (31 downto 0);
	signal TReg1,TReg2,TReg3 : STD_LOGIC_VECTOR (4 downto 0);
	signal WE1,WE2,WE3,Nop1,Nop2 : STD_LOGIC;
begin
	AU : ArithmUnit Port Map (
		Vj =>Vj,
      Vk =>Vk,
      Op =>Op,
      LUOut =>LUOutp);
		
	MAS : Mask Port Map ( 
		En =>En,
		Tag =>Tag,
		Rin =>LUOutp,
		DataReg =>DReg1,
		TagReg =>TReg1);

	Data1 : Register32bits Port Map(
      Data =>DReg1,
      WE =>WE1,
      Clk =>Clk,
		Reset =>Rst,
      Dout =>DReg2);
	
	Tag1 : Register5bits Port Map(
		Data =>TReg1,
		WE =>WE1,
		CLK =>Clk,
		Reset =>Rst,
		Dout =>TReg2);
		
	Data2 : Register32bits Port Map(
      Data =>DReg2,
      WE =>WE2,
      Clk =>Clk,
		Reset =>Rst,
      Dout =>DReg3);
	
	Tag2 : Register5bits Port Map(
		Data =>TReg2,
		WE =>WE2,
		CLK =>Clk,
		Reset =>Rst,
		Dout =>TReg3);
		
	Data3 : Register32bits Port Map(
      Data =>DReg3,
      WE =>WE3,
      Clk =>Clk,
		Reset =>Rst,
      Dout =>ResOut);
	
	Tag3 : Register5bits Port Map(
		Data =>TReg3,
		WE =>WE3,
		CLK =>Clk,
		Reset =>Rst,
		Dout =>TagOut);
		
	with TReg2 select
		Nop1 <= '1' when "00000",
				 '0' when others;
				 
	with TReg3 select
		Nop2 <= '1' when "00000",
				 '0' when others;
	
	WE1 <= Grant OR Nop1 OR Nop2 ;
	WE2 <= Grant OR Nop2;
	WE3 <= Grant ;
	ReqOut <= NOT Nop2 ;
	BusyOut <= (Nop1 NOR Nop2) AND (NOT Grant);

end Behavioral;

