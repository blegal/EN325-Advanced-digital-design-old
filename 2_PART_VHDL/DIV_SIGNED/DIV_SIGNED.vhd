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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DIV_SIGNED is
	GENERIC(
		N : INTEGER := 8
	);
	PORT (
	   INPUT_1  : IN  Std_Logic_Vector(N-1 DOWNTO 0);
	   INPUT_2  : IN  Std_Logic_Vector(N-1 DOWNTO 0);
	   OUTPUT_1 : OUT Std_Logic_Vector(N-1 DOWNTO 0)
	);
end DIV_SIGNED;

architecture arch of DIV_SIGNED is
begin

	PROCESS(INPUT_1, INPUT_2)
		VARIABLE A : UNSIGNED(2*N-2 DOWNTO 0);
		VARIABLE B : UNSIGNED(N-1   DOWNTO 0);
		VARIABLE Z : UNSIGNED(N-1   DOWNTO 0);
	BEGIN
		A := TO_UNSIGNED(0, N-1) & UNSIGNED( INPUT_1 );
		B := UNSIGNED( INPUT_2 );
		for Z in 0 to (N-1) loop
			IF A(2*N-2-Z downto 2*N-2-Z-(N-1)) >= B THEN
				A(2*N-2-Z downto 2*N-2-Z-(N-1)) := A(2*N-2-Z downto 2*N-2-Z-(N-1)) - B;
				OUTPUT_1(N-1-Z) <= '1';
			ELSE
				OUTPUT_1(N-1-Z) <= '0';
			END IF;
		END loop;
	END PROCESS;

end arch;

