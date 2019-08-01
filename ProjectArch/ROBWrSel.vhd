library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Demux1x16 is
    Port ( Input : in  STD_LOGIC;
           Ctr : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end Demux1x16;

architecture Behavioral of Demux1x16 is

begin
	output(0)<=Input when Ctr="0000"else'0';
	output(1)<=Input when Ctr="0001"else'0';
	output(2)<=Input when Ctr="0010"else'0';
	output(3)<=Input when Ctr="0011"else'0';
	output(4)<=Input when Ctr="0100"else'0';
	output(5)<=Input when Ctr="0101"else'0';
	output(6)<=Input when Ctr="0110"else'0';
	output(7)<=Input when Ctr="0111"else'0';
	output(8)<=Input when Ctr="1000"else'0';
	output(9)<=Input when Ctr="1001"else'0';
	output(10)<=Input when Ctr="1010"else'0';
	output(11)<=Input when Ctr="1011"else'0';
	output(12)<=Input when Ctr="1100"else'0';
	output(13)<=Input when Ctr="1101"else'0';
	output(14)<=Input when Ctr="1110"else'0';
	output(15)<=Input when Ctr="1111"else'0';
end Behavioral;

