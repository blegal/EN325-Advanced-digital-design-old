LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_misc.all;

ENTITY splitter_24b_to_8b IS
    PORT (
      RESET      : IN  STD_LOGIC;
      CLOCK      : IN  STD_LOGIC;
      ENABLE     : IN  STD_LOGIC;
      DATA_IN    : IN  STD_LOGIC_VECTOR (23 DOWNTO 0);
      DATA_OUT   : OUT STD_LOGIC_VECTOR ( 7 DOWNTO 0);
      DATA_READY : OUT STD_LOGIC
      );
END splitter_24b_to_8b;

ARCHITECTURE Behavioral OF splitter_24b_to_8b IS
    SIGNAL MERGED_DATA : STD_LOGIC_VECTOR (23 DOWNTO 0);
    SIGNAL MERGE_VALID : STD_LOGIC_VECTOR ( 2 DOWNTO 0);
BEGIN

    --
    -- GESTION DU SIGNAL DATA VALID EN SORTIE DU COMPOSANT
    --
    PROCESS (RESET, CLOCK)
    BEGIN
        IF RESET = '1' THEN
            MERGE_VALID       <= (OTHERS => '0');
        ELSIF (CLOCK'event AND CLOCK = '1') THEN
             IF ENABLE = '1' THEN
                MERGE_VALID <= "111";
             ELSE
                MERGE_VALID <= MERGE_VALID(1 downto 0) & '0';
             END IF;
         END IF;
     END PROCESS;

    DATA_READY <= or_reduce(MERGE_VALID);

    --
    -- GESTION DU SIGNAL DATA VALID EN SORTIE DU COMPOSANT
    --
    PROCESS (RESET, CLOCK)
    BEGIN
        IF RESET = '1' THEN
            MERGED_DATA       <= (OTHERS => '0');
        ELSIF (CLOCK'event AND CLOCK = '1') THEN
             IF ENABLE = '1' THEN
                 MERGED_DATA <= DATA_IN;
             ELSE
                 MERGED_DATA <= MERGED_DATA;
             END IF;
         END IF;
     END PROCESS;
    
    DATA_OUT <= MERGED_DATA( 7 downto  0) WHEN MERGE_VALID = "111" ELSE
                MERGED_DATA(15 downto  8) WHEN MERGE_VALID = "110" ELSE
                MERGED_DATA(23 downto 16);

END Behavioral;