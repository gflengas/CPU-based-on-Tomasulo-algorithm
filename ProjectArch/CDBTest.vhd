LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CDBTest IS
END CDBTest;
 
ARCHITECTURE behavior OF CDBTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CommonDataBus
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         QArithm : IN  std_logic_vector(4 downto 0);
         VArithm : IN  std_logic_vector(31 downto 0);
         QLogic : IN  std_logic_vector(4 downto 0);
         VLogic : IN  std_logic_vector(31 downto 0);
         QBuffer : IN  std_logic_vector(4 downto 0);
         VBuffer : IN  std_logic_vector(31 downto 0);
         ArithmReq : IN  std_logic;
         LogicReq : IN  std_logic;
         BufferReq : IN  std_logic;
         QOut : OUT  std_logic_vector(4 downto 0);
         VOut : OUT  std_logic_vector(31 downto 0);
         GrantArithm : OUT  std_logic;
         GrantLogic : OUT  std_logic;
         GrantBuffer : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal QArithm : std_logic_vector(4 downto 0) := (others => '0');
   signal VArithm : std_logic_vector(31 downto 0) := (others => '0');
   signal QLogic : std_logic_vector(4 downto 0) := (others => '0');
   signal VLogic : std_logic_vector(31 downto 0) := (others => '0');
   signal QBuffer : std_logic_vector(4 downto 0) := (others => '0');
   signal VBuffer : std_logic_vector(31 downto 0) := (others => '0');
   signal ArithmReq : std_logic := '0';
   signal LogicReq : std_logic := '0';
   signal BufferReq : std_logic := '0';

 	--Outputs
   signal QOut : std_logic_vector(4 downto 0);
   signal VOut : std_logic_vector(31 downto 0);
   signal GrantArithm : std_logic;
   signal GrantLogic : std_logic;
   signal GrantBuffer : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CommonDataBus PORT MAP (
          Clk => Clk,
          Rst => Rst,
          QArithm => QArithm,
          VArithm => VArithm,
          QLogic => QLogic,
          VLogic => VLogic,
          QBuffer => QBuffer,
          VBuffer => VBuffer,
          ArithmReq => ArithmReq,
          LogicReq => LogicReq,
          BufferReq => BufferReq,
          QOut => QOut,
          VOut => VOut,
          GrantArithm => GrantArithm,
          GrantLogic => GrantLogic,
          GrantBuffer => GrantBuffer
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
		QArithm <= "10001";
		VArithm <= "00000000000000000000000000000001";
		QLogic <= "10010";
		VLogic <= "00000000000000000000000000000010";
		QBuffer <= "10011";
		VBuffer <= "00000000000000000000000000000011";
		ArithmReq <= '1';
		LogicReq <= '1';
		BufferReq <= '1';
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
