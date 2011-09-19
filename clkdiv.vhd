-------------------------------------------------------------------------------
-- Title      : Fen pin qi    
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clkdiv.vhd
-- Author     :   <junstrix@gmail.com>
-- Company    : 
-- Created    : 2010-09-09
-- Last update: 2011-09-19
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author                  Description
-- 2010-09-09  1.0      Yuweijia Lijunpeng       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity clkdiv is
  
  port (
        clk_in    : in  std_logic;
        clk_out   : out std_logic;      --16.7Mhz
        clk_5hz   : out std_logic;
        clk_190hz : out std_logic);

end clkdiv;

architecture behav_clkdiv of clkdiv is

  constant L_bit_clk                  : integer   := 1;  -- 低位
  constant H_bit_clk                  : integer   := 2;  -- 高位
  signal   clkdiv_temp1, clkdiv_temp2 : std_logic := '0';
  signal   temp1, temp2               : integer range 0 to 10;

  signal q          : std_logic_vector(24 downto 0);  -- 190hz
  signal count      : std_logic_vector(27 downto 0);  -- 5hz
  signal clkdiv_tmp : std_logic;                      -- 计数翻转
  
begin  -- behav_clkdiv

  process (clk_in)
  begin  -- process
    if rising_edge(clk_in) then
      temp1 <= temp1 + 1;
      if temp1 = L_bit_clk then
        clkdiv_temp1 <= '1';
      elsif temp1 = H_bit_clk then
        clkdiv_temp1 <= '0';
        temp1        <= 0;
      end if;
    end if;
  end process;

  process (clk_in)
  begin  -- process
    if clk_in'event and clk_in = '0' then
      temp2 <= temp2 + 1;
      if temp2 = L_bit_clk then
        clkdiv_temp2 <= '1';
      elsif temp2 = H_bit_clk then
        clkdiv_temp2 <= '0';
        temp2        <= 0;
      end if;
    end if;
  end process;

  process (clkdiv_temp1, clkdiv_temp2)
  begin  -- process
    clk_out <= clkdiv_temp1 or clkdiv_temp2;  --50Mhz N分频
  end process;

  process (clk_in)
  begin  -- process
    if rising_edge(clk_in) then
      q <= q + 1;
      if (count = X"4C4B40") then
        count      <= (others => '0');
        clkdiv_tmp <= not clkdiv_tmp;
      else
        count <= count + 1;
      end if;
    end if;
  end process;
  clk_5hz   <= clkdiv_tmp;              --5hz
  clk_190hz <= q(17);                   --190hz
  
end behav_clkdiv;
