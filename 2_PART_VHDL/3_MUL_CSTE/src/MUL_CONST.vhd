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

ENTITY MUL_CONST IS
	GENERIC (
		CONSTANT BITWIDTH : NATURAL := 16
	);
	PORT ( 
		INPUT_1  : in  STD_LOGIC_VECTOR(BITWIDTH-1    DOWNTO 0);
		OUTPUT_1 : out STD_LOGIC_VECTOR(BITWIDTH-1 DOWNTO 0)
		);
	END;

architecture behavior of MUL_CONST IS
	CONSTANT MA_CONSTANTE : UNSIGNED := TO_UNSIGNED( 100, 10 ); -- CONSTANTE SUR 10 BITS
BEGIN

	PROCESS (INPUT_1)
	BEGIN
		OUTPUT_1 <= STD_LOGIC_VECTOR( RESIZE(UNSIGNED( INPUT_1 ) * MA_CONSTANTE, BITWIDTH) );
	END PROCESS;

END;
