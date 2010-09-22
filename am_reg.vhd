library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity am_reg is
  
  port (
--    clr  : in  std_logic;
    clk  : in  std_logic;               --5Hz
    din  : in  std_logic_vector(7 downto 0);
    dout : out std_logic_vector(7 downto 0)
    );

end am_reg;

architecture behav_am_reg of am_reg is
begin

  process(clk)
  begin  -- behav_am_reg
    if rising_edge(clk) then
      dout <= din;
    end if;
  end process;
  
end behav_am_reg;
