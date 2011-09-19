-------------------------------------------------------------------------------
-- Title      : ¥Ê¥¢±ÌROM ≤®–Œ—°‘Ò
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rom_sanjiao.vhd
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

entity rom_sanjiao is
  
  port (
    WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
    din           : in  std_logic_vector(23 downto 0);
    dout          : out std_logic_vector(7 downto 0));

end rom_sanjiao;

architecture behav_rom_sanjiao of rom_sanjiao is
  
  type rom_type is array (63 downto 0) of std_logic_vector (7 downto 0);
  signal rom : rom_type := (X"00", X"08", X"10", X"18",
                            X"20", X"28", X"30", X"38",
                            X"40", X"48", X"50", X"58",
                            X"60", X"68", X"70", X"78",
                            X"81", X"89", X"91", X"99",
                            X"A2", X"AA", X"B2", X"BA",
                            X"C3", X"CB", X"D3", X"DB",
                            X"E4", X"EC", X"F4", X"FC",
                            X"FC", X"F4", X"EC", X"E4",
                            X"DB", X"D3", X"CB", X"C3",
                            X"BA", X"B2", X"AA", X"A2",
                            X"99", X"91", X"89", X"81",
                            X"78", X"70", X"68", X"60",
                            X"58", X"50", X"48", X"40",
                            X"38", X"30", X"28", X"20",
                            X"18", X"10", X"08", X"00"
                            );

  signal BUF_MUL : std_logic_vector (23 downto 0);

begin  -- behav_rom_sanjiao

  process(din)
    variable add  : integer range 0 to 63;
    variable buff : integer range 0 to 255;  --2097152;   --1024*1024*2
  begin
    add := conv_integer(din) / 262144;

    BUF_MUL <= rom(add) * WAVE_fix_Q_in;
    buff    := CONV_INTEGER(BUF_MUL) / 1024;
    dout    <= conv_std_logic_vector(buff, 8);
  end process;


end behav_rom_sanjiao;
