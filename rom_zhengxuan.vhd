-------------------------------------------------------------------------------
-- Title      : 存储表ROM 波形选择
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rom_zhengxuan.vhd
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

entity rom_zhengxuan is
  
  port (
    WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
    din           : in  std_logic_vector(23 downto 0);
    dout          : out std_logic_vector(7 downto 0));

end rom_zhengxuan;

architecture behav_rom_zhengxuan of rom_zhengxuan is

  type rom_type is array (63 downto 0) of std_logic_vector (7 downto 0);
--  signal rom : rom_type := (X"FF", X"FE", X"FC", X"F9", X"F5", X"EF", X"E9", X"E1",
--                            X"D9", X"CF", X"C5", X"BA", X"AE", X"A2", X"96", X"89",
--                            X"7C", X"70", X"63", X"57", X"4B", X"40", X"35", X"2B",
--                            X"22", X"1A", X"13", X"0D", X"08", X"04", X"01", X"00",
--                            X"00", X"01", X"04", X"08", X"0D", X"13", X"1A", X"22",
--                            X"2B", X"35", X"40", X"4B", X"57", X"63", X"70", X"7C",
--                            X"89", X"96", X"A2", X"AE", X"BA", X"C5", X"CF", X"D9",
--                            X"E1", X"E9", X"EF", X"F5", X"F9", X"FC", X"FE", X"FF");
--修正值如下！！！
  signal rom : rom_type := (X"FC", X"FB", X"F9", X"F6", X"F2", X"EC", X"E6", X"DE",
                            X"D6", X"CC", X"C3", X"B8", X"AC", X"A0", X"94", X"87",
                            X"7A", X"6C", X"62", X"56", X"4A", X"3F", X"34", X"2A",
                            X"21", X"19", X"12", X"0C", X"07", X"03", X"01", X"00",
                            X"00", X"01", X"03", X"07", X"0C", X"12", X"19", X"21",
                            X"2A", X"34", X"3F", X"4A", X"56", X"62", X"6C", X"7A",
                            X"87", X"94", X"A0", X"AC", X"B8", X"C3", X"CC", X"D6",
                            X"DE", X"E6", X"EC", X"F2", X"F6", X"F9", X"FB", X"FC");

  signal BUF_MUL : std_logic_vector (23 downto 0);

begin  -- behav_rom_zhengxuan

  process(din)
    variable add  : integer range 0 to 63;
    variable buff : integer range 0 to 255;  --2097152;   --1024*1024*2
  begin
    add     := conv_integer(din) / 262144;
    BUF_MUL <= rom(add) * WAVE_fix_Q_in;
    buff    := CONV_INTEGER(BUF_MUL) / 1024;
    dout    <= conv_std_logic_vector(buff, 8);
  end process;

end behav_rom_zhengxuan;

