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

entity full_UART_recv is
    PORT (
        clk_100MHz  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        rx          : in  STD_LOGIC;
        data_value  : out STD_LOGIC_VECTOR (23 downto 0);
        data_valid  : out STD_LOGIC
    );
end full_UART_recv;

architecture Behavioral of full_UART_recv is
    SIGNAL DATAE_FROM_UART : STD_LOGIC;
    SIGNAL DATA_FROM_UART  : STD_LOGIC_VECTOR ( 7 DOWNTO 0);
BEGIN

	receiver : ENTITY work.UART_recv
	PORT MAP(
		RESET => RESET,
		clk   => clk_100MHz,
         rx   => rx,
        dat   => DATA_FROM_UART,
     dat_en   => DATAE_FROM_UART
     );

	merger : ENTITY work.merger_8b_to_24b
	PORT MAP(
        clock      => clk_100MHz,
        RESET      => RESET,
        DATA_IN    => DATA_FROM_UART,
        ENABLE     => DATAE_FROM_UART,
        DATA_OUT   => data_value,
        DATA_READY => data_valid
    );

end Behavioral;