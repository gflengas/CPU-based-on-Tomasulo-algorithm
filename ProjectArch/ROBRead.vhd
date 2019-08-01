library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ROBArrays.ALL;

entity ROBRead is
    Port ( ReadAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           Latest : in  STD_LOGIC_VECTOR (15 downto 0);
			  Input : in Array16x32;
           Catalog : in  Array16x5;
           TagsIn : in  Array16x5;
           Available : out  STD_LOGIC;
           ReadOut : out  STD_LOGIC_VECTOR (31 downto 0);
           TagOut : out  STD_LOGIC_VECTOR (4 downto 0));
end ROBRead;

architecture Behavioral of ROBRead is

begin
	process(ReadAddr, Catalog, Latest, Input, TagsIn)
	begin
		if ReadAddr = Catalog(0) and Latest(0) = '1' then
			ReadOut <= Input(0);
			TagOut <= TagsIn(0);
			Available <= '1';
			
		elsif ReadAddr = Catalog(1) and Latest(1) = '1' then
			ReadOut <= Input(1);
			TagOut <= TagsIn(1);
			Available <= '1';
			
		elsif ReadAddr = Catalog(2) and Latest(2) = '1' then
			ReadOut <= Input(2);
			TagOut <= TagsIn(2);
			Available <= '1';
			
		elsif ReadAddr = Catalog(3) and Latest(3) = '1' then
			ReadOut <= Input(3);
			TagOut <= TagsIn(3);
			Available <= '1';
			
		elsif ReadAddr = Catalog(4) and Latest(4) = '1' then
			ReadOut <= Input(4);
			TagOut <= TagsIn(4);
			Available <= '1';
			
		elsif ReadAddr = Catalog(5) and Latest(5) = '1' then
			ReadOut <= Input(5);
			TagOut <= TagsIn(5);
			Available <= '1';
			
		elsif ReadAddr = Catalog(6) and Latest(6) = '1' then
			ReadOut <= Input(6);
			TagOut <= TagsIn(6);
			Available <= '1';
			
		elsif ReadAddr=Catalog(7) and Latest(7) = '1' then
			ReadOut <= Input(7);
			TagOut <= TagsIn(7);
			Available <= '1';
			
		elsif ReadAddr = Catalog(8) and Latest(8) = '1' then
			ReadOut <= Input(8);
			TagOut <= TagsIn(8);
			Available <= '1';
			
		elsif ReadAddr = Catalog(9) and Latest(9) = '1' then
			ReadOut <= Input(9);
			TagOut <= TagsIn(9);
			Available <= '1';
			
		elsif ReadAddr = Catalog(10) and Latest(10) = '1'  then
			ReadOut <= Input(10);
			TagOut <= TagsIn(10);
			Available <= '1';
			
		elsif ReadAddr = Catalog(11) and Latest(11) = '1'  then
			ReadOut <= Input(11);
			TagOut <= TagsIn(11);
			Available <= '1';
			
		elsif ReadAddr = Catalog(12) and Latest(12) = '1'  then
			ReadOut <= Input(12);
			TagOut <= TagsIn(12);
			Available <= '1';
			
		elsif ReadAddr = Catalog(13) and Latest(13) = '1'  then
			ReadOut <= Input(13);
			TagOut <= TagsIn(13);
			Available <= '1';
		
		elsif ReadAddr = Catalog(14) and Latest(14)= '1'  then
			ReadOut <= Input(14);
			TagOut <= TagsIn(14);
			Available <= '1';
		elsif ReadAddr = Catalog(15) and Latest(15) = '1'  then
			ReadOut <= Input(15);
			TagOut <= TagsIn(15);
			Available <= '1';
		else
			Available <= '0';
			TagOut <= "00000";
			ReadOut <= "00000000000000000000000000000000";
		end if;
	end process;

end Behavioral;

