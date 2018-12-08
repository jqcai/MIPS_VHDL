----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2018 12:33:53 AM
-- Design Name: 
-- Module Name: RF - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
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
        clr : in std_logic;
        clk    :     IN STD_LOGIC);
end RF;

architecture Behavioral of RF is
type reg_addr is array(31 downto 0) of std_logic_vector(31 downto 0);
signal reg:reg_addr:=(others=>x"00000000");

--signal last_wrt_data: std_logic_vector(31 downto 0);
--signal last_wrt_en: std_logic;
--signal last_wrt_reg : std_logic_vector(4 downto 0);
--signal rd_data1_temp:std_logic_vector(31 downto 0);
--signal rd_data2_temp:std_logic_vector(31 downto 0);
begin

process(clk, wrt_en, clr)
begin
--if falling_edge(clk) then
--    last_wrt_data<=wrt_data;
--    last_wrt_en<=wrt_en;
--    last_wrt_reg<=wrt_reg;
--end if;
if clr = '1' then reg <= (others => x"00000000");
elsif rising_edge(clk) then
--if clk'event then
    
   	if wrt_en = '1' then 
		reg(to_integer(unsigned(wrt_reg))) <= wrt_data; 
	end if;
end if;

end process;

rd_data1 <= reg(to_integer(unsigned(rd_reg1)));
rd_data2 <= reg(to_integer(unsigned(rd_reg2)));
    

end Behavioral;
