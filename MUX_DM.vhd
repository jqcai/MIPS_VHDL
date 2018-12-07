----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/11/17 20:24:20
-- Design Name: 
-- Module Name: MUX_DM - Behavioral
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

entity MUX_DM is
    Port ( ReadData: in std_logic_vector(31 downto 0);
            ALUResult: in std_logic_vector(31 downto 0);
            MemtoReg: in std_logic;
            Result: out std_logic_vector(31 downto 0));
end MUX_DM;

architecture Behavioral of MUX_DM is

begin
    Result <= ReadData when MemtoReg = '1' else ALUResult;

end Behavioral;
