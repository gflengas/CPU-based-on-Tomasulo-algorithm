library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux32x5_5 is
	Port ( i0 : in  STD_LOGIC_VECTOR (4 downto 0);
           i1 : in  STD_LOGIC_VECTOR (4 downto 0);
           i2 : in  STD_LOGIC_VECTOR (4 downto 0);
           i3 : in  STD_LOGIC_VECTOR (4 downto 0);
           i4 : in  STD_LOGIC_VECTOR (4 downto 0);
           i5 : in  STD_LOGIC_VECTOR (4 downto 0);
           i6 : in  STD_LOGIC_VECTOR (4 downto 0);
           i7 : in  STD_LOGIC_VECTOR (4 downto 0);
           i8 : in  STD_LOGIC_VECTOR (4 downto 0);
           i9 : in  STD_LOGIC_VECTOR (4 downto 0);
           i10 : in  STD_LOGIC_VECTOR (4 downto 0);
           i11 : in  STD_LOGIC_VECTOR (4 downto 0);
           i12 : in  STD_LOGIC_VECTOR (4 downto 0);
           i13 : in  STD_LOGIC_VECTOR (4 downto 0);
           i14 : in  STD_LOGIC_VECTOR (4 downto 0);
           i15 : in  STD_LOGIC_VECTOR (4 downto 0);
           i16 : in  STD_LOGIC_VECTOR (4 downto 0);
           i17 : in  STD_LOGIC_VECTOR (4 downto 0);
           i18 : in  STD_LOGIC_VECTOR (4 downto 0);
           i19 : in  STD_LOGIC_VECTOR (4 downto 0);
           i20 : in  STD_LOGIC_VECTOR (4 downto 0);
           i21 : in  STD_LOGIC_VECTOR (4 downto 0);
           i22 : in  STD_LOGIC_VECTOR (4 downto 0);
           i23 : in  STD_LOGIC_VECTOR (4 downto 0);
           i24 : in  STD_LOGIC_VECTOR (4 downto 0);
           i25 : in  STD_LOGIC_VECTOR (4 downto 0);
           i26 : in  STD_LOGIC_VECTOR (4 downto 0);
           i27 : in  STD_LOGIC_VECTOR (4 downto 0);
           i28 : in  STD_LOGIC_VECTOR (4 downto 0);
           i29 : in  STD_LOGIC_VECTOR (4 downto 0);
           i30 : in  STD_LOGIC_VECTOR (4 downto 0);
           i31 : in  STD_LOGIC_VECTOR (4 downto 0);
           S : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end Mux32x5_5;

architecture Behavioral of Mux32x5_5 is

begin
	with S select
	Dout <= i0 when "00000",
			  i1 when "00001",
			  i2 when "00010",
			  i3 when "00011",
			  i4 when "00100",
			  i5 when "00101",
			  i6 when "00110",
			  i7 when "00111",
			  i8 when "01000",
			  i9 when "01001",
			  i10 when "01010",
			  i11 when "01011",
			  i12 when "01100",
			  i13 when "01101",
			  i14 when "01110",
			  i15 when "01111",
			  i16 when "10000",
			  i17 when "10001",
			  i18 when "10010",
			  i19 when "10011",
			  i20 when "10100",
			  i21 when "10101",
			  i22 when "10110",
			  i23 when "10111",
			  i24 when "11000",
			  i25 when "11001",
			  i26 when "11010",
			  i27 when "11011",
			  i28 when "11100",
			  i29 when "11101",
			  i30 when "11110",
			  i31 when others;

end Behavioral;

