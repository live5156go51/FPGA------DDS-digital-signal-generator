----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:16:17 09/11/2010 
-- Design Name: 
-- Module Name:    mux4t - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux4t is
  port (din_zhengxuan : in  std_logic_vector (7 downto 0);
        din_sanjiao   : in  std_logic_vector (7 downto 0);
        din_juchi     : in  std_logic_vector (7 downto 0);
        din_fang      : in  std_logic_vector (7 downto 0);
        w_sel         : in  std_logic_vector (1 downto 0);
        dout          : out std_logic_vector (7 downto 0));
end mux4t;

architecture Behavioral of mux4t is

begin

  process (din_zhengxuan, din_sanjiao, din_juchi, din_fang, w_sel)
  begin  -- process
    case w_sel is
      when "00"   => dout <= din_zhengxuan;
      when "01"   => dout <= din_sanjiao;
      when "10"   => dout <= din_juchi;
      when others => dout <= din_fang;
    end case;
  end process;

end Behavioral;

