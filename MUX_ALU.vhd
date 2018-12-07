----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/11/17 20:40:00
-- Design Name: 
-- Module Name: MUX_ALU - Behavioral
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

entity MUX_ALU is
    Port (
        SignImm: in std_logic_vector(31 downto 0);
        WriteData: in std_logic_vector(31 downto 0);
        ALUSrc: in std_logic;
        SrcB: out std_logic_vector(31 downto 0)
     );
end MUX_ALU;

architecture Behavioral of MUX_ALU is

begin
    SrcB <= SignImm when ALUSrc = '1' else WriteData;
end Behavioral;
