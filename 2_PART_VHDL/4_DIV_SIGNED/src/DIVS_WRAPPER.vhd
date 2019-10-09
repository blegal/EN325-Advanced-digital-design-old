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

ENTITY DIVS_WRAPPER IS
	GENERIC (
		CONSTANT N : NATURAL := 8
	);
	PORT ( 
		CLOCK    : in  STD_LOGIC;
		INPUT_1  : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		INPUT_2  : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		OUTPUT_1 : out STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
END;

ARCHITECTURE behavior OF DIVS_WRAPPER IS
    
    SIGNAL BUF1 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL BUF2 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL BUF3 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN

	PROCESS (CLOCK)
	BEGIN
	   IF CLOCK'EVENT AND CLOCK = '1' THEN
           BUF1     <= INPUT_1;
           BUF2     <= INPUT_2;
	   END IF;
	END PROCESS;


    DIVIDER : ENTITY WORK.DIV_SIGNED
	GENERIC MAP ( N => N )
    PORT MAP(
		INPUT_1   => BUF1,
		INPUT_2   => BUF2,
		OUTPUT_1  => BUF3
    );


	PROCESS (CLOCK)
	BEGIN
	   IF CLOCK'EVENT AND CLOCK = '1' THEN
           OUTPUT_1 <= BUF3;
	   END IF;
	END PROCESS;

END;
