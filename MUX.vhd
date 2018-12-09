----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2018 02:31:43 AM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    Port ( 
        pc: in std_logic_vector(31 downto 0);
        ifHalt : in std_logic;
        mux_in1 : in std_logic_vector(31 downto 0);
        mux_in2 : in std_logic_vector(31 downto 0);
        mux_sel : in std_logic;
        btnL,btnR,btnD : in std_logic;
        mux_out : out std_logic_vector(31 downto 0)
        );
end mux;

architecture Behavioral of mux is

begin
    process(ifHalt,btnL,btnR,btnD,mux_sel,mux_in1,mux_in2)
        begin
            if(ifHalt = '1') Then
                mux_out <= pc;
            elsif(mux_sel = '1') Then
                mux_out <= mux_in1;
            else 
                mux_out <= mux_in2;
            end if;
         if(btnL = '1' or btnR = '1' or btnD = '1') Then
            mux_out <= X"00000000";
         end if;
    end process;
--    mux_out <= mux_in1 when mux_sel = '1' else mux_in2;
end Behavioral;
