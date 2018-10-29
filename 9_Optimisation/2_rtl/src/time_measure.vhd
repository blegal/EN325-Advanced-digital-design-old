library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity time_measure is
    Port ( 
           CLK 		 : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
           SW        : in  STD_LOGIC_VECTOR ( 1 downto 0);
           LED 		 : out STD_LOGIC_VECTOR (15 downto 0);
           RsTx      : out STD_LOGIC
	);
end time_measure;

architecture Behavioral of time_measure is
	SIGNAL   data_to_uart      : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL   data_to_uart_en   : STD_LOGIC;

	SIGNAL   output_data : UNSIGNED (15 downto 0) := (others=>'0');

	SIGNAL   read_uart_data  : STD_LOGIC;
	SIGNAL   uart_is_sending : STD_LOGIC;

BEGIN


    PROCESS(clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF RESET = '1' THEN
                output_data <= (others=>'0');
            ELSIF data_to_uart_en = '1' THEN
                output_data <= output_data + TO_UNSIGNED(1, 1);
            END IF;
        END IF;
    END PROCESS;

    JPEG_ENGINE : ENTITY work.t_measure_0
    PORT MAP(
        clk       => clk,
        reset     => reset,
        s_din     => data_to_uart,
        s_full_n  => '1',
        s_write   => data_to_uart_en
    );

	----------------------------------------------------------
	------                LED Control                  -------
	----------------------------------------------------------

    LED <= STD_LOGIC_VECTOR( output_data );


	snd : ENTITY work.UART_fifoed_send
	PORT MAP(
		RESET   => RESET,
   clk_100MHz   => CLK,
     fifo_empty => uart_is_sending,
     fifo_afull => OPEN,
     fifo_full  => OPEN,
         tx     => RsTx,
        dat     => data_to_uart,
     dat_en     => data_to_uart_en);

end Behavioral;