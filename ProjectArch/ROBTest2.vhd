--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:12:33 12/17/2018
-- Design Name:   
-- Module Name:   C:/Xilinx/ProjectArch/ROBTest2.vhd
-- Project Name:  ProjectArch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ReorderBuffer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ROBTest2 IS
END ROBTest2;
 
ARCHITECTURE behavior OF ROBTest2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ReorderBuffer
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         ReadAddr1 : IN  std_logic_vector(4 downto 0);
         ReadAddr2 : IN  std_logic_vector(4 downto 0);
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBV : IN  std_logic_vector(31 downto 0);
         Tag : IN  std_logic_vector(4 downto 0);
         WE : IN  std_logic;
         Addr : IN  std_logic_vector(4 downto 0);
         Fu_type : IN  std_logic_vector(1 downto 0);
         Input : IN  std_logic_vector(31 downto 0);
         Exception : IN  std_logic;
         DataOut1 : OUT  std_logic_vector(31 downto 0);
         DataOut2 : OUT  std_logic_vector(31 downto 0);
         TagOut1 : OUT  std_logic_vector(4 downto 0);
         TagOut2 : OUT  std_logic_vector(4 downto 0);
         Available1 : OUT  std_logic;
         Available2 : OUT  std_logic;
         RFaddr : OUT  std_logic_vector(4 downto 0);
         RFData : OUT  std_logic_vector(31 downto 0);
         RFWE : OUT  std_logic;
         Output : OUT  std_logic_vector(31 downto 0);
         ExceptionOut : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal ReadAddr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal ReadAddr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBV : std_logic_vector(31 downto 0) := (others => '0');
   signal Tag : std_logic_vector(4 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal Addr : std_logic_vector(4 downto 0) := (others => '0');
   signal Fu_type : std_logic_vector(1 downto 0) := (others => '0');
   signal Input : std_logic_vector(31 downto 0) := (others => '0');
   signal Exception : std_logic := '0';

 	--Outputs
   signal DataOut1 : std_logic_vector(31 downto 0);
   signal DataOut2 : std_logic_vector(31 downto 0);
   signal TagOut1 : std_logic_vector(4 downto 0);
   signal TagOut2 : std_logic_vector(4 downto 0);
   signal Available1 : std_logic;
   signal Available2 : std_logic;
   signal RFaddr : std_logic_vector(4 downto 0);
   signal RFData : std_logic_vector(31 downto 0);
   signal RFWE : std_logic;
   signal Output : std_logic_vector(31 downto 0);
   signal ExceptionOut : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ReorderBuffer PORT MAP (
          Clk => Clk,
          Rst => Rst,
          ReadAddr1 => ReadAddr1,
          ReadAddr2 => ReadAddr2,
          CDBQ => CDBQ,
          CDBV => CDBV,
          Tag => Tag,
          WE => WE,
          Addr => Addr,
          Fu_type => Fu_type,
          Input => Input,
          Exception => Exception,
          DataOut1 => DataOut1,
          DataOut2 => DataOut2,
          TagOut1 => TagOut1,
          TagOut2 => TagOut2,
          Available1 => Available1,
          Available2 => Available2,
          RFaddr => RFaddr,
          RFData => RFData,
          RFWE => RFWE,
          Output => Output,
          ExceptionOut => ExceptionOut
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
     Rst<='1';
      wait for 100 ns;	
		Rst<='0';
      wait for 100 ns;
		ReadAddr1 <= "00001";
		ReadAddr2 <= "00010";
		WE <= '1';
		Fu_type <= "01";
      Addr <= "00001";
      Input <= "00000000000000000000000000000001";
		Tag <= "00001"; 
      wait for Clk_period;
		
      Addr <= "00010";
      Input <= "00000000000000000000000000000010";
		Tag <= "00011"; 
      wait for Clk_period;
		
      Addr <= "00001";
      Input <= "00000000000000000000000000000001";
		Tag <= "00001"; 
      wait for Clk_period;
		
		CDBQ <= "00011";
		CDBV <= "00000000000000000000000001111101";
		wait for Clk_period;
		
		CDBQ <= "00000";
		CDBV <= "00000000000000000000000000000000";
		wait for Clk_period;
		
		Addr <= "00010";
      Input <= "00000000000000000000000000000010";
		Tag <= "00111"; 
      wait for Clk_period;
		
		Addr <= "00001";
      Input <= "00000000000000000000000000000001";
		Tag <= "00001"; 
      wait for Clk_period;
		
		
      
      wait;
   end process;

END;
