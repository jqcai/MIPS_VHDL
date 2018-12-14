library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
USE	IEEE.STD_LOGIC_TEXTIO.ALL;
USE	STD.TEXTIO.ALL;

entity Top_func_TB is			-- empty entity
end Top_func_TB;
architecture TB of Top_func_TB is
    -- initialize declared signals  
    signal clk: std_logic :='0';
    signal btnU,btnR,btnL,btnD: std_logic;
    signal VAL:std_logic_vector(7 downto 0);
    signal DST:std_logic_vector(7 downto 0);
    signal AN:  STD_LOGIC_VECTOR (7 downto 0):="00000000";
    signal led:  std_logic:='0';
    signal btnC : std_logic;
    constant half_period : time := 5 ns;
    constant clk_period : time := 10 ns;
    signal op: std_logic_vector(7 downto 0);
    signal din: std_logic_vector(191 downto 0);
    
component Top_func
    port(
        clk: in std_logic;
        btnU,btnR,btnL,btnD: in std_logic;
       
        
        SW: in std_logic_vector(15 downto 0);
        AN: out STD_LOGIC_VECTOR (7 downto 0):="00000000";
        led: out std_logic:='0';
        btnC : in std_logic
    );
    
    end component;
--sti_clk:PROCESS
--    BEGIN
--        clk<='0';
--        LOOP
--            WAIT FOR  half_period;
--            clk <= not clk;
--        END LOOP;
--    END PROCESS;
         
begin
  Test: Top_func port map (clk=>clk, btnU=>btnU, btnR=>btnR, btnL=>btnL, btnD=>btnD,  SW(15 downto 8)=>VAL, SW(7 downto 0)=>DST,  AN=>AN,  btnC=>btnC, led=>led);
  clk <= not clk after half_period;
--read_instruction_memory : PROCESS(clk)
--      FILE     mem           : TEXT; 
--      VARIABLE mem_line      : LINE;
--      VARIABLE read_byte     : STD_LOGIC_VECTOR(7 DOWNTO 0);     -- byte of read memory
--      VARIABLE line_counter  : INTEGER := 0;              -- counter to keep track of how many lines have already been read; it's initialized to 0 at the beginning of the process
--      VARIABLE target_line   : INTEGER;                   -- line to be read, computed according to "pc" (program counter)
--  BEGIN 
--      IF (clk'EVENT AND clk = '1') THEN 
--          file_open(mem, "instruction_memory.txt", READ_MODE);
--          target_line := 0;    
--          WHILE line_counter < (target_line + 4) LOOP
--              IF NOT endfile(mem) THEN                    -- discarded lines (don't correspond to the wanted lines)
--                  readline(mem, mem_line);
--                  IF line_counter >= target_line  THEN        -- subsequent four words are loaded
--                      read(mem_line, read_byte);
--                      VAL<=read_byte;
--                  END IF;
--              END IF;
--              line_counter := line_counter + 1;
--          END LOOP;
--          file_close(mem);
--      END IF;
--  END PROCESS read_instruction_memory;  
  process
     

  begin
        btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10000000";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10000001";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10000010";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10000011";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10000100";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10000101";
        btnU<='1';
        wait for clk_period; 
         btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10000110";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10000111";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10001000";
        btnU<='1';
        wait for clk_period;        
         btnU<='0';
         
        wait for clk_period; 
        VAL<="00000001";
        DST<="10001001";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10001010";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10001011";
        btnU<='1';
        wait for clk_period;    

        btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10001100";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10001101";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10001110";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10001111";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10010000";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10010001";
        btnU<='1';
        wait for clk_period; 
         btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10010010";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10010011";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10010100";
        btnU<='1';
        wait for clk_period;        
         btnU<='0';
        wait for clk_period; 
        VAL<="00000001";
        DST<="10010101";
        btnU<='1';
        wait for clk_period; 
        
        btnU<='0';
        wait for clk_period; 
        VAL<="00000011";
        DST<="10010110";
        btnU<='1';
        wait for clk_period; 
                
        btnU<='0';
        wait for clk_period; 
        VAL<="00000111";
        DST<="10010111";
        btnU<='1';
        wait for clk_period;    
                
  end process;
  
  --136-151 key
  --128-135 din

end TB;
