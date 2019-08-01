library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31  downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
			  Rst: in STD_LOGIC;
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is
	
	COMPONENT Decoder5to32 IS
		PORT(Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           DecOut : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
		
	COMPONENT Register32bits IS
		PORT( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Reset: in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	COMPONENT Mux32x5 IS 
		PORT(i0 : in  STD_LOGIC_VECTOR (31 downto 0);
           i1 : in  STD_LOGIC_VECTOR (31 downto 0);
           i2 : in  STD_LOGIC_VECTOR (31 downto 0);
           i3 : in  STD_LOGIC_VECTOR (31 downto 0);
           i4 : in  STD_LOGIC_VECTOR (31 downto 0);
           i5 : in  STD_LOGIC_VECTOR (31 downto 0);
           i6 : in  STD_LOGIC_VECTOR (31 downto 0);
           i7 : in  STD_LOGIC_VECTOR (31 downto 0);
           i8 : in  STD_LOGIC_VECTOR (31 downto 0);
           i9 : in  STD_LOGIC_VECTOR (31 downto 0);
           i10 : in  STD_LOGIC_VECTOR (31 downto 0);
           i11 : in  STD_LOGIC_VECTOR (31 downto 0);
           i12 : in  STD_LOGIC_VECTOR (31 downto 0);
           i13 : in  STD_LOGIC_VECTOR (31 downto 0);
           i14 : in  STD_LOGIC_VECTOR (31 downto 0);
           i15 : in  STD_LOGIC_VECTOR (31 downto 0);
           i16 : in  STD_LOGIC_VECTOR (31 downto 0);
           i17 : in  STD_LOGIC_VECTOR (31 downto 0);
           i18 : in  STD_LOGIC_VECTOR (31 downto 0);
           i19 : in  STD_LOGIC_VECTOR (31 downto 0);
           i20 : in  STD_LOGIC_VECTOR (31 downto 0);
           i21 : in  STD_LOGIC_VECTOR (31 downto 0);
           i22 : in  STD_LOGIC_VECTOR (31 downto 0);
           i23 : in  STD_LOGIC_VECTOR (31 downto 0);
           i24 : in  STD_LOGIC_VECTOR (31 downto 0);
           i25 : in  STD_LOGIC_VECTOR (31 downto 0);
           i26 : in  STD_LOGIC_VECTOR (31 downto 0);
           i27 : in  STD_LOGIC_VECTOR (31 downto 0);
           i28 : in  STD_LOGIC_VECTOR (31 downto 0);
           i29 : in  STD_LOGIC_VECTOR (31 downto 0);
           i30 : in  STD_LOGIC_VECTOR (31 downto 0);
           i31 : in  STD_LOGIC_VECTOR (31 downto 0);
           S : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
		END COMPONENT ;
		
		COMPONENT Mux2x1 IS
			PORT(A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           X : out  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC);
		END COMPONENT;
		
		COMPONENT Compare IS 
			PORT(A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
			  En: in STD_LOGIC;
           CmpOut : out  STD_LOGIC);
		END COMPONENT;
		
		SIGNAL C1,C2:STD_LOGIC;
		SIGNAL DO,inm0,inm1,inm2,inm3,inm4,inm5,inm6,inm7,inm8,inm9,inm10,inm11,inm12,inm13,inm14,inm15,inm16,inm17,inm18,inm19,
		inm20,inm21,inm22,inm23,inm24,inm25,inm26,inm27,inm28,inm29,inm30,inm31,Dout01,Dout02:STD_LOGIC_VECTOR (31 downto 0);
		SIGNAL Reg:STD_LOGIC_VECTOR (30 downto 0);
begin
	
	dc: decoder5to32 
	port map(
		Awr=> Awr,
		DecOut=>DO
	);
		
	Reg(0)<= DO(1) AND WrEn;
	Reg(1)<= DO(2) AND WrEn;
	Reg(2)<= DO(3) AND WrEn;
	Reg(3)<= DO(4) AND WrEn;
	Reg(4)<= DO(5) AND WrEn;
	Reg(5)<= DO(6) AND WrEn;
	Reg(6)<= DO(7) AND WrEn;
	Reg(7)<= DO(8) AND WrEn;
	Reg(8)<= DO(9) AND WrEn;
	Reg(9)<= DO(10) AND WrEn;
	Reg(10)<= DO(11) AND WrEn;
	Reg(11)<= DO(12) AND WrEn;
	Reg(12)<= DO(13) AND WrEn;
	Reg(13)<= DO(14) AND WrEn;
	Reg(14)<= DO(15) AND WrEn;
	Reg(15)<= DO(16) AND WrEn;
	Reg(16)<= DO(17) AND WrEn;
	Reg(17)<= DO(18) AND WrEn;
	Reg(18)<= DO(19) AND WrEn;
	Reg(19)<= DO(20) AND WrEn;
	Reg(20)<= DO(21) AND WrEn;
	Reg(21)<= DO(22) AND WrEn;
	Reg(22)<= DO(23) AND WrEn;
	Reg(23)<= DO(24) AND WrEn;
	Reg(24)<= DO(25) AND WrEn;
	Reg(25)<= DO(26) AND WrEn;
	Reg(26)<= DO(27) AND WrEn;
	Reg(27)<= DO(28) AND WrEn;
	Reg(28)<= DO(29) AND WrEn;
	Reg(29)<= DO(30) AND WrEn;
	Reg(30)<= DO(31) AND WrEn;
	
	re0:Register32bits
	port map(
		Data=>"00000000000000000000000000000000",
		WE=>'0',
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm0
	);
	
	re1:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(0),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm1
	);
	
	re2:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(1),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm2
	);
	
	re3:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(2),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm3
	);
	
	re4:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(3),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm4
	);
	
	re5:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(4),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm5
	);
	
	re6:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(5),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm6
	);
	
	re7:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(6),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm7
	);
	
	re8:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(7),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm8
	);
	
	re9:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(8),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm9
	);
	
	re10:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(9),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm10
	);
	
	re11:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(10),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm11
	);
	
	re12:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(11),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm12
	);
	
	re13:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(12),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm13
	);
	
	re14:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(13),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm14
	);
	
	re15:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(14),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm15
	);
	
	re16:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(15),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm16
	);
	
	re17:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(16),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm17
	);
	
	re18:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(17),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm18
	);
	
	re19:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(18),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm19
	);
	
	re20:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(19),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm20
	);
	
	re21:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(20),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm21
	);
	
	re22:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(21),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm22
	);
	
	re23:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(22),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm23
	);
	
	re24:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(23),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm24
	);
	
	re25:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(24),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm25
	);
	
	re26:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(25),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm26
	);
	
	re27:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(26),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm27
	);
	
	re28:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(27),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm28
	);
	
	re29:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(28),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm29
	);
	
	re30:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(29),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm30
	);
	
	re31:Register32bits
	port map(
		Data=>Din,
		WE=>Reg(30),
		CLK=>clk,
		Reset=>Rst,
		Dout=>inm31
	);
	
	cm1:Compare
	port map(
		A1=>Awr,
		A2=>Ard1,
		En=>WrEn,
		CmpOut=>C1
	);
	
	cm2:Compare
	port map(
		A1=>Ard2,
		A2=>Awr,
		En=>WrEn,
		CmpOut=>C2
	);
	
	BM1:Mux32x5
	port map(
			i0 => "00000000000000000000000000000000",
          i1 => inm1,
          i2 => inm2,
          i3 => inm3,
          i4 => inm4,
          i5 => inm5,
          i6 => inm6,
          i7 => inm7,
          i8 => inm8,
          i9 => inm9,
          i10 => inm10,
          i11 => inm11,
          i12 => inm12,
          i13 => inm13,
          i14 => inm14,
          i15 => inm15,
          i16 => inm16,
          i17 => inm17,
          i18 => inm18,
          i19 => inm19,
          i20 => inm20,
          i21 => inm21,
          i22 => inm22,
          i23 => inm23,
          i24 => inm24,
          i25 => inm25,
          i26 => inm26,
          i27 => inm27,
          i28 => inm28,
          i29 => inm29,
          i30 => inm30,
          i31 => inm31,
          S => Ard1,
          Dout => Dout01
        );
		  
	BM2:Mux32x5
	port map(
			i0 => "00000000000000000000000000000000",
          i1 => inm1,
          i2 => inm2,
          i3 => inm3,
          i4 => inm4,
          i5 => inm5,
          i6 => inm6,
          i7 => inm7,
          i8 => inm8,
          i9 => inm9,
          i10 => inm10,
          i11 => inm11,
          i12 => inm12,
          i13 => inm13,
          i14 => inm14,
          i15 => inm15,
          i16 => inm16,
          i17 => inm17,
          i18 => inm18,
          i19 => inm19,
          i20 => inm20,
          i21 => inm21,
          i22 => inm22,
          i23 => inm23,
          i24 => inm24,
          i25 => inm25,
          i26 => inm26,
          i27 => inm27,
          i28 => inm28,
          i29 => inm29,
          i30 => inm30,
          i31 => inm31,
          S => Ard2,
          Dout => Dout02
        );
		  
	sm1:Mux2x1
	port map(
		A=>Dout01,
		B=>Din,
		X=>Dout1,
		C=>C1
	);
	
	sm2:Mux2x1
	port map(
		A=>Dout02,
		B=>Din,
		X=>Dout2,
		C=>C2
	);
	
end Behavioral;

