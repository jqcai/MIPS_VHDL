----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2018 06:58:37 PM
-- Design Name: 
-- Module Name: ALU_control - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_control is
Port (
instr: in std_logic_vector(31 downto 0);
MemtoReg: out std_logic;
MemWrite: out std_logic;
Branch: out std_logic;
ALUControl: out std_logic_vector(2 downto 0);
ALUSrc: out std_logic;
RegDst: out std_logic;
RegWrite: out std_logic:='0';
ifHalt: out std_logic:='0'
);
end ALU_control;

architecture Behavioral of ALU_control is
signal Op: std_logic_vector(5 downto 0);
signal Funct: std_logic_vector(5 downto 0);
signal ALUControl_0: std_logic_vector(2 downto 0);
signal ALUControl_1: std_logic_vector(2 downto 0);
begin
Op<=instr(31 downto 26);
Funct<=instr(5 downto 0);

with Op select 
ifHalt <= '1' when "111111",
          '0' when others;
with Op select
MemtoReg<='1' when "000111",
          '0' when others;
with Op select
MemWrite<='1' when "001000",
          '0' when others;
with Op select
Branch<='1' when "001001",
        '1' when "001010",
        '1' when "001011",
        '0' when others;
with Op select
ALUControl_1<="000" when "000001",
              "000" when "000111",
              "000" when "001000",
            "001" when "000010",
            "001" when "001010",
            "010" when "000011",
            "011" when "000100",
            "101" when "000101",
            "110" when "001011",
            "111" when others;--blt         
with Funct select
ALUControl_0<="000" when "000001",
            "001" when "000011",
            "010" when "000101",
            "011" when "000111",
            "100" when "001001",
            "111" when others;
with Op select
            ALUControl<=ALUControl_0 when "000000",
                        ALUControl_1 when others;
with Op select
ALUSrc<='0' when "000000",
        '0' when "001001",
        '0' when "001010",
        '0' when "001011",
        '1' when others;
with Op select
RegDst<='1' when "000000",
        '0' when others;

process(Op,Funct)
begin
case Op is 
when "000000" => 
    case Funct is
    when "000001" => RegWrite<='1';
    when "000011" => RegWrite<='1';
    when "000101" => RegWrite<='1';
    when "000111" => RegWrite<='1';
    when "001001" => RegWrite<='1';
    when others => RegWrite<='0';
    end case;
when "000001" => RegWrite<='1';
when "000010" => RegWrite<='1';
when "000011" => RegWrite<='1';
when "000100" => RegWrite<='1';
when "000101" => RegWrite<='1';
when "000111" => RegWrite<='1';
when others => RegWrite<='0';
end case;
end process;

--with Op & Funct select
--RegWrite<='0' when "001000",
--          '0' when "001001",
--          '0' when "001010",
--          '0' when "001011",
--          '0' when "001100",
--          '0' when "111111",
--          '1' when others;
--RegWrite<='1' when x"001",
--          '1' when x"003",
--          '1' when x"005",
--          '1' when x"007",
--          '1' when x"009",
--          '1' when x"040" to x"07f",
--          '1' when "" to x"0ff",
--          '1' when "000011000000" to "000011111111",
--          '1' when "000100",
--          '1' when "000101",
--          '1' when "000111",
--          '0' when others;
end Behavioral;
