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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY MUL_SIGNED IS
	GENERIC (
		CONSTANT BITWIDTH : NATURAL := 16
	);
	PORT (
		INPUT_1  : in  STD_LOGIC_VECTOR(BITWIDTH-1 DOWNTO 0);
		INPUT_2  : in  STD_LOGIC_VECTOR(BITWIDTH-1 DOWNTO 0);
		OUTPUT_1 : out STD_LOGIC_VECTOR(BITWIDTH-1 DOWNTO 0)
		);
	END;

architecture behavior of MUL_SIGNED IS
BEGIN

	PROCESS (INPUT_1, INPUT_2)
	   VARIABLE TMP : SIGNED(2*BITWIDTH-1 DOWNTO 0);
	BEGIN
		TMP      :=  SIGNED( INPUT_1 ) * SIGNED( INPUT_2 );
		OUTPUT_1 <= STD_LOGIC_VECTOR( TMP(BITWIDTH-1 DOWNTO 0) );
	END PROCESS;

END;
