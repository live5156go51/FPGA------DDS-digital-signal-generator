----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:42:48 12/23/2009 
-- Design Name: 
-- Module Name:    7 segment led display - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity x7segbc is
  port (x      : in  std_logic_vector (15 downto 0);
        cclk   : in  std_logic;
        clr    : in  std_logic;
        a_to_g : out std_logic_vector (6 downto 0);
        an     : out std_logic_vector (3 downto 0);

        dp    : out std_logic;
        dp_en : in  std_logic_vector (1 downto 0)  ---------------------

        );
end x7segbc;

architecture Behavioral of x7segbc is

  signal s     : std_logic_vector(1 downto 0);
  signal digit : std_logic_vector(3 downto 0);
  signal aen   : std_logic_vector(3 downto 0);

--  signal dp_en_tmp : std_logic_vector (1 downto 0);   --------------------

begin
--      dp_en_tmp <= dp_en;
--  dp     <= '0';
  aen(3) <= x(15) or x(14) or x(13) or x(12);
  aen(2) <= x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8);
--  aen(1) <= x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8) or x(7) or x(6) or x(5) or x(4);
  aen(1) <= '1';
  aen(0) <= '1';
  process(s)
  begin
    case s is
      when "00" =>
        digit                   <= x(3 downto 0);
        if dp_en = "00" then dp <= '1'; else dp <='0';
                                      end if;
      when "01" =>
        digit                   <= x(7 downto 4);
        if dp_en = "01" then dp <= '1'; else dp <='0';
                                      end if;
      when "10" =>
        digit                   <= x(11 downto 8);
        if dp_en = "10" then dp <= '1'; else dp <='0';
                                      end if;
      when others =>
        digit                   <= x(15 downto 12);
        if dp_en = "11" then dp <= '1'; else dp <='0';
                                      end if;
    end case;
  end process;

  process(digit)
  begin
    case digit is
      when x"0"   => a_to_g <= "1111110";  --"0000001";
      when x"1"   => a_to_g <= "0110000";  --"1001111";
      when x"2"   => a_to_g <= "1101101";  --"0010010";
      when x"3"   => a_to_g <= "1111001";  --"0000110";
      when x"4"   => a_to_g <= "0110011";  --"1001100";
      when x"5"   => a_to_g <= "1011011";  --"0100100";
      when x"6"   => a_to_g <= "1011111";  --"0100000";
      when x"7"   => a_to_g <= "1110000";  --"0001111";
      when x"8"   => a_to_g <= "1111111";  --"0000000";
      when x"9"   => a_to_g <= "1111011";  --"0000100";
      when x"A"   => a_to_g <= "1110111";  --"0001000";
      when x"B"   => a_to_g <= "0011111";  --"1100000";
      when x"C"   => a_to_g <= "1001110";  --"0110001";
      when x"D"   => a_to_g <= "0111101";  --"1000010";
      when x"E"   => a_to_g <= "1001111";  --"0110000";
      when others => a_to_g <= "1000111";  --"0111000";
    end case;
  end process;
  process(aen)
  begin
    an <= "0000";
    if(aen(conv_integer(s)) = '1') then
      an(conv_integer(s)) <= '1';
    end if;
  end process;
  process(cclk, clr)
  begin
    if(clr = '1') then
      s <= "00";
    elsif(rising_edge(cclk)) then
      s <= s+"01";
    end if;
  end process;
  
end Behavioral;

