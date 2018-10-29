library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY compteur_0_9 IS
    PORT (
		horloge   : IN  std_logic;
	    raz       : IN  std_logic;
	    incr      : IN  std_logic;
	    carry     : OUT std_logic;
        sortie    : OUT std_logic_vector(3 downto 0)
	);
END compteur_0_9;


ARCHITECTURE arch of compteur_0_9 IS
    SIGNAL cpt_val : INTEGER RANGE 0 TO 9;
BEGIN

    PROCESS (horloge, raz)
    BEGIN
        if raz = '1' then
            cpt_val <= 0;
        elsif horloge'event and horloge = '1' then
			if incr = '1' then    
				if cpt_val = 9 then
					cpt_val <=  0;
					carry   <= '1';
				else
					cpt_val <= cpt_val + 1;
					carry   <= '0';
                end if;
			else
				cpt_val <= cpt_val;
				carry   <= '0';
			end if;  
		end if;
    END PROCESS;

    sortie <= STD_LOGIC_VECTOR( TO_UNSIGNED(cpt_val, 4) );

end arch;
