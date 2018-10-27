library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_signed.all; 
use IEEE.numeric_std.all; 

entity RGB2YCbCr is
port(
    clk     : in  STD_LOGIC;
    i_data  : in  STD_LOGIC_VECTOR(23 downto 0);
    o_data  : out STD_LOGIC_VECTOR(23 downto 0);
    i_valid : in  STD_LOGIC;
    o_valid : out STD_LOGIC
);
end RGB2YCbCr;

architecture rtl2 of RGB2YCbCr is
	constant s_rgb_30  : STD_LOGIC_VECTOR(16 downto 0) := "00100110010001011";
constant s_rgb_59  : STD_LOGIC_VECTOR(16 downto 0) := "01001011001000101";
constant s_rgb_11  : STD_LOGIC_VECTOR(16 downto 0) := "00001110100101111";
constant s_rgb_17  : STD_LOGIC_VECTOR(16 downto 0) := "00010101100110010";
constant s_rgb_33  : STD_LOGIC_VECTOR(16 downto 0) := "00101010011001101";
constant s_rgb_50  : STD_LOGIC_VECTOR(16 downto 0) := "01000000000000000";
constant s_rgb_42  : STD_LOGIC_VECTOR(16 downto 0) := "00110101100101111";
constant s_rgb_08  : STD_LOGIC_VECTOR(16 downto 0) := "00001010011010000";
constant s_rgb_128 : STD_LOGIC_VECTOR(23 downto 0) := "100000000000000000000000";

SIGNAL rgb_in_r    : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL rgb_in_g   : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL rgb_in_b   : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL rgb_out_y  : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL rgb_out_cb : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL rgb_out_cr : STD_LOGIC_VECTOR(7 downto 0);

begin

rgb_in_r <= i_data( 7 downto  0);
rgb_in_g <= i_data(15 downto  8);
rgb_in_b <= i_data(23 downto 16);
      
o_data( 7 downto  0) <= rgb_out_y;
o_data(15 downto  8) <= rgb_out_cb;
o_data(23 downto 16) <= rgb_out_cr;

process(clk)
    variable s_rgb_out_y  : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    variable s_rgb_out_cb : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    variable s_rgb_out_cr : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
begin
  if clk'event and clk='1' then
     if i_valid='1' then
        s_rgb_out_y  := s_rgb_30 * ('0' & rgb_in_r) + s_rgb_59 * ('0' & rgb_in_g) + s_rgb_11 * ('0' & rgb_in_b);
        s_rgb_out_cb := s_rgb_128 - s_rgb_17 * ('0' & rgb_in_r) - s_rgb_33 * ('0' & rgb_in_g) + s_rgb_50*('0' & rgb_in_b);
        s_rgb_out_cr := s_rgb_128 + s_rgb_50 * ('0' & rgb_in_r) - s_rgb_42 * ('0' & rgb_in_g) - s_rgb_08*('0' & rgb_in_b);

        if (s_rgb_out_y(15)='1') then
            rgb_out_y  <= s_rgb_out_y(23 downto 16) + 1;
        else
            rgb_out_y  <= s_rgb_out_y(23 downto 16);
        end if;
        
        if (s_rgb_out_cb(15)='1') then
            rgb_out_cb <= s_rgb_out_cb(23 downto 16) + 1;
        else
            rgb_out_cb <= s_rgb_out_cb(23 downto 16);
        end if;
        
        if (s_rgb_out_cr(15)='1') then
            rgb_out_cr <= s_rgb_out_cr(23 downto 16) + 1;
        else
            rgb_out_cr <= s_rgb_out_cr(23 downto 16);
        end if;
        o_valid <= '1';
     else
        o_valid <= '0';
        rgb_out_y     <= (others => '0');
        rgb_out_cb    <= (others => '0');
        rgb_out_cr    <= (others => '0');
     end if;
     end if;
end process;

end rtl2;
