library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RegisterFile is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           ReadAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           ReadAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           WrAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut1 : out  STD_LOGIC_VECTOR (31 downto 0);
           DataOut2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

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
		
	type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
	SIGNAL inm: reg_array;
	SIGNAL DO,cmp: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
begin

	dc: decoder5to32 
	port map(
		Awr=> WrAddr,
		DecOut=>DO
	);
	
	generate_registers2:
	for i in 1 to 31 generate
		cmp(i)<= DO(i) and WE;
		Register32x32 : Register32bits Port Map (Data=>CDBV,
												WE=>cmp(i),
												CLK=>Clk,
												Reset=>Rst,
												Dout=>inm(i));
	end generate;
	
	d1:Mux32x5
	port map(
			 i0 => inm(0),
          i1 => inm(1),
          i2 => inm(2),
          i3 => inm(3),
          i4 => inm(4),
          i5 => inm(5),
          i6 => inm(6),
          i7 => inm(7),
          i8 => inm(8),
          i9 => inm(9),
          i10 => inm(10),
          i11 => inm(11),
          i12 => inm(12),
          i13 => inm(13),
          i14 => inm(14),
          i15 => inm(15),
          i16 => inm(16),
          i17 => inm(17),
          i18 => inm(18),
          i19 => inm(19),
          i20 => inm(20),
          i21 => inm(21),
          i22 => inm(22),
          i23 => inm(23),
          i24 => inm(24),
          i25 => inm(25),
          i26 => inm(26),
          i27 => inm(27),
          i28 => inm(28),
          i29 => inm(29),
          i30 => inm(30),
          i31 => inm(31),
          S => ReadAddr1,
          Dout => DataOut1
        );
		  
	d2:Mux32x5
	port map(
			 i0 => inm(0),
          i1 => inm(1),
          i2 => inm(2),
          i3 => inm(3),
          i4 => inm(4),
          i5 => inm(5),
          i6 => inm(6),
          i7 => inm(7),
          i8 => inm(8),
          i9 => inm(9),
          i10 => inm(10),
          i11 => inm(11),
          i12 => inm(12),
          i13 => inm(13),
          i14 => inm(14),
          i15 => inm(15),
          i16 => inm(16),
          i17 => inm(17),
          i18 => inm(18),
          i19 => inm(19),
          i20 => inm(20),
          i21 => inm(21),
          i22 => inm(22),
          i23 => inm(23),
          i24 => inm(24),
          i25 => inm(25),
          i26 => inm(26),
          i27 => inm(27),
          i28 => inm(28),
          i29 => inm(29),
          i30 => inm(30),
          i31 => inm(31),
          S => ReadAddr2,
          Dout => DataOut2
        );
end Behavioral;

