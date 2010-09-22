library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_arith.all;

entity latch is
  port (
        lock_in      : in  std_logic;
        cnt_to_latch : in  std_logic_vector(13 downto 0);
        latch_out    : out std_logic_vector(13 downto 0));
end latch;

architecture behav_latch of latch is

begin  -- behav_latch
  process (lock_in)
  begin  -- process
    if (lock_in'event and lock_in = '1') then
      latch_out <= cnt_to_latch;
    end if;
  end process;
end behav_latch;
