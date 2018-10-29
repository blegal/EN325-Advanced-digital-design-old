LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY detec_impulsion IS
PORT (
      CLOCK   : IN  STD_LOGIC;
      INPUT   : IN  STD_LOGIC;
      OUTPUT  : OUT STD_LOGIC
      );
END detec_impulsion;

ARCHITECTURE Behavioral OF detec_impulsion IS
	SIGNAL mem : STD_LOGIC := '0';
BEGIN

  PROCESS (CLOCK)
  BEGIN
    IF (CLOCK'EVENT AND CLOCK = '1') THEN
			MEM    <= INPUT;
			OUTPUT <= (MEM XOR INPUT) AND INPUT;
    END IF;
  END PROCESS;

END Behavioral;
