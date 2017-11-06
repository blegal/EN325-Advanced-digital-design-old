----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    10:36:31 10/25/2016
-- Design Name:
-- Module Name:    RGB2YCBCR - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RGB2YCbCr is
    Port ( clk : in  STD_LOGIC;
           i_data : in  STD_LOGIC_VECTOR (23 downto 0);
           o_data : out  STD_LOGIC_VECTOR (23 downto 0);
           i_valid : in  STD_LOGIC;
           o_valid : out  STD_LOGIC);
end RGB2YCbCr;

architecture Behavioral of rgb2ycbcr_16b is

signal r : std_logic_vector(7 downto 0);
signal v : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);

signal y : signed(15 downto 0);
signal cb :signed(15 downto 0);
signal cr :signed(15 downto 0);

--constant c1 : signed(7 downto 0) := to_signed(integer(38.272),8);
--constant c2 : signed(7 downto 0) := to_signed(integer(75.136),8);
--constant c3 : signed(7 downto 0) := to_signed(integer(14.592),8);
--constant c4 : signed(7 downto 0) := to_signed(integer(-21.5936),8);
--constant c5 : signed(7 downto 0) := to_signed(integer(-42.4064),8);
--constant c6 : signed(7 downto 0) := to_signed(integer(64),8);
--constant c7 : signed(7 downto 0) := to_signed(integer(64),8);
--constant c8 : signed(7 downto 0) := to_signed(integer(53.5936),8);
--constant c9 : signed(7 downto 0) := to_signed(integer(10.4064),8);

constant c1 : signed(7 downto 0) := to_signed(38,8);
constant c2 : signed(7 downto 0) := to_signed(75,8);
constant c3 : signed(7 downto 0) := to_signed(14,8);
constant c4 : signed(7 downto 0) := to_signed(-21,8);
constant c5 : signed(7 downto 0) := to_signed(-42,8);
constant c6 : signed(7 downto 0) := to_signed(64,8);
constant c7 : signed(7 downto 0) := to_signed(64,8);
constant c8 : signed(7 downto 0) := to_signed(53,8);
constant c9 : signed(7 downto 0) := to_signed(10,8);

--signal r_temp : integer range 0 to 255;
--signal v_temp : integer range 0 to 255;
--signal b_temp : integer range 0 to 255;

signal r_temp : signed(8 downto 0);
signal v_temp : signed(8 downto 0);
signal b_temp : signed(8 downto 0);

--signal y_temp : integer range 0 to 255;
--signal cb_temp : integer range 0 to 255;
--signal cr_temp : integer range 0 to 255;

signal y_temp  : signed(16 downto 0);
signal cb_temp : signed(16 downto 0);
signal cr_temp : signed(16 downto 0);

signal tmp_o : std_logic;

begin

	b_temp <= (signed('0' & i_data(23 downto 16)));
	v_temp <= (signed('0' & i_data(15 downto 8)));
	r_temp <= (signed('0' & i_data(7 downto 0)));


	process (clk)
	begin
	if clk'event and clk='1' then
		if i_valid = '1' then
			y_temp <=  (((c1)) * r_temp + ((c2)) * v_temp + ((c3)) * b_temp);
			cb_temp <= (((c4)) * r_temp + ((c5)) * v_temp + ((c6)) * b_temp);
			cr_temp <= (((c7)) * r_temp + ((c8)) * v_temp + ((c9)) * b_temp);
			tmp_o <= '1';
		else
		  tmp_o <= '0';
		  y_temp <= y_temp;
          cb_temp <= cb_temp;
          cr_temp <=cr_temp;
		end if;



			o_data(23 downto 16) <= std_logic_vector(UNSIGNED(cr_temp(14 downto 7)) + TO_UNSIGNED(128, 8) );
			o_data(15 downto 8)  <= std_logic_vector(UNSIGNED(cb_temp(14 downto 7)) + TO_UNSIGNED(128, 8) );
    		o_data(7 downto 0)   <= std_logic_vector(UNSIGNED( y_temp(14 downto 7)) );
	        o_valid <= tmp_o;

	end if;

end process;



end Behavioral;
