----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:56 11/16/2018 
-- Design Name: 
-- Module Name:    program_counter_adder - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_counter_adder is
	PORT (
		programCounterIn   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		programCounterOut  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
--		jump: in std_logic;
--		intr: in std_logic(31 downto 0)
	);
end program_counter_adder;

architecture Behavioral of program_counter_adder is

-- signal address: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

begin

add4 : PROCESS (programCounterIn)
BEGIN
	programCounterOut <= programCounterIn + 4;
END PROCESS add4;

end Behavioral;

