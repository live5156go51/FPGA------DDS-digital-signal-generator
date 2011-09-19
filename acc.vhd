-------------------------------------------------------------------------------
-- Title      : 相位累加器
-- Project    : 
-------------------------------------------------------------------------------
-- File       : acc.vhd
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
-- 2010-09-10  1.0      Yuweijia Lijunpeng       Created
-------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity acc is
  
  port (
    clr      : in  std_logic;
    clk      : in  std_logic;
    din      : in  std_logic_vector(23 downto 0);
    din_buff : in  std_logic_vector(23 downto 0);
    dout     : out std_logic_vector(23 downto 0));

end acc;

architecture behav_acc of acc is

  --signal q_tmp : std_logic_vector(23 downto 0);  -- 舍弃位数

begin  -- behav_acc

  process (clk)
  begin  -- process
--    dout <= din + din_buff;
    if clr = '1' then
                   dout <= (others => '0');
    else
      if rising_edge(clk) then
        --q_tmp <= din + din_buff;
        dout <= din + din_buff;
      end if;
    end if;
  end process;

end behav_acc;
