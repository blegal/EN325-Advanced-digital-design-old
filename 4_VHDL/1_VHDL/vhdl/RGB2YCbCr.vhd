----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:
-- Design Name:
-- Module Name:
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RGB2YCbCr is
  PORT (
    clk     : in  STD_LOGIC;
    i_data  : in  STD_LOGIC_VECTOR (23 downto 0);
    o_data  : out STD_LOGIC_VECTOR (23 downto 0);
    i_valid : in  STD_LOGIC;
    o_valid : out STD_LOGIC
  );
END RGB2YCbCr;

ARCHITECTURE Behavioral OF RGB2YCbCr IS

BEGIN



END Behavioral;
