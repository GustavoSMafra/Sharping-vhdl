library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;

entity sharping is
  generic (
    PIXEL_WIDTH   : integer
  );
  port (
    i_CLK        : in std_logic;
    i_ENB        : in std_logic;
    i_PIX_01     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_10     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_11     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_12     : in unsigned(PIXEL_WIDTH-1 downto 0);
    i_PIX_21     : in unsigned(PIXEL_WIDTH-1 downto 0);
    o_PIX_RESULT : out std_logic_vector(PIXEL_WIDTH-1 downto 0)
  );
end entity;

architecture arch of sharping is
    signal w_PIX_MULT : integer;
    signal w_RESULT_CONV : integer;
    signal w_RESULT : integer;
    signal w_PIX_RESULT_U : unsigned(PIXEL_WIDTH-1 downto 0) := "00000000";
    
  component clipper
    port (
      i_CLK        : in std_logic;
      i_ENB        : in std_logic;
      i_Q          : in integer;
      o_R          : out integer
    );
  end component;
  
  component conv
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
  end component;
    
begin

  u_conv : conv
      generic map ( PIXEL_WIDTH => PIXEL_WIDTH )
      port map (
        i_PIX_01 => i_PIX_01,
        i_PIX_10 => i_PIX_10,
        i_PIX_11 => i_PIX_11, 
        i_PIX_12 => i_PIX_12,
        i_PIX_21 => i_PIX_21,
        o_RESULT => w_RESULT_CONV
      );
      
  u_clipper : clipper
      port map (
        i_CLK  => i_CLK,
        i_ENB => i_ENB,
        i_Q => w_RESULT_CONV,
        o_R => w_RESULT
 
      );

  o_PIX_RESULT   <= std_logic_vector(to_unsigned(w_RESULT, 8));

end architecture;