--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:10:49 12/18/2018
-- Design Name:   
-- Module Name:   C:/Xilinx/ProjectArch/FinalTest.vhd
-- Project Name:  ProjectArch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopModule
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
 
ENTITY FinalTest IS
END FinalTest;
 
ARCHITECTURE behavior OF FinalTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopModule
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Issue : IN  std_logic;
         Fu_type : IN  std_logic_vector(1 downto 0);
         Fop : IN  std_logic_vector(1 downto 0);
         Ri : IN  std_logic_vector(4 downto 0);
         Rj : IN  std_logic_vector(4 downto 0);
         Rk : IN  std_logic_vector(4 downto 0);
         LoadNum : IN  std_logic;
         Exception : IN  std_logic;
         Num : IN  std_logic_vector(31 downto 0);
         ExceptionOut : OUT  std_logic;
         PCOut : OUT  std_logic_vector(31 downto 0);
         Accepted : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Issue : std_logic := '0';
   signal Fu_type : std_logic_vector(1 downto 0) := (others => '0');
   signal Fop : std_logic_vector(1 downto 0) := (others => '0');
   signal Ri : std_logic_vector(4 downto 0) := (others => '0');
   signal Rj : std_logic_vector(4 downto 0) := (others => '0');
   signal Rk : std_logic_vector(4 downto 0) := (others => '0');
   signal LoadNum : std_logic := '0';
   signal Exception : std_logic := '0';
   signal Num : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ExceptionOut : std_logic;
   signal PCOut : std_logic_vector(31 downto 0);
   signal Accepted : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopModule PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Issue => Issue,
          Fu_type => Fu_type,
          Fop => Fop,
          Ri => Ri,
          Rj => Rj,
          Rk => Rk,
          LoadNum => LoadNum,
          Exception => Exception,
          Num => Num,
          ExceptionOut => ExceptionOut,
          PCOut => PCOut,
          Accepted => Accepted
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
    wait for 100 ns;	
		Rst <='1';
		Issue <='0';
		Fu_type <="00";
		Fop <="00";
		Ri <="00000";
		Rj <="00000";
		Rk <="00000";
		LoadNum <='0';
		Num <="00000000000000000000000000000000";
      wait for CLK_period;

		--or $15, $0, 15
		Rst <='0';
		Issue <='1';
		Fu_type <="00";
		Fop <="01";
		Ri <="01111";
		Rj <="00000";
		Rk <="00000";
		LoadNum <='1';
		Num <="00000000000000000000000000001111";
      wait for CLK_period;
		
		-- add $1, $0, 1
		Fu_type <="01";
		Fop <="00";
		Ri <="00001";
		Rj <="00000";
		Rk  <="00000";
		LoadNum <='1';
		Num <="00000000000000000000000000000001";
      wait for CLK_period;

		-- sub $2, $0, -1
		Fu_type <="01";
		Fop     <="01";
		Ri      <="00010";
		Rj      <="00000";
		Rk      <="00000";
		LoadNum   <='1';
		Num <="01111111111111111111111111111111";
      wait for CLK_period*1;
		
		-- add $3, $1, $2
		Fu_type <="01";
		Fop <="00";
		Ri <="00011";
		Rj <="00001";
		Rk <="00010";
		LoadNum  <='0';
      wait for CLK_period;
		
		-- and $4,$2,$1
		Fu_type <="00";
		Fop <="00";
		Ri <="00100";
		Rj <="00010";
		Rk <="00001";
      wait for CLK_period;
		
		-- not $5,$4,$4
		Fu_type <="00";
		Fop <="10";
		Ri <="00101";
		Rj <="00011";
		Rk <="00011";
      wait for CLK_period;
	
  	   -- Nop
		Issue <='0';
		Fop <="00";
		Ri <="00000";
		Rj <="00000";
		Rk <="00000";
      wait for CLK_period;


      wait;
   end process;

END;
