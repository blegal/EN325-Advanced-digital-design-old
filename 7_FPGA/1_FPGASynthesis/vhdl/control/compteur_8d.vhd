library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY compteur_8d IS
    PORT (
		horloge : in std_logic;
	    raz     : in std_logic;
	    incr    : in std_logic;
        digit_0 : out std_logic_vector(3 downto 0);
        digit_1 : out std_logic_vector(3 downto 0);
        digit_2 : out std_logic_vector(3 downto 0);
        digit_3 : out std_logic_vector(3 downto 0);
        digit_4 : out std_logic_vector(3 downto 0);
        digit_5 : out std_logic_vector(3 downto 0);
        digit_6 : out std_logic_vector(3 downto 0);
        digit_7 : out std_logic_vector(3 downto 0)
	);
END compteur_8d;

ARCHITECTURE arch OF compteur_8d IS
    SIGNAL carry_0_to_1 : STD_LOGIC;
    SIGNAL carry_1_to_2 : STD_LOGIC;
    SIGNAL carry_2_to_3 : STD_LOGIC;
    SIGNAL carry_3_to_4 : STD_LOGIC;
    SIGNAL carry_4_to_5 : STD_LOGIC;
    SIGNAL carry_5_to_6 : STD_LOGIC;
    SIGNAL carry_6_to_7 : STD_LOGIC;
    SIGNAL carry_7_to_8 : STD_LOGIC;
BEGIN 

	CPT0 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => incr,
	    carry   => carry_0_to_1,
        sortie  => digit_0
	);

	CPT1 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_0_to_1,
	    carry   => carry_1_to_2,
        sortie  => digit_1
	);

	CPT2 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_1_to_2,
	    carry   => carry_2_to_3,
        sortie  => digit_2
	);

	CPT3 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_2_to_3,
	    carry   => carry_3_to_4,
        sortie  => digit_3
	);

	CPT4 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_3_to_4,
	    carry   => carry_4_to_5,
        sortie  => digit_4
	);

	CPT5 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_4_to_5,
	    carry   => carry_5_to_6,
        sortie  => digit_5
	);

	CPT6 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_5_to_6,
	    carry   => carry_6_to_7,
        sortie  => digit_6
	);

	CPT7 : ENTITY work.compteur_0_9
    PORT MAP(
		horloge => horloge,
	    raz     => raz,
	    incr    => carry_6_to_7,
	    carry   => carry_7_to_8,
        sortie  => digit_7
	);

end arch;
