LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY RSTest IS
END RSTest;
 
ARCHITECTURE behavior OF RSTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ReservationStation
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         WE : IN  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         Vj : IN  std_logic_vector(31 downto 0);
         Vk : IN  std_logic_vector(31 downto 0);
         Qj : IN  std_logic_vector(4 downto 0);
         Qk : IN  std_logic_vector(4 downto 0);
         Ex : IN  std_logic;
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBV : IN  std_logic_vector(31 downto 0);
         OpOut : OUT  std_logic_vector(1 downto 0);
         VjOut : OUT  std_logic_vector(31 downto 0);
         VkOut : OUT  std_logic_vector(31 downto 0);
         ReadyOut : OUT  std_logic;
         BusyOut : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal WE : std_logic := '0';
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Vj : std_logic_vector(31 downto 0) := (others => '0');
   signal Vk : std_logic_vector(31 downto 0) := (others => '0');
   signal Qj : std_logic_vector(4 downto 0) := (others => '0');
   signal Qk : std_logic_vector(4 downto 0) := (others => '0');
   signal Ex : std_logic := '0';
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBV : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal OpOut : std_logic_vector(1 downto 0);
   signal VjOut : std_logic_vector(31 downto 0);
   signal VkOut : std_logic_vector(31 downto 0);
   signal ReadyOut : std_logic;
   signal BusyOut : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ReservationStation PORT MAP (
          Clk => Clk,
          Rst => Rst,
          WE => WE,
          Op => Op,
          Vj => Vj,
          Vk => Vk,
          Qj => Qj,
          Qk => Qk,
          Ex => Ex,
          CDBQ => CDBQ,
          CDBV => CDBV,
          OpOut => OpOut,
          VjOut => VjOut,
          VkOut => VkOut,
          ReadyOut => ReadyOut,
          BusyOut => BusyOut
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
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        Vj <= "00000000000000000000000000000001";
        Vk <= "00000000000000000000000000000010";
        Qj <= "00001";
        Qk <= "00010";

        wait for Clk_period*10;
		  
        WE <= '1' ;
		  
        wait for Clk_period*10;
		  
        WE <= '0' ;

        wait for Clk_period*10;

        CDBV <= "00000000000000001000000000000001";
        CDBQ <= "00001";

        wait for Clk_period*10;

        CDBV <= "00000000000000001000000001000001";
        CDBQ <= "00010";

        wait for Clk_period*10;

        CDBV <= "00000000000000000000000000000000";
        CDBQ <= "00000";

        wait for Clk_period*10;
		  
        ex <= '1';
		  
        wait for Clk_period*10;
		
        ex <= '0';
		  
        wait for Clk_period*10;
			wait for Clk_period*10;

      wait;
   end process;

END;
