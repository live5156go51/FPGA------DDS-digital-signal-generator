----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:26:48 09/11/2010 
-- Design Name: 
-- Module Name:    dpdpdp - Behavioral 
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

entity dpdpdp is
  port (dpin  : in  std_logic_vector (1 downto 0);
        clk   : in  std_logic;
        dpout : out std_logic_vector (1 downto 0));
end dpdpdp;

architecture Behavioral of dpdpdp is

begin

  process(clk)
  begin
    if rising_edge(clk) then dpout <= dpin;
    end if;
  end process;

end Behavioral;

