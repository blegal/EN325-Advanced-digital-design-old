----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:57 05/18/2015 
-- Design Name: 
-- Module Name:    tirage - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Afficheur_MP3 is
    PORT (
        horloge       : in STD_LOGIC;
        raz           : in STD_LOGIC;
        busy          : in STD_LOGIC;
        read_llr      : in STD_LOGIC;
        write_sn      : in STD_LOGIC;
        button_up     : in STD_LOGIC;
        button_dw     : in STD_LOGIC;
        AN            : OUT STD_LOGIC_VECTOR (7 downto 0);
        Sept_Segments : OUT STD_LOGIC_VECTOR (6 downto 0)
    );
END Afficheur_MP3;

architecture Behavioral of Afficheur_MP3 is

    COMPONENT detec_impulsion IS
        PORT (
          CLOCK   : IN  STD_LOGIC;
          INPUT   : IN  STD_LOGIC;
          OUTPUT  : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL val_cpt8      : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL ce_affichage  : STD_LOGIC;
    SIGNAL ce_perception : STD_LOGIC;
    SIGNAL cpt_reset     : STD_LOGIC;
    SIGNAL soft_reset    : STD_LOGIC;

    signal cycle_digit_0 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_2 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_3 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_4 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_5 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_6 : STD_LOGIC_VECTOR(3 downto 0);
    signal cycle_digit_7 : STD_LOGIC_VECTOR(3 downto 0);

    signal inp_digit_0   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_1   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_2   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_3   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_4   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_5   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_6   : STD_LOGIC_VECTOR(3 downto 0);
    signal inp_digit_7   : STD_LOGIC_VECTOR(3 downto 0);

    signal outp_digit_0 : std_logic_vector(3 downto 0);
    signal outp_digit_1 : std_logic_vector(3 downto 0);
    signal outp_digit_2 : std_logic_vector(3 downto 0);
    signal outp_digit_3 : std_logic_vector(3 downto 0);
    signal outp_digit_4 : std_logic_vector(3 downto 0);
    signal outp_digit_5 : std_logic_vector(3 downto 0);
    signal outp_digit_6 : std_logic_vector(3 downto 0);
    signal outp_digit_7 : std_logic_vector(3 downto 0);

    signal t_digit_0 : std_logic_vector(6 downto 0);
    signal t_digit_1 : std_logic_vector(6 downto 0);
    signal t_digit_2 : std_logic_vector(6 downto 0);
    signal t_digit_3 : std_logic_vector(6 downto 0);
    signal t_digit_4 : std_logic_vector(6 downto 0);
    signal t_digit_5 : std_logic_vector(6 downto 0);
    signal t_digit_6 : std_logic_vector(6 downto 0);
    signal t_digit_7 : std_logic_vector(6 downto 0);

    signal s_digit_0 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_2 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_3 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_4 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_5 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_6 : STD_LOGIC_VECTOR(3 downto 0);
    signal s_digit_7 : STD_LOGIC_VECTOR(3 downto 0);

BEGIN

    dUP : detec_impulsion PORT MAP (horloge, busy, soft_reset);

    cpt_reset <= soft_reset OR raz;

    counter : ENTITY work.compteur_8d
    PORT MAP (
		horloge => horloge,
	    raz     => cpt_reset,
	    incr    => busy,
        digit_0 => cycle_digit_0, digit_1 => cycle_digit_1,
        digit_2 => cycle_digit_2, digit_3 => cycle_digit_3,
        digit_4 => cycle_digit_4, digit_5 => cycle_digit_5,
        digit_6 => cycle_digit_6, digit_7 => cycle_digit_7
    );

    icounter : ENTITY work.compteur_8d
    PORT MAP (
		horloge => horloge,
	    raz     => raz,
	    incr    => read_llr,
        digit_0 => inp_digit_0, digit_1 => inp_digit_1,
        digit_2 => inp_digit_2, digit_3 => inp_digit_3,
        digit_4 => inp_digit_4, digit_5 => inp_digit_5,
        digit_6 => inp_digit_6, digit_7 => inp_digit_7
    );

    ocounter : ENTITY work.compteur_8d
    PORT MAP (
		horloge => horloge,
	    raz     => raz,
	    incr    => write_sn,
        digit_0 => outp_digit_0, digit_1 => outp_digit_1,
        digit_2 => outp_digit_2, digit_3 => outp_digit_3,
        digit_4 => outp_digit_4, digit_5 => outp_digit_5,
        digit_6 => outp_digit_6, digit_7 => outp_digit_7
    );

    s_digit_0 <= inp_digit_0 WHEN button_up = '1' ELSE outp_digit_0 WHEN button_dw = '1' ELSE cycle_digit_0;
    s_digit_1 <= inp_digit_1 WHEN button_up = '1' ELSE outp_digit_1 WHEN button_dw = '1' ELSE cycle_digit_1;
    s_digit_2 <= inp_digit_2 WHEN button_up = '1' ELSE outp_digit_2 WHEN button_dw = '1' ELSE cycle_digit_2;
    s_digit_3 <= inp_digit_3 WHEN button_up = '1' ELSE outp_digit_3 WHEN button_dw = '1' ELSE cycle_digit_3;
    s_digit_4 <= inp_digit_4 WHEN button_up = '1' ELSE outp_digit_4 WHEN button_dw = '1' ELSE cycle_digit_4;
    s_digit_5 <= inp_digit_5 WHEN button_up = '1' ELSE outp_digit_5 WHEN button_dw = '1' ELSE cycle_digit_5;
    s_digit_6 <= inp_digit_6 WHEN button_up = '1' ELSE outp_digit_6 WHEN button_dw = '1' ELSE cycle_digit_6;
    s_digit_7 <= inp_digit_7 WHEN button_up = '1' ELSE outp_digit_7 WHEN button_dw = '1' ELSE cycle_digit_7;

    t0 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_0, S => t_digit_0 );
    t1 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_1, S => t_digit_1 );
    t2 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_2, S => t_digit_2 );
    t3 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_3, S => t_digit_3 );
    t4 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_4, S => t_digit_4 );
    t5 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_5, S => t_digit_5 );
    t6 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_6, S => t_digit_6 );
    t7 : ENTITY work.transcodeur PORT MAP( CLK => horloge, E => s_digit_7, S => t_digit_7 );

    gestion_freq : ENTITY work.gestion_horloge port map (
        horloge       => horloge,
        raz           => raz,
        ce_affichage  => ce_affichage,
        ce_perception => ce_perception);

    mux8 : ENTITY work.mux8_1 port map (
        E0       => t_digit_7,
        E1       => t_digit_6,
        E2       => t_digit_5,
        E3       => t_digit_4,
        E4       => t_digit_3,
        E5       => t_digit_2,
        E6       => t_digit_1,
        E7       => t_digit_0,
        COMMANDE => val_cpt8,
        S        => Sept_Segments);

    mod8 : ENTITY work.modulo8 port map (
        horloge  => horloge,
        raz      => raz,
        c_e      => ce_perception,
        sortie   => val_cpt8,
        AN       => AN);   

end Behavioral;
