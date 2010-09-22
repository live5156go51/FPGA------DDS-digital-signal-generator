----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:35:14 12/23/2009 
-- Design Name: 
-- Module Name:    binary convert bcd  - Behavioral 
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

entity decoder is
  port (b : in  std_logic_vector (13 downto 0);
        p : out std_logic_vector (16 downto 0));
end decoder;

architecture Behavioral of decoder is

begin
  process(b)
    variable z : std_logic_vector(32 downto 0);
  begin
    for i in 0 to 32 loop
      z(i) := '0';
    end loop;
    z(16 downto 3) := b;

    for j in 0 to 10 loop
      if(z(17 downto 14) > "0100") then
        z(17 downto 14) := z(17 downto 14) + "0011";
      end if;
      if(z(21 downto 18) > "0100") then
        z(21 downto 18) := z(21 downto 18) + "0011";
      end if;
      if(z(25 downto 22) > "0100") then
        z(25 downto 22) := z(25 downto 22) + "0011";
      end if;
      if(z(29 downto 26) > "0100") then
        z(29 downto 26) := z(29 downto 26) + "0011";
      end if;
      z(32 downto 1) := z(31 downto 0);
    end loop;
    p <= z(30 downto 14);
  end process;
  
end Behavioral;

