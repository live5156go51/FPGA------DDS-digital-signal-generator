library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity mux2t is
  
  port (
    v_din : in std_logic_vector(13 downto 0);
    f_din : in std_logic_vector(13 downto 0);
    t_din : in std_logic_vector(13 downto 0);

    MODE_SEL : in  std_logic_vector(1 downto 0);
    dout     : out std_logic_vector(13 downto 0));

end mux2t;

architecture behav_mux2t of mux2t is
begin

  process (MODE_SEL)
  begin
    case MODE_SEL is
      when "00"   => dout <= f_din;
      when "01"   => dout <= t_din;
      when "10"   => dout <= v_din;
      when others => dout <= v_din;
    end case;
  end process;
  
end behav_mux2t;
