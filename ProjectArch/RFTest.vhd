LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY RFTest IS
END RFTest;
 
ARCHITECTURE behavior OF RFTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         ReadAddr1 : IN  std_logic_vector(4 downto 0);
         ReadAddr2 : IN  std_logic_vector(4 downto 0);
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBV : IN  std_logic_vector(31 downto 0);
         Tag : IN  std_logic_vector(4 downto 0);
         WE : IN  std_logic;
         WrAddr : IN  std_logic_vector(4 downto 0);
         DataOut1 : OUT  std_logic_vector(31 downto 0);
         DataOut2 : OUT  std_logic_vector(31 downto 0);
         TagOut1 : OUT  std_logic_vector(4 downto 0);
         TagOut2 : OUT  std_logic_vector(4 downto 0)
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
   signal WrAddr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal DataOut1 : std_logic_vector(31 downto 0);
   signal DataOut2 : std_logic_vector(31 downto 0);
   signal TagOut1 : std_logic_vector(4 downto 0);
   signal TagOut2 : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Clk => Clk,
          Rst => Rst,
          ReadAddr1 => ReadAddr1,
          ReadAddr2 => ReadAddr2,
          CDBQ => CDBQ,
          CDBV => CDBV,
          Tag => Tag,
          WE => WE,
          WrAddr => WrAddr,
          DataOut1 => DataOut1,
          DataOut2 => DataOut2,
          TagOut1 => TagOut1,
          TagOut2 => TagOut2
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
		WE<='1';
		wait for Clk_period*10;
		
		Tag <= "00001";
		WrAddr <= "00001";
		wait for Clk_period*10;
		
		Tag <= "00010";
		WrAddr <= "00010";
		wait for Clk_period*10;
		
		Tag <= "00011";
		WrAddr <= "00011";
		wait for Clk_period*10;
		
		CDBQ<="00001";
		CDBV<= "00000000000000000000000000000001";
		wait for Clk_period*10;
		
		CDBQ<="00010";
		CDBV<= "00000000000000000000000000000010";
		wait for Clk_period*10;
		
		CDBQ<="00011";
		CDBV<= "00000000000000000000000000000011";
		wait for Clk_period*10;
		
		ReadAddr1 <="00001";
      ReadAddr2 <="00010";
		wait for Clk_period*10;
		
		ReadAddr1 <="00010";
      ReadAddr2 <="00011";
		wait for Clk_period*10;
		
		ReadAddr1 <="00011";
      ReadAddr2 <="00001";
		wait for Clk_period*10;
		
      wait;
   end process;

END;
