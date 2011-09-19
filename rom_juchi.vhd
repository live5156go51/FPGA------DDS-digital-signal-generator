-------------------------------------------------------------------------------
-- Title      : ¥Ê¥¢±ÌROM ≤®–Œ—°‘Ò
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rom_juchi.vhd
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

entity rom_juchi is
  
  port (
    WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
    din           : in  std_logic_vector(23 downto 0);
    dout          : out std_logic_vector(7 downto 0));

end rom_juchi;

architecture behav_rom_juchi of rom_juchi is

  type rom_type is array (63 downto 0) of std_logic_vector (7 downto 0);
  signal rom : rom_type := (X"00", X"04", X"08", X"0C",
                            X"10", X"14", X"18", X"1C",
                            X"20", X"24", X"28", X"2C",
                            X"30", X"34", X"38", X"3C",
                            X"40", X"44", X"48", X"4C",
                            X"50", X"54", X"58", X"5C",
                            X"60", X"64", X"68", X"6C",
                            X"70", X"74", X"78", X"7C",
                            X"80", X"84", X"88", X"8C",
                            X"90", X"94", X"98", X"9C",
                            X"A0", X"A4", X"A8", X"AC",
                            X"B0", X"B4", X"B8", X"BC",
                            X"C0", X"C4", X"C8", X"CC",
                            X"D0", X"D4", X"D8", X"DC",
                            X"E0", X"E4", X"E8", X"EC",
                            X"F0", X"F4", X"F8", X"FC"
                            );

  signal BUF_MUL : std_logic_vector (23 downto 0);
  
begin  -- behav_rom_juchi

  process(din)
    variable add  : integer range 0 to 63;
    variable buff : integer range 0 to 255;  --2097152;   --1024*1024*2

  begin
    add := conv_integer(din) / 262144;

    BUF_MUL <= rom(add) * WAVE_fix_Q_in;
    buff    := CONV_INTEGER(BUF_MUL) / 1024;
    dout    <= X"FC" - conv_std_logic_vector(buff, 8);

  end process;


end behav_rom_juchi;
