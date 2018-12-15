----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:43:05 12/14/2018 
-- Design Name: 
-- Module Name:    testbench - Behavioral 
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
use ieee.std_logic_unsigned.all;
USE	IEEE.STD_LOGIC_TEXTIO.ALL;
USE	STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench2 is
end testbench2;

architecture Behavioral of testbench2 is

COMPONENT Top_func
port(
  clk: in std_logic;
  btnU,btnR,btnL,btnD: in std_logic;
  SW: in std_logic_vector(15 downto 0);
  led: out std_logic:='0';
  btnC : in std_logic;
  op_top: out std_logic_vector(7 downto 0)
);
END COMPONENT;

signal clk_s: std_logic;
signal btnU_s,btnR_s,btnL_s,btnD_s: std_logic := '0';
signal SW_s: std_logic_vector(15 downto 0) := (others => '0');
signal led_s: std_logic :='0';
signal btnC_s : std_logic := '0';
signal dout_s : std_logic_vector(63 downto 0) := (others => '0');
signal op_s : std_logic_vector(7 downto 0);
signal cnt : std_logic_vector(8 downto 0) := (others => '0');

CONSTANT  ClkPeriod	: Time := 10 ns;

begin

uut: Top_func PORT MAP(clk=>clk_s, btnU=>btnU_s, btnR=>btnR_s, btnL=>btnL_s, btnD=>btnD_s, 
SW=>SW_s, led=>led_s, btnC=>btnC_s, op_top=>op_s);

clk_gen: process        
begin
	loop
		 clk_s <= '0';
		 wait for ClkPeriod / 2;
		 clk_s <= '1';
		 wait for ClkPeriod / 2;
	end loop;
end process;

sti_din: PROCESS
		VARIABLE tmp_ukey: STD_LOGIC_VECTOR(127 DOWNTO 0);
      VARIABLE tmp_din: STD_LOGIC_VECTOR(63 DOWNTO 0);
		VARIABLE tmp_dout: STD_LOGIC_VECTOR(63 DOWNTO 0);
      VARIABLE l: LINE;
      VARIABLE good_val: BOOLEAN;
      VARIABLE space: CHARACTER;
      FILE vector_file: TEXT IS IN "enc_1.txt";
		
		BEGIN

   WHILE NOT ENDFILE(vector_file) LOOP
		
		cnt <= cnt+'1';
		
		-- reset
		btnC_s<='1';
		WAIT FOR 100 ns;
		btnC_s<='0';
		WAIT FOR 100 ns;
		
		-- read ukey
		READLINE(vector_file, l);
      hread(l, tmp_ukey, good_val);
		ASSERT good_val REPORT "Bad vector value";
		
		SW_s(15 downto 8)<=tmp_ukey(127 downto 120);
		SW_s(7 downto 0)<="10001000";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(119 downto 112);
		SW_s(7 downto 0)<="10001001";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(111 downto 104);
		SW_s(7 downto 0)<="10001010";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(103 downto 96);
		SW_s(7 downto 0)<="10001011";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(95 downto 88);
		SW_s(7 downto 0)<="10001100";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(87 downto 80);
		SW_s(7 downto 0)<="10001101";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(79 downto 72);
		SW_s(7 downto 0)<="10001110";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(71 downto 64);
		SW_s(7 downto 0)<="10001111";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(63 downto 56);
		SW_s(7 downto 0)<="10010000";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(55 downto 48);
		SW_s(7 downto 0)<="10010001";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(47 downto 40);
		SW_s(7 downto 0)<="10010010";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		
		SW_s(15 downto 8)<=tmp_ukey(39 downto 32);
		SW_s(7 downto 0)<="10010011";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(31 downto 24);
		SW_s(7 downto 0)<="10010100";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(23 downto 16);
		SW_s(7 downto 0)<="10010101";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(15 downto 8);
		SW_s(7 downto 0)<="10010110";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_ukey(7 downto 0);
		SW_s(7 downto 0)<="10010111";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		-- read din 
		READ(l, space);
		hread(l, tmp_din, good_val);
		ASSERT good_val REPORT "Bad vector value";
		
		SW_s(15 downto 8)<=tmp_din(63 downto 56);
		SW_s(7 downto 0)<="10000000";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(55 downto 48);
		SW_s(7 downto 0)<="10000001";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(47 downto 40);
		SW_s(7 downto 0)<="10000010";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(39 downto 32);
		SW_s(7 downto 0)<="10000011";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(31 downto 24);
		SW_s(7 downto 0)<="10000100";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(23 downto 16);
		SW_s(7 downto 0)<="10000101";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(15 downto 8);
		SW_s(7 downto 0)<="10000110";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		SW_s(15 downto 8)<=tmp_din(7 downto 0);
		SW_s(7 downto 0)<="10000111";
		btnU_s <= '1';
		wait for 10 ns;
		btnU_s <= '0';
		wait for 10 ns;
		
		
		-- key gen
		btnL_s <= '1';
		wait for 10 ns;
		btnL_s <= '0';

		while led_s = '0' LOOP 
			wait for 10 ns; 
		END LOOP;
	
		if (cnt = x"1") then
			-- enc/dec		
			btnD_s <= '1';
			wait for 10 ns;
			btnD_s <= '0';
			wait for 100 ns;
			
			btnR_s <= '1';
			wait for 10 ns;
			btnR_s <= '0';
				
			while led_s = '0' LOOP 
				wait for 10 ns; 
			END LOOP;
			
		elsif (cnt = x"2") then
			-- dec/enc			
			btnR_s <= '1';
			wait for 10 ns;
			btnR_s <= '0';
			wait for 100 ns;
			
			btnD_s <= '1';
			wait for 10 ns;
			btnD_s <= '0';
			
			while led_s = '0' LOOP 
				wait for 10 ns; 
			END LOOP;
		
		end if;

				
		SW_s(7 downto 0)<="10000000";
		wait for 10 ns;
		dout_s(63 downto 56)<=op_s;
		
		SW_s(7 downto 0)<="10000001";
		wait for 10 ns;
		dout_s(55 downto 48)<=op_s;
		
		SW_s(7 downto 0)<="10000010";
		wait for 10 ns;
		dout_s(47 downto 40)<=op_s;
		
		SW_s(7 downto 0)<="10000011";
		wait for 10 ns;
		dout_s(39 downto 32)<=op_s;
		
		SW_s(7 downto 0)<="10000100";
		wait for 10 ns;
		dout_s(31 downto 24)<=op_s;
		
		SW_s(7 downto 0)<="10000101";
		wait for 10 ns;
		dout_s(23 downto 16)<=op_s;
		
		SW_s(7 downto 0)<="10000110";
		wait for 10 ns;
		dout_s(15 downto 8)<=op_s;
		
		SW_s(7 downto 0)<="10000111";
		wait for 10 ns;
		dout_s(7 downto 0)<=op_s;
		
		-- compare
		READ(l, space);
		hread(l, tmp_dout, good_val);
		ASSERT good_val REPORT "Bad vector value";
		WAIT FOR 10 ns; -- Wait until the signal becomes stable
		ASSERT (tmp_dout = dout_s) REPORT "Output mismatch"; 
		REPORT "Output match";
		
		END LOOP;
WAIT;
END PROCESS;


end Behavioral;
