----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/11/13 14:09:39
-- Design Name: 
-- Module Name: DATA_MEM - Behavioral
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATA_MEM is
    Port ( 
            clk: in std_logic;
            clr: in std_logic;   
            index:in std_logic_vector(7 downto 0);
            value:in std_logic_vector(7 downto 0);
--            index_out: in std_logic_vector(7 downto 0);
            btnU: in std_logic; --input button
            WD: in std_logic_vector(31 downto 0);
            WE: in std_logic;
            MemtoReg: in std_logic;
            ALUResult:in std_logic_vector(31 downto 0);
            op: out std_logic_vector(7 downto 0);
            RD: out std_logic_vector(31 downto 0)                            
    );
end DATA_MEM;

architecture Behavioral of DATA_MEM is

--Componet Control_Unit
--  port();
--End Component;





signal ram_addr: std_logic_vector(7 downto 0);
type data_mem is array (0 to 255 ) of std_logic_vector (7 downto 0);
constant ram_init : data_mem := (   
--                    0 => x"00",
--                    1 => x"00",
--                    2 => x"00",
--                    3 => x"00",    
--                    4 => x"00",
--                    5 => x"00",
--                    6 => x"00",
--                    7 => x"00",             
--                    8 => x"46",
--                    9 => x"F8",
--                    10 => x"E8",
--                    11 => x"C5",
--                    12 => x"46",
--                    13 => x"0C",
--                    14 => x"60",
--                    15 => x"85",
--                    16 => x"70",
--                    17 => x"F8",
--                    18 => x"3B",
--                    19 => x"8A",
--                    20 => x"28",
--                    21 => x"4B",
--                    22 => x"83",
--                    23 => x"03",
--                    24 => x"51",
--                    25 => x"3E",
--                    26 => x"14",
--                    27 => x"54",
--                    28 => x"F6",
--                    29 => x"21",
--                    30 => x"ED",
--                    31 => x"22",
--                    32 => x"31",
--                    33 => x"25",
--                    34 => x"06",
--                    35 => x"5D",
--                    36 => x"11",
--                    37 => x"A8",
--                    38 => x"3A",
--                    39 => x"5D",
--                    40 => x"D4",
--                    41 => x"27",
--                    42 => x"68",
--                    43 => x"6B",
--                    44 => x"71",
--                    45 => x"3A",
--                    46 => x"D8",
--                    47 => x"2D",
--                    48 => x"4B",
--                    49 => x"79",
--                    50 => x"2F",
--                    51 => x"99",
--                    52 => x"27",
--                    53 => x"99",
--                    54 => x"A4",
--                    55 => x"DD",
--                    56 => x"A7",
--                    57 => x"90",
--                    58 => x"1C",
--                    59 => x"49",
--                    60 => x"DE",
--                    61 => x"DE",
--                    62 => x"87",
--                    63 => x"1A",
--                    64 => x"36",
--                    65 => x"C0",
--                    66 => x"31",
--                    67 => x"96",
--                    68 => x"A7",
--                    69 => x"EF",
--                    70 => x"C2",
--                    71 => x"49",
--                    72 => x"61",
--                    73 => x"A7",
--                    74 => x"8B",
--                    75 => x"B8",
--                    76 => x"3B",
--                    77 => x"0A",
--                    78 => x"1D",
--                    79 => x"2B",
--                    80 => x"4D",
--                    81 => x"BF",
--                    82 => x"CA",
--                    83 => x"76",
--                    84 => x"AE",
--                    85 => x"16",
--                    86 => x"21",
--                    87 => x"67",
--                    88 => x"30",
--                    89 => x"D7",
--                    90 => x"6B",
--                    91 => x"0A",
--                    92 => x"43",
--                    93 => x"19",
--                    94 => x"23",
--                    95 => x"04",
--                    96 => x"F6",
--                    97 => x"CC",
--                    98 => x"14",
--                    99 => x"31",
--                    100 => x"65",
--                    101 => x"04",
--                    102 => x"63",
--                    103 => x"80",
                                              
                    104 => x"b7",--P
                    105 => x"e1",
                    106 => x"51",
                    107 => x"63",
                    
                    108 => x"9e", --Q
                    109 => x"37",
                    110 => x"79",
                    111 => x"b9",
                    
                    112 => x"e0", -- A cipher
                    113 => x"12",
                    114 => x"e6",
                    115 => x"45",
                    
                    116 => x"ca", -- B cipher
                    117 => x"83",
                    118 => x"8f",
                    119 => x"ab",
                    
                    128 => x"17",
                    129 => x"00",
                    130 => x"38",
                    131 => x"00",
                    132 => x"00",
                    133 => x"38",
                    134 => x"00",
                    135 => x"66",
                    
--                    148 => x"12",
--                    149 => x"34",
--                    150 => x"56",
--                    151 => x"78",
                    136 => x"90",
                    137 => x"12",
                    138 => x"34",
                    139 => x"56",
                    140 => x"12",
                    141 => x"34",
                    142 => x"56",
                    143 => x"78",
                    144 => x"90",
                    145 => x"12",
                    146 => x"34",
                    147 => x"56",
                    148 => x"12",
                    149 => x"34",
                    150 => x"56",
                    151 => x"78",
                    others => (others=>'0') );
signal RAM: data_mem := ram_init;

begin
    ram_addr <= ALUResult(7 downto 0);
    op <= ram(to_integer(unsigned(index(7 downto 0))));
    
    process(clk, clr)
        begin
            if clr = '1' then
                RAM<= ram_init;
            elsif(rising_edge(clk)) then
                if btnU = '1' then
                    ram(to_integer(unsigned(index))) <= value;
                end if;
                if(WE = '1') then
                    ram(to_integer(unsigned(ram_addr))) <= WD(7 downto 0);
                end if;
            end if;
    end process;
    RD <= "000000000000000000000000" & ram(to_integer(unsigned(ram_addr)));
end Behavioral;
