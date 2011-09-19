-------------------------------------------------------------------------------
-- Title      : 相位增量寄存器
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reg.vhd
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

entity reg is
  
  port (
--    clr : in std_logic;
        clk  : in  std_logic;
        din  : in  std_logic_vector(23 downto 0);
        dout : out std_logic_vector(23 downto 0));

end reg;

architecture behav_reg of reg is

begin  -- behav_reg

  process (clk)
  begin  -- process
    if rising_edge(clk) then
      dout <= din;
    end if;
  end process;
--    process(clr)
--  begin
--  if clr = '1' then 
--      dout <= (others => '0');
--  end if;
--  end process;
--  
end behav_reg;
