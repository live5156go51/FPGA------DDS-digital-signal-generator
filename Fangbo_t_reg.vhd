library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity Fangbo_t_reg is
  port (clk   : in  std_logic;
         din  : in  std_logic_vector (4 downto 0);
         dout : out std_logic_vector (4 downto 0)
         );
end Fangbo_t_reg;

architecture behav of Fangbo_t_reg is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      dout <= din;
    end if;
  end process;
  
end behav;
