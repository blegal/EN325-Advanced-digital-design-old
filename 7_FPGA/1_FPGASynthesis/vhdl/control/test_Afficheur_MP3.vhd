----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.07.2015 12:10:41
-- Design Name: 
-- Module Name: test_chenillard - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_Afficheur_MP3 is
--  Port ( );
end test_Afficheur_MP3;

architecture non_synthetisable of test_Afficheur_MP3 is

-- déclaration de l'architecture à tester --
COMPONENT Afficheur_MP3 is
    Port ( horloge         : in  STD_LOGIC;
           raz             : in  STD_LOGIC;
           bouton_incr     : in  STD_LOGIC;
           bouton_decr     : in  STD_LOGIC;
           AN              : out STD_LOGIC_VECTOR (7 downto 0);
           Sept_Segments   : out STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;


-- declaration des signaux de test --
SIGNAL horloge         : STD_LOGIC :='0';
SIGNAL raz             : STD_LOGIC :='1'; -- le reset est actif au départ
SIGNAL bouton_incr     : STD_LOGIC :='0';
SIGNAL bouton_decr     : STD_LOGIC :='0';
SIGNAL AN              : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Sept_Segments   : STD_LOGIC_VECTOR (6 downto 0);

-- declaration des constantes --
CONSTANT demi_periode : TIME := 10 ns ;

BEGIN
	
	-- instanciations de l'architecture à tester --
	UTEST : Afficheur_MP3
	PORT MAP ( horloge, raz, bouton_incr, bouton_decr, AN, Sept_Segments);
	
	-- process explicite de génération du signal d'horloge H --
	clock : PROCESS
	BEGIN
		WAIT FOR demi_periode;
		horloge <=  not horloge;
	END PROCESS clock;

	-- process explicite de génération des vecteurs de tests d'entrée
	vecteur_test : PROCESS
	BEGIN
  		
  		raz <='1';
  		bouton_incr <= '0';
  		bouton_decr <= '0';
  		wait for (demi_periode*2)*10; -- 200 ns
  		bouton_incr <= '1';
  		raz <='0';
        wait for (demi_periode*2)*100; -- 20000 ns

	END PROCESS vecteur_test;
	
end non_synthetisable;
