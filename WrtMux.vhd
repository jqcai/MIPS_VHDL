----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2018 02:23:09 AM
-- Design Name: 
-- Module Name: WrtMux - Behavioral
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

entity WrtMux is
    Port ( 
--        reg destions
        rt : in std_logic_vector(4 downto 0);
        rd : in std_logic_vector(4 downto 0);
--        destion selector
        reg_dst : in std_logic;
        wrt_reg : out std_logic_vector(4 downto 0));
end WrtMux;

architecture Behavioral of WrtMux is

begin
wrt_reg <= rd when reg_dst = '1' else rt;

end Behavioral;
