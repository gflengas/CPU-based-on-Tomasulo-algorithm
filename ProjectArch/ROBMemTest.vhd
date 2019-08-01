--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:40:52 12/16/2018
-- Design Name:   
-- Module Name:   C:/Xilinx/ProjectArch/ROBMemTest.vhd
-- Project Name:  ProjectArch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ROBMem
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
 
ENTITY ROBMemTest IS
END ROBMemTest;
 
ARCHITECTURE behavior OF ROBMemTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ROBMem
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Fu_type : IN  std_logic_vector(1 downto 0);
         Tag : IN  std_logic_vector(4 downto 0);
         Input : IN  std_logic_vector(31 downto 0);
         Addr : IN  std_logic_vector(4 downto 0);
         WE : IN  std_logic;
         GenWE : IN  std_logic;
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBVin : IN  std_logic_vector(31 downto 0);
         Clear : IN  std_logic;
         Exception : IN  std_logic;
         TagOut : OUT  std_logic_vector(4 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Latest : OUT  std_logic;
         ExceptionOut : OUT  std_logic;
         Ready : OUT  std_logic;
         CDBVout : OUT  std_logic_vector(31 downto 0);
         AddrOut : OUT  std_logic_vector(4 downto 0);
         Fu_type_out : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Fu_type : std_logic_vector(1 downto 0) := (others => '0');
   signal Tag : std_logic_vector(4 downto 0) := (others => '0');
   signal Input : std_logic_vector(31 downto 0) := (others => '0');
   signal Addr : std_logic_vector(4 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal GenWE : std_logic := '0';
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBVin : std_logic_vector(31 downto 0) := (others => '0');
   signal Clear : std_logic := '0';
   signal Exception : std_logic := '0';

 	--Outputs
   signal TagOut : std_logic_vector(4 downto 0);
   signal Output : std_logic_vector(31 downto 0);
   signal Latest : std_logic;
   signal ExceptionOut : std_logic;
   signal Ready : std_logic;
   signal CDBVout : std_logic_vector(31 downto 0);
   signal AddrOut : std_logic_vector(4 downto 0);
   signal Fu_type_out : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ROBMem PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Fu_type => Fu_type,
          Tag => Tag,
          Input => Input,
          Addr => Addr,
          WE => WE,
          GenWE => GenWE,
          CDBQ => CDBQ,
          CDBVin => CDBVin,
          Clear => Clear,
          Exception => Exception,
          TagOut => TagOut,
          Output => Output,
          Latest => Latest,
          ExceptionOut => ExceptionOut,
          Ready => Ready,
          CDBVout => CDBVout,
          AddrOut => AddrOut,
          Fu_type_out => Fu_type_out
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
      Rst <= '1';
      wait for 100 ns;	
		Rst <= '0';
		wait for 100 ns;
		Fu_type <= "01";
		Addr <= "00001";
		Tag <= "10001";
		Input <= "00000000000000000000000000000011";
		Exception <= '0';
		WE <= '1';
      wait for Clk_period*10;
		WE <= '0';
		wait for Clk_period*10;
		CDBVin <= "10000000000000000000000000000011";
		CDBQ <= "10001";
		wait for Clk_period*10;
		CDBQ <= (others => '0');
      CDBVin <= (others => '0');
		wait for Clk_period*10;
		Exception <='1';
		wait for Clk_period*10;
		Exception <='0';
		wait for Clk_period*10;
      Rst <= '1';
      wait for 100 ns;	
		Rst <= '0';
		wait for 100 ns;
		Fu_type <= "01";
		Addr <= "00001";
		Tag <= "10001";
		Input <= "00000000000000000000000000000011";
		Exception <= '0';
		WE <= '1';
      wait for Clk_period*10;
		WE <= '0';
		wait for Clk_period*10;
		CDBVin <= "10000000000000000000000000000011";
		CDBQ <= "10001";
		wait for Clk_period*10;
		CDBQ <= (others => '0');
      CDBVin <= (others => '0');
		wait for Clk_period*10;
		GenWE <='1';
		wait for Clk_period*10;
		GenWE <='0';
		wait for Clk_period*10;
		Clear <='1';
		wait for Clk_period*10;
		Clear <='0';
		wait for Clk_period*10;

      wait;
   end process;

END;
