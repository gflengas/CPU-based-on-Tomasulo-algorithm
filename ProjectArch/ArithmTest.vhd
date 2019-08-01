LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ArithmTest IS
END ArithmTest;
 
ARCHITECTURE behavior OF ArithmTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Arithm
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Issue : IN  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         Vj : IN  std_logic_vector(31 downto 0);
         Qj : IN  std_logic_vector(4 downto 0);
         Vk : IN  std_logic_vector(31 downto 0);
         Qk : IN  std_logic_vector(4 downto 0);
         CDBV : IN  std_logic_vector(31 downto 0);
         CDBQ : IN  std_logic_vector(4 downto 0);
         Grant : IN  std_logic;
         Available : OUT  std_logic_vector(2 downto 0);
         VOut : OUT  std_logic_vector(31 downto 0);
         QOut : OUT  std_logic_vector(4 downto 0);
         Request : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Issue : std_logic := '0';
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Vj : std_logic_vector(31 downto 0) := (others => '0');
   signal Qj : std_logic_vector(4 downto 0) := (others => '0');
   signal Vk : std_logic_vector(31 downto 0) := (others => '0');
   signal Qk : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBV : std_logic_vector(31 downto 0) := (others => '0');
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal Grant : std_logic := '0';

 	--Outputs
   signal Available : std_logic_vector(2 downto 0);
   signal VOut : std_logic_vector(31 downto 0);
   signal QOut : std_logic_vector(4 downto 0);
   signal Request : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Arithm PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Issue => Issue,
          Op => Op,
          Vj => Vj,
          Qj => Qj,
          Vk => Vk,
          Qk => Qk,
          CDBV => CDBV,
          CDBQ => CDBQ,
          Grant => Grant,
          Available => Available,
          VOut => VOut,
          QOut => QOut,
          Request => Request
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
      Rst <='1';
      wait for 100 ns;	
		Rst <='0';
      wait for 100 ns;
		
		Op <= "01";
      Vj <= "00000000000000000000000000111000";
      Vk <= "00000000000000000000000000000111";
      Qj <= "00000";
      Qk <= "00010";
      wait for Clk_period*10;
		
		Issue <='1';
		wait for Clk_period*10;
		
		Issue <='0';
		wait for Clk_period*10;
		
		CDBV <= "00000000000000000000000000010110";
      CDBQ <= "00010";
		wait for Clk_period*10;
		Grant <= '1';
		wait for Clk_period*10;
		Grant <= '0';
		wait for Clk_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
