library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity turbo_uart is
    Port ( 
           CLK 		 : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
           SW        : in  STD_LOGIC_VECTOR ( 1 downto 0);
           LED 		 : out STD_LOGIC_VECTOR (15 downto 0);
           RsRx      : in  STD_LOGIC;
           RsTx      : out STD_LOGIC
	);
end turbo_uart;

architecture Behavioral of turbo_uart is
	SIGNAL   dat  : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

	SIGNAL   data_from_uart    : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL   data_from_uart_en : STD_LOGIC;

	SIGNAL   data_to_uart      : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL   data_to_uart_en   : STD_LOGIC;

	SIGNAL   counter           : UNSIGNED (15 downto 0) := (others=>'0');

	SIGNAL   input_data  : UNSIGNED (15 downto 0) := (others=>'0');
	SIGNAL   output_data : UNSIGNED (15 downto 0) := (others=>'0');

	SIGNAL   read_uart_data  : STD_LOGIC;
	SIGNAL   uart_is_sending : STD_LOGIC;

BEGIN

    PROCESS(clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF RESET = '1' THEN
                input_data <= (others=>'0');
            ELSIF data_from_uart_en = '1' THEN
                input_data <= input_data + TO_UNSIGNED(1, 1);
            END IF;
        END IF;
    END PROCESS;

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

    JPEG_ENGINE : ENTITY work.Uart_wrapper_0
    PORT MAP(
        clk       => clk,
        reset     => reset,
        e_dout    => data_from_uart,
        e_empty_n => data_from_uart_en,
        e_read    => read_uart_data,
        s_din     => data_to_uart,
        s_full_n  => '1',
        s_write   => data_to_uart_en
    );

	----------------------------------------------------------
	------                LED Control                  -------
	----------------------------------------------------------

    LED <=  
            STD_LOGIC_VECTOR( input_data  ) WHEN SW    = "01" ELSE 
            STD_LOGIC_VECTOR( output_data ) WHEN SW    = "10" ELSE
            "00000000" & dat                WHEN RESET =  '0' ELSE
            (OTHERS => '1');

    rcv : ENTITY work.UART_recv
	PORT MAP(
		RESET  => RESET,
		  clk  => CLK,
           rx  => RsRx,
          dat  => data_from_uart,
       dat_en  => data_from_uart_en);

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