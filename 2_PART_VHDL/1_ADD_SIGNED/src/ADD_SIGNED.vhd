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

ENTITY ADD_SIGNED IS
	GENERIC (
		CONSTANT N : NATURAL := 64
	);
	PORT ( 
		INPUT_1  : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		INPUT_2  : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		OUTPUT_1 : out STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
END;

architecture behavior of ADD_SIGNED IS
BEGIN

	PROCESS (INPUT_1, INPUT_2)
	BEGIN
	   OUTPUT_1 <= STD_LOGIC_VECTOR( SIGNED(INPUT_1) + SIGNED(INPUT_2) );
	END PROCESS;

END;
