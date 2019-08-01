library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arithm is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Issue : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Qj : in  STD_LOGIC_VECTOR (4 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Qk : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           Grant : in  STD_LOGIC;
           Available : out  STD_LOGIC_VECTOR (2 downto 0);
           VOut : out  STD_LOGIC_VECTOR (31 downto 0);
           QOut : out  STD_LOGIC_VECTOR (4 downto 0);
           Request : out  STD_LOGIC);
end Arithm;

architecture Behavioral of Arithm is
	
	COMPONENT ReservationStation is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  ID : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Qj : in  STD_LOGIC_VECTOR (4 downto 0);
           Qk : in  STD_LOGIC_VECTOR (4 downto 0);
           Ex : in  STD_LOGIC;
           CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in  STD_LOGIC_VECTOR (31 downto 0);
           OpOut : out  STD_LOGIC_VECTOR (1 downto 0);
           VjOut : out  STD_LOGIC_VECTOR (31 downto 0);
           VkOut : out  STD_LOGIC_VECTOR (31 downto 0);
           ReadyOut : out  STD_LOGIC;
           BusyOut : out  STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ArithmCtr is
    Port ( Clk : in Std_Logic;
			  Rst : in  STD_LOGIC;
			  Ready : in  STD_LOGIC_VECTOR (2 downto 0);
			  RS1Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS2Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS3Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  RS1Vj : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS2Vj : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS3Vj : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS1Vk : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS2Vk : in  STD_LOGIC_VECTOR (31 downto 0);
			  RS3Vk : in  STD_LOGIC_VECTOR (31 downto 0);
			  Busy : in  STD_LOGIC;
			  Tag : out  STD_LOGIC_VECTOR (4 downto 0);
			  Op : out  STD_LOGIC_VECTOR (1 downto 0);
			  Vj : out  STD_LOGIC_VECTOR (31 downto 0);
			  Vk : out  STD_LOGIC_VECTOR (31 downto 0);
			  En : out STD_LOGIC;
			  RsEx : out  STD_LOGIC_VECTOR (2 downto 0));
	END COMPONENT;
	
	COMPONENT ArithmFU is
    Port ( Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           En : in  STD_LOGIC;
           Grant : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Tag : in  STD_LOGIC_VECTOR (4 downto 0);
           ReqOut : out  STD_LOGIC;
           BusyOut : out  STD_LOGIC;
           ResOut : out  STD_LOGIC_VECTOR (31 downto 0);
           TagOut : out  STD_LOGIC_VECTOR (4 downto 0));
	END COMPONENT;
	
	SIGNAL  TagOut : STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL  RS1VjOut,RS1VkOut,RS2VjOut,RS2VkOut,RS3VjOut,RS3VkOut,VjOut,VkOut : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL  RS1ReadyOut,RS1BusyOut,RS2ReadyOut,RS2BusyOut,RS3ReadyOut,RS3BusyOut,RS1WE,RS2WE,RS3WE,EnOut,BusyOut : STD_LOGIC;
	SIGNAL  RS1OpOut,RS2OpOut,RS3OpOut,OpOut : STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL  RsExOut,Av : STD_LOGIC_VECTOR(2 downto 0);
begin
	Rs0: ReservationStation Port Map(
		Clk => Clk,
      Rst => Rst,
		ID => "00001",
		WE => RS1WE,
      Op => Op,
      Vj => Vj,
		Vk => Vk,
		Qj => Qj,
		Qk => Qk,
		Ex => RsExOut(0),
		CDBQ => CDBQ,
		CDBV => CDBV,
		OpOut => RS1OpOut,
		VjOut => RS1VjOut,
		VkOut => RS1VkOut,
		ReadyOut => RS1ReadyOut, 
		BusyOut => RS1BusyOut);
	
	Rs1: ReservationStation Port Map(
		Clk => Clk,
      Rst => Rst,
		ID => "00010",
		WE => RS2WE,
      Op => Op,
      Vj => Vj,
		Vk => Vk,
		Qj => Qj,
		Qk => Qk,
		Ex => RsExOut(1),
		CDBQ => CDBQ,
		CDBV => CDBV,
		OpOut => RS2OpOut,
		VjOut => RS2VjOut,
		VkOut => RS2VkOut,
		ReadyOut => RS2ReadyOut, 
		BusyOut => RS2BusyOut);
	
	Rs2: ReservationStation Port Map(
		Clk => Clk,
      Rst => Rst,
		ID => "00011",
		WE => RS3WE,
      Op => Op,
      Vj => Vj,
		Vk => Vk,
		Qj => Qj,
		Qk => Qk,
		Ex => RsExOut(2),
		CDBQ => CDBQ,
		CDBV => CDBV,
		OpOut => RS3OpOut,
		VjOut => RS3VjOut,
		VkOut => RS3VkOut,
		ReadyOut => RS3ReadyOut, 
		BusyOut => RS3BusyOut);
	
	AFU: ArithmFU Port Map(
		Rst => Rst,
		Clk => Clk,
		En => EnOut,
		Grant => Grant,
		Op => OpOut,
		Vj => VjOut,
		Vk => VkOut,
		Tag => TagOut,
		ReqOut => Request,
		BusyOut => BusyOut,
		ResOut => VOut,
		TagOut => QOut);
		
	AC: ArithmCtr Port Map(
		Clk => Clk,
		Rst =>  Rst,
		Ready(0) => RS1ReadyOut,
		Ready(1) => RS2ReadyOut,
		Ready(2) => RS3ReadyOut,
		RS1Op => RS1OpOut,
		RS2Op => RS2OpOut,
		RS3Op => RS3OpOut,
		RS1Vj => RS1VjOut,
		RS2Vj => RS2VjOut,
		RS3Vj => RS3VjOut,
		RS1Vk => RS1VkOut,
		RS2Vk => RS2VkOut,
		RS3Vk => RS3VkOut,
		Busy => BusyOut,
		Tag => TagOut,
		Op => OpOut,
		Vj => VjOut,
		Vk => VkOut,
		En => EnOut,
		RsEx => RsExOut);
		
	Av(0) <= NOT RS1BusyOut ;
	Av(1) <= RS1BusyOut AND (NOT RS2BusyOut);
	Av(2) <= RS1BusyOut AND RS2BusyOut AND (NOT RS3BusyOut);

	with Av Select
		Available <= "001" when "001",
						 "010" when "010",
						 "011" when "100",
						 "000" when others ;

	RS1WE <= Av(0) AND Issue ;
	RS2WE <= Av(1) AND Issue ;
	RS3WE <= Av(2) AND Issue ;
	
end Behavioral;

