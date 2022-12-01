library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;

entity clipper is
  port (
    i_CLK        : in std_logic;
    i_ENB        : in std_logic;
    i_Q          : in integer;
    o_R          : out integer
  );
end entity;

architecture arch of clipper is
begin

  process(i_CLK)
  begin
    if (i_ENB = '1') then
      if (i_Q > 255) then
        o_R <= 255;
      elsif (i_Q < 0) then
        o_R <= 0;
      else
        o_R <= i_Q;
      end if;
    else 
      o_R <= 0;
    end if;
  end process;

end architecture;