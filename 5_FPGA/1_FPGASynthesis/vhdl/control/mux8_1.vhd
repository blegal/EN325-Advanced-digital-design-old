library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux8_1 is

    port ( E0       : in Std_Logic_Vector(6 downto 0);
           E1       : in Std_Logic_Vector(6 downto 0);
		   E2       : in Std_Logic_Vector(6 downto 0);
		   E3       : in Std_Logic_Vector(6 downto 0);
		   E4       : in Std_Logic_Vector(6 downto 0);
           E5       : in Std_Logic_Vector(6 downto 0);
           E6       : in Std_Logic_Vector(6 downto 0);
           E7       : in Std_Logic_Vector(6 downto 0);
           COMMANDE : in Std_Logic_Vector(2 downto 0);
	       S        : out Std_Logic_Vector(6 downto 0)
	);

end mux8_1;

-------------------------------------------------------------------------

architecture a_mux8_1 OF mux8_1 is


begin

    process(E0,E1,E2,E3,E4,E5,E6,E7,COMMANDE)
        begin
				case COMMANDE is
						when "000" =>   S <= E0;
						when "001" =>   S <= E1;
						when "010" =>   S <= E2;
						when "011" =>   S <= E3;
                        when "100" =>   S <= E4;
                        when "101" =>   S <= E5;
                        when "110" =>   S <= E6;
                        when others =>  S <= E7;
				end case;

    end process;

end a_mux8_1;

