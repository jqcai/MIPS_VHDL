----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/11/13 14:09:16
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    port(
        Zero: out std_logic;
        SrcA: in std_logic_vector(31 downto 0);
        ALUSrc: in std_logic;--0 register/1 immediate number
        ALUControl:in std_logic_vector(2 downto 0); 
        SrcB:in std_logic_vector(31 downto 0);
        ALUResult:out std_logic_vector(31 downto 0)
    );
end ALU;

architecture Behavioral of ALU is

signal result: std_logic_vector(31 downto 0);


begin

    --SrcB
--    Process(ALUSrc, SignImm, RD2)
--        begin
--            if(ALUSrc='1')  Then SrcB <= SignImm;
--            else SrcB <= RD2;
--            end if;
--    End Process;
    
    --ALU
--    Process(ALUControl,SrcA,SrcB,)
    Process(ALUControl,ALUSrc,SrcA, SrcB)
        begin
            Case ALUControl is
                when "000" =>
                    result <= SrcA + SrcB; -- add
                    Zero <= '0';
                when "001" =>
                    result <= SrcA - SrcB; -- sub / beq
                    if SrcA=SrcB then zero<='1';
                    else zero<= '0';
                    end if;
                when "010" =>
                    result <= SrcA and SrcB; -- and
                    Zero <= '0';
                when "011" =>
                    result <= SrcA or SrcB; -- or 
                    Zero <= '0'; 
                when "100" =>
                    result <= SrcA nor SrcB; -- nor 
                    Zero <= '0';
                when "101" =>
                   case SrcB(4 downto 0) is
                        WHEN "00001"=>
                               result <= SrcA(0) & SrcA(31 DOWNTO 1);
                        WHEN "00010" =>
                                result <= SrcA(1 DOWNTO 0) & SrcA(31 DOWNTO 2);
                        WHEN "00011" =>
                            result<=  SrcA(2 DOWNTO 0) & SrcA(31 DOWNTO 3);
                        WHEN "00100" =>
                            result<= SrcA(3 DOWNTO 0) & SrcA(31 DOWNTO 4);
                        WHEN "00101"=>
                            result<= SrcA(4 DOWNTO 0) & SrcA(31 DOWNTO 5);
                        WHEN "00110" =>
                            result<=  SrcA(5 DOWNTO 0) & SrcA(31 DOWNTO 6);
                        WHEN "00111"=>
                            result<=  SrcA(6 DOWNTO 0) & SrcA(31 DOWNTO 7);
                        WHEN "01000"=>
                             result<=  SrcA(7 DOWNTO 0) & SrcA(31 DOWNTO 8);
                        WHEN "01001"=>
                              result<=  SrcA(8 DOWNTO 0) & SrcA(31 DOWNTO 9);
                        WHEN "01010"=>
                               result<=  SrcA(9 DOWNTO 0) & SrcA(31 DOWNTO 10);
                        WHEN "01011"=>
                               result<=  SrcA(10 DOWNTO 0) & SrcA(31 DOWNTO 11);
                        WHEN "01100"=>
                               result<=  SrcA(11 DOWNTO 0) & SrcA(31 DOWNTO 12);
                        WHEN "01101"=>
                               result<=  SrcA(12 DOWNTO 0) & SrcA(31 DOWNTO 13);
                        WHEN "01110"=>
                             result<=  SrcA(13 DOWNTO 0) & SrcA(31 DOWNTO 14);
                       WHEN "01111"=>
                              result<=  SrcA(14 DOWNTO 0) & SrcA(31 DOWNTO 15);
                       WHEN "10000"=>
                              result<=  SrcA(15 DOWNTO 0) & SrcA(31 DOWNTO 16);
                       WHEN "10001"=>
                              result<=  SrcA(16 DOWNTO 0) & SrcA(31 DOWNTO 17);
                       WHEN "10010"=>
                              result<=  SrcA(17 DOWNTO 0) & SrcA(31 DOWNTO 18);  
                        WHEN "10011"=>
                                result<=  SrcA(18 DOWNTO 0) & SrcA(31 DOWNTO 19);
                          WHEN "10100"=>
                                 result<=  SrcA(19 DOWNTO 0) & SrcA(31 DOWNTO 20);
                          WHEN "10101"=>
                                 result<=  SrcA(20 DOWNTO 0) & SrcA(31 DOWNTO 21);
                          WHEN "10110"=>
                                 result<=  SrcA(21 DOWNTO 0) & SrcA(31 DOWNTO 22);
                          WHEN "10111"=>
                                 result<=  SrcA(22 DOWNTO 0) & SrcA(31 DOWNTO 23);                                                          
                         WHEN "11000"=>
                               result<=  SrcA(23 DOWNTO 0) & SrcA(31 DOWNTO 24);
                         WHEN "11001"=>
                                result<=  SrcA(24 DOWNTO 0) & SrcA(31 DOWNTO 25);
                         WHEN "11010"=>
                                result<=  SrcA(25 DOWNTO 0) & SrcA(31 DOWNTO 26);
                        WHEN "11011"=>
                                       result<=  SrcA(26 DOWNTO 0) & SrcA(31 DOWNTO 27);                              
                         WHEN "11100"=>
                                result<=  SrcA(27 DOWNTO 0) & SrcA(31 DOWNTO 28);
                         WHEN "11101"=>
                                result<=  SrcA(28 DOWNTO 0) & SrcA(31 DOWNTO 29);  
                         WHEN "11110"=>
                                result<=  SrcA(29 DOWNTO 0) & SrcA(31 DOWNTO 30);
                         WHEN "11111"=>
                             result<=  SrcA(30 DOWNTO 0) & SrcA(31);
                         WHEN  others =>
                             result <= SrcA; 
                         end case;                                               
                   Zero <= '0';
                when "110" => --bne
                    result <= SrcA - SrcB; -- bne
                    if SrcA=SrcB then zero<='0';
                    else zero<= '1';
                    end if;
                when "111" =>  --blt
                    result <= SrcA - SrcB; 
                    if SrcA<SrcB then zero<='1';
                    else zero<= '0';
                    end if;
                when others => result <= SrcA + SrcB;
             End Case;                                                                              
    End Process;
    --Zero <= '1' when result=x"0000" else '0';
    ALUResult <= result;
end Behavioral;
