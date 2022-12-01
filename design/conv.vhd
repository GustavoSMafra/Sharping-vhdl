library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;

entity conv is 
  generic (
    PIXEL_WIDTH   : integer
  );
  port (
    i_PIX_01     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_10     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_11     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_12     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_21     : in unsigned(PIXEL_WIDTH-1 downto 0);
    o_RESULT : out integer
  );
end entity;

architecture arch of conv is
    signal w_PIX_MULT : integer;
begin

  w_PIX_MULT <= to_integer(i_PIX_11) * 4;
  o_RESULT <= w_PIX_MULT - to_integer(i_PIX_01) - to_integer(i_PIX_10) - to_integer(i_PIX_12) - to_integer(i_PIX_21);

end architecture;