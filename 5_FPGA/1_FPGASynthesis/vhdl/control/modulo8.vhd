library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity modulo8 is
    port  (horloge   : in std_logic;
	       raz       : in std_logic;
	 	   c_e       : in std_logic;
           sortie    : out std_logic_vector(2 downto 0);
		   AN        : out std_logic_vector(7 downto 0)
		   );
end modulo8;


architecture modulo8_a of modulo8 is

    signal cpt_val: unsigned(2 downto 0);

begin  -- compteur_a

    mod8 : process (horloge, raz)
        
    begin  -- process cpt
        -- activities triggered by asynchronous reset (active low)
        if raz = '1' then

            cpt_val <= "000";
            
        -- activities triggered by rising edge of clock
        elsif horloge'event and horloge = '1' then 
		     if c_e ='1' then 
              if cpt_val = "111" then
                 cpt_val <= "000";
              else
               cpt_val <= cpt_val + 1;
              end if; 
				end if;  
           end if;        
    end process mod8;

    sortie <= std_logic_vector(cpt_val);

	 parallel : process (cpt_val)
	 begin 
	 			case cpt_val is
						when "000"  => AN <="11111110";
						when "001"  => AN <="11111101";
						when "010"  => AN <="11111011";
                        when "011"  => AN <="11110111";						
						when "100"  => AN <="11101111";
                        when "101"  => AN <="11011111";						
						when "110"  => AN <="10111111";
						when others => AN <="01111111";
				end case;

	 end process parallel;

end modulo8_a;
