----------------------------------------------------------------------------
--	GPIO_Demo.vhd -- Nexys4 GPIO/UART Demonstration Project
----------------------------------------------------------------------------
-- Author:  Marshall Wingerson Adapted from Sam Bobrowicz
--          Copyright 2013 Digilent, Inc.
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
--	The GPIO/UART Demo project demonstrates a simple usage of the Nexys4's 
--  GPIO and UART. The behavior is as follows:
--
--	      *The 16 User LEDs are tied to the 16 User Switches. While the center
--			 User button is pressed, the LEDs are instead tied to GND
--	      *The 7-Segment display counts from 0 to 9 on each of its 8
--        digits. This count is reset when the center button is pressed.
--        Also, single anodes of the 7-Segment display are blanked by
--	       holding BTNU, BTNL, BTND, or BTNR. Holding the center button 
--        blanks all the 7-Segment anodes.
--       *An introduction message is sent across the UART when the device
--        is finished being configured, and after the center User button
--        is pressed.
--       *A message is sent over UART whenever BTNU, BTNL, BTND, or BTNR is
--        pressed.
--       *The Tri-Color LEDs cycle through several colors in a ~4 second loop
--       *Data from the microphone is collected and transmitted over the mono
--        audio out port.
--       *Note that the center user button behaves as a user reset button
--        and is referred to as such in the code comments below
--        
--	All UART communication can be captured by attaching the UART port to a
-- computer running a Terminal program with 9600 Baud Rate, 8 data bits, no 
-- parity, and 1 stop bit.																
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
-- Revision History:
--  08/08/2011(SamB): Created using Xilinx Tools 13.2
--  08/27/2013(MarshallW): Modified for the Nexys4 with Xilinx ISE 14.4\	
--  		--added RGB and microphone
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

ENTITY top_uart IS
    PORT ( 
           CLK 		     : in  STD_LOGIC;
           nRESET        : in  STD_LOGIC;
           LED 		     : out STD_LOGIC_VECTOR (15 downto 0);
           JTAG_RsRx     : in  STD_LOGIC;
           JTAG_RsTx     : out STD_LOGIC
	);
END top_uart;

ARCHITECTURE Behavioral OF top_uart IS

	SIGNAL   dat  : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

	SIGNAL   data_from_uart    : STD_LOGIC_VECTOR (23 downto 0);
	SIGNAL   data_from_uart_en : STD_LOGIC;

	SIGNAL   data_to_uart      : STD_LOGIC_VECTOR (23 downto 0);
	SIGNAL   data_to_uart_en   : STD_LOGIC;

	SIGNAL   counter           : UNSIGNED (15 downto 0) := (others=>'0');

	SIGNAL   input_data        : UNSIGNED (15 downto 0) := (others=>'0');
	SIGNAL   output_data       : UNSIGNED (15 downto 0) := (others=>'0');

	SIGNAL   started           : STD_LOGIC;
	SIGNAL   dec_read_llr      : STD_LOGIC;
	SIGNAL   dec_read_fb       : STD_LOGIC;
	SIGNAL   uart_is_sending   : STD_LOGIC;

	SIGNAL   loading_fb        : STD_LOGIC_VECTOR (0 downto 0);
	SIGNAL   loading_llr       : STD_LOGIC_VECTOR (0 downto 0);
	SIGNAL   sending_sn        : STD_LOGIC_VECTOR (0 downto 0);

	SIGNAL   fifo_llr_to_dec   : STD_LOGIC_VECTOR (5 downto 0);
	SIGNAL   fifo_fb_to_dec    : STD_LOGIC_VECTOR (0 downto 0);

	SIGNAL   fifo_out_full     : STD_LOGIC;
	SIGNAL   fifo_out_ready    : STD_LOGIC;

	SIGNAL   eUART : STD_LOGIC;
	SIGNAL   RESET : STD_LOGIC;
BEGIN

    RESET <= NOT nRESET;

    module : ENTITY work.RGB2YCbCr
    PORT MAP(
        clk       => clk,
        i_data    => data_from_uart,
        i_valid   => data_from_uart_en,
        o_data    => data_to_uart,
        o_valid   => data_to_uart_en
    );

	----------------------------------------------------------
	------                LED Control                  -------
	----------------------------------------------------------

    LED <= x"FFFF" WHEN RESET = '1' ELSE x"0000";

    --
    -- ON CABLE LE COMPOSANT PERMETTANT DE FAIRE DESCENDRE LES DONNEES DEPUIS
    -- LE PC HOTE VIA L'UART
    --

    rcv : ENTITY work.full_UART_recv
	PORT MAP(
		RESET  => RESET,
	clk_100MHz => CLK,
           rx  => JTAG_RsRx,
   data_value  => data_from_uart,
   data_valid  => data_from_uart_en);

    --
    -- ON CABLE LE COMPOSANT PERMETTANT DE FAIRE REMONTER LES DONNEES VERS
    -- LE PC HOTE VIA L'UART
    --
	snd : ENTITY work.full_UART_trans
	PORT MAP(
   clk_100MHz   => CLK,
		RESET   => RESET,
         tx     => JTAG_RsTx,
        dat     => data_to_uart,
     dat_en     => data_to_uart_en);

end Behavioral;