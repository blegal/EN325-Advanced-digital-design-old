LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_misc.all;

ENTITY merger_8b_to_24b IS
    GENERIC(
        BITS : INTEGER := 18
    );
    PORT (
      RESET      : IN  STD_LOGIC;
      CLOCK      : IN  STD_LOGIC;
      ENABLE     : IN  STD_LOGIC;
      DATA_IN    : IN  STD_LOGIC_VECTOR ( 7 DOWNTO 0);
      
      DATA_OUT   : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
      DATA_READY : OUT STD_LOGIC
      );
END merger_8b_to_24b;

ARCHITECTURE Behavioral OF merger_8b_to_24b IS
    SIGNAL MERGED_DATA       : STD_LOGIC_VECTOR (23 DOWNTO 0);
    SIGNAL MERGE_VALID       : STD_LOGIC_VECTOR ( 2 DOWNTO 0);
BEGIN

    --
    -- GESTION DU SIGNAL DATA VALID EN SORTIE DU COMPOSANT
    --
    PROCESS (RESET, CLOCK)
    BEGIN
        IF RESET = '1' THEN
            MERGE_VALID       <= (OTHERS => '0');
        ELSIF (CLOCK'event AND CLOCK = '1') THEN
             IF MERGE_VALID = "111" THEN
                MERGE_VALID       <= (OTHERS => '0');
             ELSIF ENABLE = '1' THEN
                MERGE_VALID <= MERGE_VALID(1 DOWNTO 0) & '1';
             ELSE
                MERGE_VALID <= MERGE_VALID;
             END IF;
         END IF;
     END PROCESS;

    DATA_READY <= and_reduce(MERGE_VALID);

    --
    -- GESTION DU SIGNAL DATA VALID EN SORTIE DU COMPOSANT
    --
    PROCESS (RESET, CLOCK)
    BEGIN
        IF RESET = '1' THEN
            MERGED_DATA       <= (OTHERS => '0');
        ELSIF (CLOCK'event AND CLOCK = '1') THEN
             IF ENABLE = '1' THEN
                 MERGED_DATA       <= DATA_IN & MERGED_DATA(23 DOWNTO 8);
             ELSE
                 MERGED_DATA       <= MERGED_DATA;
             END IF;
         END IF;
     END PROCESS;
    
    DATA_OUT <= MERGED_DATA;

END Behavioral;