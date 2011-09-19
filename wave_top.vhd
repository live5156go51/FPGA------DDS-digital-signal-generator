-------------------------------------------------------------------------------
-- Title      : make four waves of top file
-- Project    : 
-------------------------------------------------------------------------------
-- File       : wave_top.vhd
-- Author     :   <junstrix@gmail.com>
-- Company    : 
-- Created    : 2010-09-23
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
-- 2010-09-23  1.0      Yuweijia Lijunpeng       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity wave_top is
  
  port (
    t_sel_in   : in std_logic_vector(4 downto 0);  -- t: 5%~95%
    WAVE_fix_Q : in std_logic_vector(10 downto 0);

    data_in  : in  std_logic_vector(23 downto 0);
    w_sel    : in  std_logic_vector(1 downto 0);
    data_out : out std_logic_vector(7 downto 0));

end wave_top;


architecture behav_wave_top of wave_top is
  component rom_zhengxuan
    port (
      WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
      din           : in  std_logic_vector(23 downto 0);
      dout          : out std_logic_vector(7 downto 0));
  end component;
  component rom_sanjiao
    port (
      WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
      din           : in  std_logic_vector(23 downto 0);
      dout          : out std_logic_vector(7 downto 0));
  end component;
  component rom_juchi
    port (
      WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
      din           : in  std_logic_vector(23 downto 0);
      dout          : out std_logic_vector(7 downto 0));
  end component;
  component rom_fang
    port (
      WAVE_fix_Q_in :     std_logic_vector(10 downto 0);
      t_sel         : in  std_logic_vector(4 downto 0);  -- t: 5%~95%
      din           : in  std_logic_vector(23 downto 0);
      dout          : out std_logic_vector(7 downto 0));
  end component;

  component mux4t
    port (
      din_zhengxuan : in  std_logic_vector(7 downto 0);
      din_sanjiao   : in  std_logic_vector(7 downto 0);
      din_juchi     : in  std_logic_vector(7 downto 0);
      din_fang      : in  std_logic_vector(7 downto 0);
      w_sel         : in  std_logic_vector(1 downto 0);
      dout          : out std_logic_vector(7 downto 0));
  end component;

  signal rom_to_mux1_tmp : std_logic_vector(7 downto 0);
  signal rom_to_mux2_tmp : std_logic_vector(7 downto 0);
  signal rom_to_mux3_tmp : std_logic_vector(7 downto 0);
  signal rom_to_mux4_tmp : std_logic_vector(7 downto 0);

  signal t_sel_in_tmp   : std_logic_vector(4 downto 0);
  signal WAVE_fix_Q_tmp : std_logic_vector(10 downto 0);

  
begin  -- behav_wave_top

  t_sel_in_tmp   <= t_sel_in;
  WAVE_fix_Q_tmp <= WAVE_fix_Q;


  WAVE1 : rom_zhengxuan port map (
    WAVE_fix_Q_in => WAVE_fix_Q_tmp,
    din           => data_in,
    dout          => rom_to_mux1_tmp);

  WAVE2 : rom_sanjiao port map (
    WAVE_fix_Q_in => WAVE_fix_Q_tmp,
    din           => data_in,
    dout          => rom_to_mux2_tmp);
  WAVE3 : rom_juchi port map (
    WAVE_fix_Q_in => WAVE_fix_Q_tmp,
    din           => data_in,
    dout          => rom_to_mux3_tmp);
  WAVE4 : rom_fang port map (
    WAVE_fix_Q_in => WAVE_fix_Q_tmp,
    t_sel         => t_sel_in_tmp,      -- t: 5%~95%
    din           => data_in,
    dout          => rom_to_mux4_tmp);
  MUX4 : mux4t port map (
    din_zhengxuan => rom_to_mux1_tmp,
    din_sanjiao   => rom_to_mux2_tmp,
    din_juchi     => rom_to_mux3_tmp,
    din_fang      => rom_to_mux4_tmp,
    w_sel         => w_sel,
    dout          => data_out);

end behav_wave_top;
