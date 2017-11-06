----------------------------------------------------------------------------------
--
-- UART_recv_
-- Version 1.2b
-- Written by Yannick Bornat (2014/01/27)
-- Updated by Yannick Bornat (2014/05/12) : output is now synchronous
-- Updated by Yannick Bornat (2014/06/10) :
--    V1.1 : totally rewritten 
--       reception is now more reliable
--       for 3Mbps @50MHz, it is safer to use 1.5 or 2 stop bits.
-- Updated by Yannick Bornat (2014/08/04) :
--    V1.2 : Added slow values for instrumentation compatibility
-- Updated by Yannick Bornat (2015/08/21) :
--    V1.2b : Simplified to fit ENSEIRB-MATMECA lab sessions requirements
--
-- Receives a char on the UART line
-- dat_en is set for one clock period when a char is received 
-- dat must be read at the same time
-- Designed for 100MHz clock, reset is active high
-- transfer rate is 115 200kbps
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity full_UART_trans is
    PORT (
        clk_100MHz  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        tx          : out STD_LOGIC;
        dat         : in  STD_LOGIC_VECTOR (23 downto 0);
        dat_en      : in  STD_LOGIC
    );

end full_UART_trans;

architecture Behavioral of full_UART_trans is
    SIGNAL DATAE_TO_UART : STD_LOGIC;
    SIGNAL DATA_TO_UART  : STD_LOGIC_VECTOR ( 7 DOWNTO 0);
    SIGNAL DATAE_TO_RAM    : STD_LOGIC;
    SIGNAL DATA_TO_RAM     : STD_LOGIC_VECTOR (15 DOWNTO 0);
BEGIN

	splitter : ENTITY work.splitter_24b_to_8b
	PORT MAP(
        clock      => clk_100MHz,
        RESET      => RESET,
        DATA_IN    => dat,
        ENABLE     => dat_en,
        DATA_OUT   => DATA_TO_UART,
        DATA_READY => DATAE_TO_UART
    );

	transmitter : ENTITY work.UART_fifoed_send
	PORT MAP(
		clk_100MHz => clk_100MHz,
		reset   => RESET,
         tx     => tx,
        dat     => DATA_TO_UART,
     dat_en     => DATAE_TO_UART,
     fifo_empty => open,
     fifo_afull => open,
     fifo_full  => open
     );

end Behavioral;