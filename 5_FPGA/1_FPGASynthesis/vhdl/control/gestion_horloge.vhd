----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:58:29 01/30/2013 
-- Design Name: 
-- Module Name:    Gestion-Horloge - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



--------------------------------------------------------------------------------------------
-- This module will generate 4 signals described in the port declaration                   --
--------------------------------------------------------------------------------------------


ENTITY gestion_horloge IS
    PORT (horloge             : IN  std_logic; -- 50MHz
          raz                 : IN  std_logic;
          CE_affichage        : OUT std_logic;  
          --CE_processing       : OUT std_logic;  
          CE_perception       : OUT std_logic);  
END gestion_horloge;

ARCHITECTURE gestion_horloge_a OF gestion_horloge IS

-- Those counters are used to produce a pulse at different time
    SIGNAL counter  : unsigned (25 DOWNTO 0);
    --SIGNAL counter2 : unsigned (1 DOWNTO 0);
    SIGNAL counter3 : unsigned (25 DOWNTO 0);

BEGIN

    -----------------------------
    -- Sequential process      --
    -----------------------------
    PROCESS(horloge, raz)
    BEGIN

        IF raz = '1' THEN
            CE_perception    <= '0';
            --CE_processing    <= '0';
            CE_affichage     <= '0';
            
        ELSIF rising_edge(horloge) THEN

            -- DISPLAY --
            IF(counter(13 DOWNTO 0) = 2**14-1) THEN  -- 16384 = 3kHz
                CE_perception <= '1';
            ELSE
                CE_perception <= '0';
            END IF;

            -- INCREMENTING --
            --IF(counter3 = 50000000) THEN  -- 2 Hz
            IF(counter3 = 12500000) THEN  -- 10 Hz
                CE_affichage <= '1';
            ELSE
                CE_affichage <= '0';
            END IF;
				
				
            -- PROCESSINF --
--            IF(counter2 = 3) THEN  -- 25 MHz
--                CE_processing <= '1';
--            ELSE
--                CE_processing  <= '0';
--            END IF;
            
        END IF;
        
    END PROCESS;


-----------------------------
-- Combinatorial processes --
-----------------------------

-- UPDATING COUNTER 1 --
    cnter : PROCESS(raz, horloge)
    BEGIN
        
        IF raz = '1' THEN
            counter <= (OTHERS => '0');  -- comment this line for test bench or else you won't see the CESlow before the CPU melts down
        ELSIF rising_edge(horloge) THEN
            
            IF(counter = 50000000) THEN
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;
            
        END IF;
        
    END PROCESS;

-- UPDATING COUNTER 2 --
--    cnter2 : PROCESS(raz, horloge)
--    BEGIN
        
--        IF raz = '1' THEN
--            counter2 <= (OTHERS => '0');

--        ELSIF rising_edge(horloge) THEN
            
--            IF(counter2 = 4) THEN
--                counter2 <= (OTHERS => '0');
--            ELSE
--                counter2 <= counter2 + 1;
--            END IF;
            
--        END IF;

--    END PROCESS;

-- UPDATING COUNTER 3 --
    cnter3 : PROCESS(raz, horloge)
    BEGIN
        
        IF raz = '1' THEN
            counter3 <= (OTHERS => '0');

        ELSIF rising_edge(horloge) THEN
            
           -- IF(counter3 = 50000000) THEN
              IF(counter3 = 12500000) THEN
                counter3 <= (OTHERS => '0');
            ELSE
                counter3 <= counter3 + 1;
            END IF;
            
        END IF;

    END PROCESS;

END gestion_horloge_a;

