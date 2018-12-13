LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity testbench is
end Top_func;

ARCHITECTURE behavior OF testbench IS

COMPONENT Top_func is
    port(
        clk: in std_logic;
        clr : in std_logic;
        Din: in std_logic_vector (63 downto 0);
        ukey: in std_logic_vector (127 downto 0);
        btnL,btnR,btnD : in std_logic;
    	top_ready: out std_logic;
    	ifhalt: out std_logic;
    );
end COMPONENT;

TYPE Din_ARRAY IS ARRAY (0 TO 300) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
CONSTANT random_din: Din_ARRAY := (

);

TYPE ukey_ARRAY IS ARRAY (0 TO 300) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
CONSTANT random_ukey: ukey_ARRAY := (

); 

TYPE  StateType IS (
ST_KG,
ST_EN, -- in this state RC5 pre-round op is performed 
ST_DE, -- in this state RC5 round op is performed. The state machine remains in this state for twelve clock cycles.
);-- RC5 state machine has four states: idle, pre_round, round and ready
SIGNAL  state:   StateType;

signal clk: std_logic;
signal test_counter: integer range 1 to 300:=1;
signal btnL: sta_logic;
signal btnD: sta_logic;
signal btnR: sta_logic;
signal top_ready: sta_logic;
signal correctness: std_logic:=1;
signal ifhalt: std_logic;


constant clk_period : time := 10 ns;



begin
   
   clk_proc: process
   begin
    
   wait for clk_period;	
   
   clk<='0';
   
   wait for clk_period;
   
   clk<='1'
   
   end process;
   
   input_proc:process(top_ready,clk)
   begin
   if(top_ready=1 and rising_edge(clk)) then
   	test_counter=test_counter+1;
   end process;
   
   configiration_proc: process
   begin
   if (rising_edge(clk) AND IFHALT='1') THEN
   		CASE state IS
			WHEN ST_KG=>	state<=ST_EN;
			WHEN ST_EN=>	state<=ST_DE;;
			WHEN ST_DE=>	state<=ST_KG;
   		END CASE;
   
   end process;
   
   
   test: Top_func port map{
   clk,
   clr,
   random_din(test_counter),
   random_ukey(test_counter),
   btnL,
   btnR,
   btnD,
   top_ready,
   ifhalt
   }
end;