----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:55:27 01/06/2010 
-- Design Name: 
-- Module Name:    divider_generic - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_generic is
	GENERIC(
		N : INTEGER := 8
	);
	PORT (
				INPUT_1         : IN  Std_Logic_Vector(N-1 DOWNTO 0);
				INPUT_2         : IN  Std_Logic_Vector(N-1 DOWNTO 0);
				OUTPUT_1        : OUT Std_Logic_Vector(N-1 DOWNTO 0)
	);
end divider_generic;


architecture Behavioral of divider_generic is
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

end Behavioral;

