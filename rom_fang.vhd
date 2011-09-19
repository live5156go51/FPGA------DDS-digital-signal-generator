-------------------------------------------------------------------------------
-- Title      : ¥Ê¥¢±ÌROM ≤®–Œ—°‘Ò
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rom_fang.vhd
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

entity rom_fang is
  
  port (
    WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
    t_sel         : in  std_logic_vector(4 downto 0);
    din           : in  std_logic_vector(23 downto 0);
    dout          : out std_logic_vector(7 downto 0));

end rom_fang;

architecture behav_rom_fang of rom_fang is

  type rom_type is array (63 downto 0) of std_logic_vector (7 downto 0);
  -----------------------------------------------------------------------------
  --------------------------------------------------------------------------------------
  signal rom000 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                               X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                               X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                               X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"
                               );
  --
  signal rom05 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA"
                              );
  --
  signal rom10 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom15 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom20 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom25 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom30 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom35 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom40 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom45 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom50 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom55 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom60 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom65 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom70 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom75 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom80 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                               );
  --
  signal rom85 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom90 : rom_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                               );
  --
  signal rom95 : rom_type := (X"00", X"00", X"00", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                              X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                              );
  --
  signal rom100 : rom_type := (X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA",
                               X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA", X"FA"
                               );

  ------------------------------------------------------------
----------------------------------------------------------------------------

  signal BUF_MUL : std_logic_vector (23 downto 0);
  
begin  -- behav_rom_fang

  process(din)
    variable add  : integer range 0 to 63; 
    variable buff : integer range 0 to 255;  --2097152;   --1024*1024*2
  begin
    
    add := conv_integer(din) / 262144; 

               case t_sel is
      when "00001" =>
        BUF_MUL <= rom000(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00010" =>
        BUF_MUL <= rom05(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00011" =>
        BUF_MUL <= rom10(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00100" =>
        BUF_MUL <= rom15(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00101" =>
        BUF_MUL <= rom20(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00110" =>
        BUF_MUL <= rom25(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "00111" =>
        BUF_MUL <= rom30(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01000" =>
        BUF_MUL <= rom35(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01001" =>
        BUF_MUL <= rom40(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01010" =>
        BUF_MUL <= rom45(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01011" =>
        BUF_MUL <= rom50(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01100" =>
        BUF_MUL <= rom55(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01101" =>
        BUF_MUL <= rom60(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01110" =>
        BUF_MUL <= rom65(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "01111" =>
        BUF_MUL <= rom70(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10000" =>
        BUF_MUL <= rom75(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10001" =>
        BUF_MUL <= rom80(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10010" =>
        BUF_MUL <= rom85(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10011" =>
        BUF_MUL <= rom90(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10100" =>
        BUF_MUL <= rom95(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when "10101" =>
        BUF_MUL <= rom100(add) * WAVE_fix_Q_in;
        buff    := CONV_INTEGER(BUF_MUL) / 1024;
        dout    <= conv_std_logic_vector(buff, 8);
      when others => null;
                                          end case;
    
  end process;


end behav_rom_fang;
