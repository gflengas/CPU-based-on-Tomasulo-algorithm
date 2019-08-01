LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY LFUTest IS
END LFUTest;
 
ARCHITECTURE behavior OF LFUTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LogicFU
    PORT(
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         En : IN  std_logic;
         Grant : IN  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         Vj : IN  std_logic_vector(31 downto 0);
         Vk : IN  std_logic_vector(31 downto 0);
         Tag : IN  std_logic_vector(4 downto 0);
         ReqOut : OUT  std_logic;
         BusyOut : OUT  std_logic;
         ResOut : OUT  std_logic_vector(31 downto 0);
         TagOut : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';
   signal En : std_logic := '0';
   signal Grant : std_logic := '0';
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Vj : std_logic_vector(31 downto 0) := (others => '0');
   signal Vk : std_logic_vector(31 downto 0) := (others => '0');
   signal Tag : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ReqOut : std_logic;
   signal BusyOut : std_logic;
   signal ResOut : std_logic_vector(31 downto 0);
   signal TagOut : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LogicFU PORT MAP (
          Rst => Rst,
          Clk => Clk,
          En => En,
          Grant => Grant,
          Op => Op,
          Vj => Vj,
          Vk => Vk,
          Tag => Tag,
          ReqOut => ReqOut,
          BusyOut => BusyOut,
          ResOut => ResOut,
          TagOut => TagOut
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
		
		Vj <= "00000000000000000000000000000001" ;
      Vk <= "00000000000000000000000000000010" ;
      Op <= "10";
      Tag <= "10000";
      wait for Clk_period*10;
		
		En<='1';
      wait for Clk_period*10;
		En<='0';
		wait for Clk_period*10;
		Grant <= '1';
      wait for Clk_period*10;
		Grant <= '0';
		wait for Clk_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
