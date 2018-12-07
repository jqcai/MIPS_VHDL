----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2018 02:08:41 AM
-- Design Name: 
-- Module Name: PCBranch - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCBranch is
    Port (
        PCB_in1 : in std_logic_vector(31 downto 0);
        PCB_in2 : in std_logic_vector(31 downto 0);
        PCB_out : out std_logic_vector(31 downto 0));
end PCBranch;

architecture Behavioral of PCBranch is
signal PCB_in1_sl : std_logic_vector(31 downto 0);

begin
PCB_in1_sl <= PCB_in1(29 downto 0) & "00";
PCB_out <= std_logic_vector(unsigned(PCB_in1_sl)+unsigned(PCB_in2));

end Behavioral;
