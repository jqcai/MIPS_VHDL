----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:43 11/16/2018 
-- Design Name: 
-- Module Name:    instruction_memory - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
	PORT (
		readAddress : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end instruction_memory;

architecture Behavioral of instruction_memory is
TYPE RAM_ARRAY IS ARRAY(0 TO 172) OF std_logic_vector(31 DOWNTO 0);
SIGNAL IM : RAM_ARRAY := (
"00000000000000000000000000000011",
"00000000100001000010000000000101",
"00000100100001000000000000000100",
"00000000101001010010100000000011",
"00000100101001010000000000011001",
"00000000110001100011000000000011",
"00000001001010010100100000000011",
"00000001010010100101000000000011",
"00000001011010110101100000000011",
"00000001100011000110000000000011",
"00000001101011010110100000000011",
"00000001110011100111000000000011",
"00000001111011110111100000000011",
"00000010000100001000000000000011",
"00000010001100011000100000000011",
"00000110001100010000000000011100",
"00010110001010110000000000011110",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010100100000000001",
"00000001001011100100100000000001",
"00000001001011110100100000000001",
"00000101011010110000000000000001",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010101000000000001",
"00000001010011100101000000000001",
"00000001010011110101000000000001",
"00000001011010110101100000000011",
"00000001100011000110000000000011",
"00000001101011010110100000000011",
"00000001110011100111000000000011",
"00000001111011110111100000000011",
"00000010000100001000000000000011",
"00000010001100011000100000000011",
"00000010010100101001000000000011",
"00000010011100111001100000000011",
"00000010100101001010000000000011",
"00000010101101011010100000000011",
"00010100101010110000000000011110",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010110000000000001",
"00000001100011100110000000000001",
"00000001100011110110000000000001",
"00000001010011001000000000000011",
"00001101001100010000000000011111",
"00101010001000000000000000000011",
"00010110000100000000000000000001",
"00001010001100010000000000000001",
"00110000000000000000000001000111",
"00000010000100001001000000001001",
"00000001001010011001100000001001",
"00000010010100111010000000001001",
"00000010000010011010100000001001",
"00000010100101010101000000001001",
"00001000101001010000000000000001",
"00000001011010110101100000000011",
"00000001100011000110000000000011",
"00000001101011010110100000000011",
"00000001110011100111000000000011",
"00000001111011110111100000000011",
"00000010000100001000000000000011",
"00000010001100011000100000000011",
"00000010010100101001000000000011",
"00000010011100111001100000000011",
"00000010100101001010000000000011",
"00000010101101011010100000000011",
"00010100101010110000000000011110",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010110000000000001",
"00000001100011100110000000000001",
"00000001100011110110000000000001",
"00000001001011001000000000000011",
"00001101010100010000000000011111",
"00101010001000000000000000000011",
"00010110000100000000000000000001",
"00001010001100010000000000000001",
"00110000000000000000000001101100",
"00000010000100001001000000001001",
"00000001010010101001100000001001",
"00000010010100111010000000001001",
"00000010000010101010100000001001",
"00000010100101010100100000001001",
"00001000101001010000000000000001",
"00000001011010110101100000000011",
"00000101011010110000000000000001",
"00101100101010111111111110111110",
"00000001011010110101100000000011",
"00000001100011000110000000000011",
"00000001101011010110100000000011",
"00000001110011100111000000000011",
"00000001111011110111100000000011",
"00010100101010110000000000011110",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010110000000000001",
"00000001100011100110000000000001",
"00000001100011110110000000000001",
"00000001010011000101000000000011",
"00000001011010110101100000000011",
"00000001100011000110000000000011",
"00000001101011010110100000000011",
"00000001110011100111000000000011",
"00000001111011110111100000000011",
"00001000101001010000000000000001",
"00010100101010110000000000011110",
"00011101011011000000000000000000",
"00010101100011000000000000001000",
"00000101011010110000000000000001",
"00011101011011010000000000000000",
"00010101101011010000000000010000",
"00000101011010110000000000000001",
"00011101011011100000000000000000",
"00010101110011100000000000011000",
"00000101011010110000000000000001",
"00011101011011110000000000000000",
"00000001100011010110000000000001",
"00000001100011100110000000000001",
"00000001100011110110000000000001",
"00000001001011000100100000000011",
"00000001011010110101100000000011",
"00010101001010010000000000011000",
"00100001011010010000000010011000",
"00000101011010110000000000000001",
"00100101011001001111111111111100",
"00000001011010110101100000000011",
"00010101010010100000000000011000",
"00100001011010100000000010011100",
"00000101011010110000000000000001",
"00100101011001001111111111111100",
"00110000000000000000000010101100"

);

begin

instruction <= IM((to_integer(unsigned(readAddress))/4)) when readAddress < x"00800000" else x"00000000";

end Behavioral;

