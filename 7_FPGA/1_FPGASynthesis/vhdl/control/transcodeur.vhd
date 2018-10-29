library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

ENTITY transcodeur IS
    PORT (
        CLK : IN  STD_LOGIC;
        E   : IN  STD_LOGIC_VECTOR(3 downto 0);
        S   : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
END transcodeur;

ARCHITECTURE archi of transcodeur is
BEGIN

    PROCESS (CLK)
    BEGIN
        IF CLK'EVENT AND CLK='1' THEN
           CASE E is
               when "0000" => S <= "0000001"; --0
               when "0001" => S <= "1001111"; --1
               when "0010" => S <= "0010010"; --2
               when "0011" => S <= "0000110"; --3
               when "0100" => S <= "1001100"; --4
               when "0101" => S <= "0100100"; --5
               when "0110" => S <= "0100000"; --6
               when "0111" => S <= "0001111"; --7
               when "1000" => S <= "0000000"; --8
               when "1001" => S <= "0000100"; --9
               when others => S <= "0000001"; --1
           END CASE;
        END IF;
    END PROCESS;

END archi;
