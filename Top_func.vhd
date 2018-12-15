----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/11/17 15:04:45
-- Design Name: 
-- Module Name: Top_func - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_func is
    port(
        clk: in std_logic;
        btnU,btnR,btnL,btnD: in std_logic;
        SSEG_CA: out STD_LOGIC_VECTOR (7 downto 0):="00000000";
        SW: in std_logic_vector(15 downto 0);
        AN: out STD_LOGIC_VECTOR (7 downto 0):="00000000";
        led: out std_logic:='0';
        btnC : in std_logic
    );
end Top_func;

architecture Behavioral of Top_func is

component Hex2LED --Converts a 4 bit hex value into the pattern to be displayed on the 7seg
port (CLK: in STD_LOGIC; X: in STD_LOGIC_VECTOR (3 downto 0); Y: out STD_LOGIC_VECTOR (7 downto 0)); 
end component; 

component ALU_control 
    Port (     
        instr: in std_logic_vector(31 downto 0);
        MemtoReg: out std_logic;
        MemWrite: out std_logic;
        Branch: out std_logic;
        ALUControl: out std_logic_vector(2 downto 0);
        ALUSrc: out std_logic;
        RegDst: out std_logic;
        RegWrite: out std_logic;
        ifHalt: out std_logic
 );
end component;

component ALU 
    port(
        Zero: out std_logic;
        SrcA: in std_logic_vector(31 downto 0);
        SrcB: in std_logic_vector(31 downto 0);
        ALUResult:out std_logic_vector(31 downto 0)
    );
end component;

component DATA_MEM 
    Port ( 
            clk: in std_logic;
            clr: in std_logic;   
            index:in std_logic_vector(7 downto 0);
            value:in std_logic_vector(7 downto 0);
            btnU: in std_logic; --input button   
--            sw: in std_logic_vector(7 downto 0);
            WD: in std_logic_vector(31 downto 0);
            WE: in std_logic;
            MemtoReg: in std_logic;
            ALUResult:in std_logic_vector(31 downto 0);
            op: out std_logic_vector(7 downto 0);
            RD: out std_logic_vector(31 downto 0)
    );
end component;

component PCBranch 
    Port (
        PCB_in1 : in std_logic_vector(31 downto 0);
        PCB_in2 : in std_logic_vector(31 downto 0);
        PCB_out : out std_logic_vector(31 downto 0));
end component;

component  RF 
    Port ( 
--        read reg address
        rd_reg1 : in std_logic_vector(4 downto 0);
        rd_reg2 : in std_logic_vector(4 downto 0);
--        write reg 
        wrt_reg : in std_logic_vector(4 downto 0);
        wrt_data : in std_logic_vector(31 downto 0);
        wrt_en: in std_logic;
--        read data
        rd_data1 : out std_logic_vector(31 downto 0);
        rd_data2 : out std_logic_vector(31 downto 0);
       
--        clk
        clr: in std_logic;
        clk    :     IN STD_LOGIC);
end component;

component  SignExtend 
    Port ( 
        sign_extend_in : in std_logic_vector(15 downto 0);
        sign_extend_out : out std_logic_vector(31 downto 0));
end component;

component WrtMux
    Port ( 
--        reg destions
        rt : in std_logic_vector(4 downto 0);
        rd : in std_logic_vector(4 downto 0);
--        destion selector
        reg_dst : in std_logic;
        wrt_reg : out std_logic_vector(4 downto 0));
end component;

component instruction_memory 
	PORT (
	   configuration_mode: in std_logic_vector(1 downto 0);
		readAddress : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component mux 
    Port ( 
        pc: in std_logic_vector(31 downto 0);
        ifHalt :in std_logic;
        mux_in1 : in std_logic_vector(31 downto 0);
        mux_in2 : in std_logic_vector(31 downto 0);
        mux_sel : in std_logic;
        btnL,btnR,btnD : in std_logic;
        mux_out : out std_logic_vector(31 downto 0));
end component;

component program_counter_adder 
	PORT (
		programCounterIn   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		programCounterOut  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component debounce 
  GENERIC(
    counter_size  :  INTEGER := 19); --counter size (19 bits gives 10.5ms with 50MHz clock)
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    button  : IN  STD_LOGIC;  --input signal to be debounced
    result  : OUT STD_LOGIC); --debounced signal
END component;

type arr is array(0 to 22) of std_logic_vector(7 downto 0);
signal NAME: arr;
signal Val : std_logic_vector(3 downto 0) := (others => '0');
signal HexVal: std_logic_vector(31 downto 0);
signal slowCLK: std_logic:='0';
signal i_cnt: std_logic_vector(19 downto 0):=x"00000";


signal op: std_logic_vector(7 downto 0);
signal Instr: std_logic_vector(31 downto 0) := x"00000000";
signal PC_next: std_logic_vector(31 downto 0);
signal PC: std_logic_vector(31 downto 0) := x"00000000";
signal PCPlus4: std_logic_vector(31 downto 0);
signal PCSrc: std_logic;
signal MemtoReg: std_logic;
signal MemWrite: std_logic;
signal Branch: std_logic;
signal ALUControl: std_logic_vector(2 downto 0);
signal ALUSrc: std_logic;
signal RegDst: std_logic;
signal RegWrite: std_logic;
signal SrcA: std_logic_vector(31 downto 0);
signal SrcB: std_logic_vector(31 downto 0);
signal WriteReg: std_logic_vector(4 downto 0);
signal SignImm: std_logic_vector(31 downto 0);
signal PCBranch_sig: std_logic_vector(31 downto 0);
signal Zero: std_logic;
signal ALUResult: std_logic_vector(31 downto 0);
signal WriteData: std_logic_vector(31 downto 0);
signal ReadData: std_logic_vector(31 downto 0);
signal Result: std_logic_vector(31 downto 0);
signal jump: std_logic;
signal real_new_pc: std_logic_vector(31 downto 0);
--signal result1: std_logic_vector(31 downto 0):= x"00000000";
--signal result2: std_logic_vector(31 downto 0):= x"00000000";
signal index: std_logic_vector(7 downto 0);
signal value: std_logic_vector(7 downto 0);
signal configuration_mode: std_logic_vector(1 downto 0):="00";
signal ifHalt: std_logic:='0';
--signal runningFlag: std_logic:='0';
signal interupt: std_logic:='0';
signal clr: std_logic:= '0';
TYPE StateType IS( initial_state, pressing_state, running_state, interupt_state);
signal state : StateType;
signal debounce_C,debounce_U,debounce_L,debounce_R,debounce_D:  std_logic;

begin
--TODO
clr <= interupt or debounce_C;
--process(clk, clr)
--begin
--    if clr ='1' then
--        pc <= x"00000000";
--    elsif rising_edge(clk) then
--        pc <= pc_next;
--    end if;
--end process;
process(clk,debounce_L,debounce_D,debounce_R,debounce_C,ifHalt)
    begin
        if debounce_C = '1'  then
            state <= initial_state;
        ELSIF(clk'EVENT AND clk='1') THEN
            case state IS
                When initial_state => 
                    pc <= x"00000000";
                    configuration_mode<="00";
                    interupt <= '0';
                    if  debounce_L='1' Then
                        state <= pressing_state;
                        configuration_mode<="01";                
                    elsif debounce_R = '1' Then
                        state <= pressing_state;
                        configuration_mode<="11";
                    elsif debounce_D = '1' Then 
                        state <= pressing_state; 
                        configuration_mode<="10";
                    End if;
                When pressing_state =>
                    interupt <= '0';
                    if debounce_L = '0' and debounce_R = '0' and debounce_D= '0' then
                        state <= running_state;
                    end if;
                When running_state => 
                    pc <= pc_next;
                    interupt <= '0';
                    if ifHalt = '1' then state <= initial_state; 
                    elsif (debounce_L = '1' or debounce_R = '1' or debounce_D = '1') Then state <= interupt_state;
                    End if;
                When interupt_state => 
                    interupt<='1';
                    configuration_mode<="00";
                    if debounce_L = '0' and debounce_R = '0' and debounce_D= '0' then
                        state <= initial_state;
                    end if;
            end case;
        end if;
end process;


--process(ifHalt)
--begin
--     if falling_edge(ifHalt) and runningFlag = '1'Then
--        runningFlag <= '0';
--        configuration_mode <= "00";
--    end if;
--end process;

--process(btnL,btnD,btnR, clr)
--begin
--    if clr = '1' Then 
--        runningFlag <= '0';
--        configuration_mode <= "00";   
--    elsif btnL='1' then
--          runningFlag <= '1';
--          configuration_mode<="01";
--    elsIf btnD='1' then
--        if runningFlag ='1'Then-- and ifHalt = '0' 
--            if ifHalt = '0' Then
--                interupt <= '1';
--            else
--                runningFlag <= '0';
--                configuration_mode <= "00";
--            end if;
--        else
--            runningFlag <= '1';
--            configuration_mode<="10";
--        end if;
--    elsif btnR='1' then
--        if runningFlag ='1'Then-- and ifHalt = '0' 
--            if ifHalt = '0' Then
--                interupt <= '1';
--            else
--                runningFlag <= '0';
--                configuration_mode <= "00";
--            end if;
--        else
--            runningFlag <= '1';
--            configuration_mode<="11";
--        end if;
--    end if;
--end process;

with configuration_mode select
 led<='1' when "00",
       '0' when others;


with instr(31 downto 26) select
jump<='1' when "001100",
      '0' when others;
with jump select
real_new_pc<="0000" & instr(25 downto 0) & "00" when '1',
              pcplus4 when others;
--process(btnc)


PCSrc <= Branch and Zero;

index <= sw(7 downto 0);
value <= sw(15 downto 8);



debounce_portmap_C: entity work.debounce
    port map(
    clk => clk,
    button => btnC, --input signal to be debounced
    result => debounce_C
); --debounced signal
debounce_portmap_L: entity work.debounce
    port map(
    clk => clk,
    button => btnL, --input signal to be debounced
    result => debounce_L
); --debounced signal
debounce_portmap_R: entity work.debounce
    port map(
    clk => clk,
    button => btnR, --input signal to be debounced
    result => debounce_R
); --debounced signal
debounce_portmap_D: entity work.debounce
    port map(
    clk => clk,
    button => btnD, --input signal to be debounced
    result => debounce_D
); --debounced signal
debounce_portmap_U: entity work.debounce
    port map(
    clk => clk,
    button => btnU, --input signal to be debounced
    result => debounce_U
); --debounced signal

Instruction_Mem: entity work.instruction_memory
    port map
    (
    configuration_mode=>configuration_mode,
    readAddress => pc,
    instruction => instr 
    );
Program_adder: entity work.program_counter_adder
    port map
    (
    programCounterIn => pc,
    programCounterOut => PCPlus4
    );

Register_File: entity work.RF
    port map(
    rd_reg1 => instr(25 downto 21), 
    rd_reg2 => instr(20 downto 16), 
    wrt_reg => WriteReg(4 downto 0), 
    wrt_data => Result, 
    wrt_en => RegWrite, 
    rd_data1 => SrcA, 
    rd_data2 => WriteData, 
    clr => clr,
    clk => clk);    
Write_Mux: entity work.WrtMux
    port map(
    rt => instr(20 downto 16),
    rd => instr(15 downto 11),
    reg_dst => RegDst,
    wrt_reg => WriteReg
    );

Sign_Extend: entity work.SignExtend
    port map(
    sign_extend_in => instr(15 downto 0),
    sign_extend_out => SignImm
    );
    
 PC_Branch: entity work.PCBranch
    port map(
    PCB_in1 => SignImm,
    PCB_in2 => PCPlus4,
    PCB_out => PCBranch_sig
    );
    
 ALU_port_map: entity work.ALU
    port map(
        Zero => Zero,
        SrcB => SrcB,
        ALUSrc => ALUSrc,
        ALUControl => ALUControl,
        SrcA => SrcA,
        ALUResult => ALUResult
    );
    
Data_Mem_port_map: entity work.DATA_MEM
    port map(
--        sw => SW,
        btnU => debounce_U,
        clr => clr,
        index => index,
        value => value,
        clk => clk,
        WD =>WriteData,
        WE => MemWrite,
        MemtoReg => MemtoReg,
        ALUResult => ALUResult,
        op => op,
        RD => ReadData
    );
ALU_Control_port_map: entity work.ALU_control 
        Port map(
            instr,
            MemtoReg,
            MemWrite,
            Branch,
            ALUControl,
            ALUSrc,
            RegDst,
            RegWrite,
            ifHalt);
            
mux_port_map: entity work.mux
    port map(
            pc => pc,
            ifHalt => ifHalt,
            mux_in1 => PCBranch_sig,
            mux_in2 =>  real_new_pc, 
            mux_sel =>  PCSrc,
            btnL => debounce_L,
            btnR => debounce_R,
            btnD => debounce_D,
            mux_out => PC_next
    );

mux_DM_map:  entity work.mux_DM
    Port map ( ReadData,
            ALUResult,
            MemtoReg,
            Result);
            
MUX_ALU_map: entity work.MUX_ALU
    Port map(
        SignImm,
        WriteData,
        ALUSrc,
        SrcB
     );

--Creating a slowCLK of 500Hz using the board's 100MHz clock----
process(clk)
begin
if (rising_edge(clk)) then
if (i_cnt=x"186A0")then --Hex(186A0)=Dec(100,000)
slowCLK<=not slowCLK; --slowCLK toggles once after we see 100000 rising edges of CLK. 2 toggles is one period.
i_cnt<=x"00000";
else
i_cnt<=i_cnt+'1';
end if;
end if;
end process;

-----We use the 500Hz slowCLK to run our 7seg display at roughly 60Hz-----
timer_inc_process : process (slowCLK)
begin
	if (rising_edge(slowCLK)) then
				if(Val="1000") then
				Val<="0001";
				else
				Val <= Val + '1'; --Val runs from 1,2,3,...8 on every rising edge of slowCLK
			end if;
		end if;
end process;
--timer_inc_process : process (btnc)
--begin
--	if (rising_edge(btnc)) then
--				if(Val="0100") then
--				Val<="0001";
--				else
--				Val <= Val + '1'; --Val runs from 1,2,3,...8 on every rising edge of slowCLK
--			end if;
--		end if;
--end process;

--This select statement selects one of the 7-segment diplay anode(active low) at a time. 
with Val select
	AN <= "01111111" when "0001",
				  "10111111" when "0010",
				  "11011111" when "0011",
				  "11101111" when "0100",
				  "11110111" when "0101",
				  "11111011" when "0110",
				  "11111101" when "0111",
				  "11111110" when "1000",
				  "11111111" when others;

--This select statement selects the value of HexVal to the necessary
--cathode signals to display it on the 7-segment
with Val select
	SSEG_CA<= NAME(0) when "0001", --NAME contains the pattern for each hex value to be displayed.
				  NAME(1) when "0010", --See below for the conversion
				  NAME(2) when "0011",
				  NAME(3) when "0100",
				  NAME(4) when "0101",
				  NAME(5) when "0110",
				  NAME(6) when "0111",
				  NAME(7) when "1000",
				  NAME(0) when others;

HexVal <= op & op & op & op;
              
--display rc5 result
--display:process(clk)
--begin
--if rising_edge(clk) then
--    if MemWrite = '1' then
--        if ALUResult = x"00000020" then
--            result1 <= WriteData;
--        elsif  ALUResult = x"00000021" then
--            result2 <= WriteData;
--        end if;
--    end if;
--end if;
--end process;


--Trying to display ABCD on the 7segment display by first sending it to 
--Hex2LED for converting each Hex value to a pattern to be given to the cathode.
CONV1: Hex2LED port map (CLK =>CLK, X => HexVal(31 downto 28), Y => NAME(0));
CONV2: Hex2LED port map (CLK => CLK, X => HexVal(27 downto 24), Y => NAME(1));
CONV3: Hex2LED port map (CLK =>CLK, X => HexVal(23 downto 20), Y => NAME(2));
CONV4: Hex2LED port map (CLK => CLK, X => HexVal(19 downto 16), Y => NAME(3));	
CONV5: Hex2LED port map (CLK =>CLK, X => HexVal(15 downto 12), Y => NAME(4));
CONV6: Hex2LED port map (CLK => CLK, X => HexVal(11 downto 8), Y => NAME(5));
CONV7: Hex2LED port map (CLK => CLK, X => HexVal(7 downto 4), Y => NAME(6));
CONV8: Hex2LED port map (CLK => CLK, X => HexVal(3 downto 0), Y => NAME(7));



end Behavioral;
