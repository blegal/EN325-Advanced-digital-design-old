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

entity UART_recv is
   Port ( clk    : in  STD_LOGIC;
          reset  : in  STD_LOGIC;
          rx     : in  STD_LOGIC;
          dat    : out STD_LOGIC_VECTOR (7 downto 0);
          dat_en : out STD_LOGIC);
end UART_recv;

architecture Behavioral of UART_recv is

type t_fsm is (idle, zero_as_input, wait_next_bit, bit_sample, bit_received, wait_stop_bit, last_bit_is_zero);
  -- idle            : the normal waiting state (input should always be 1)
  -- zero_as_input   : we received a '1' in input but it may be noise
  -- wait_next_bit   : we just received an input that remained unchanged for 1/4 of the bit period, we wait for 3/4 to finish timeslot
  -- bit_sample      : we wait for a bit to last at least 1/4 of the period without changing
  -- bit_received    : a bit was received during 1/4 of period, so it is valid
  -- wait_stop_bit   : the last bit was a stop, we wait for it to finish (1/2 of period)
  -- last_bit_is_zero: well last bit was not a stop, we wait for a 1 that lasts a full period...
  
  
  
signal state : t_fsm := idle;
signal nbbits: integer range 0 to 8:=0;
signal cnt   : integer range 0 to 1023;
signal rxi   : std_logic:='1';
signal ref_bit          : std_logic;
signal shift : STD_LOGIC_VECTOR (7 downto 0);

constant quarter          : integer range 0 to 255 :=  26;--216;
constant half             : integer range 0 to 511 :=  53;--433;
constant three_quarters   : integer range 0 to 1023:=  80;--643;
constant full             : integer range 0 to 1023:= 107;--433;--867;  -- (100MHz /  115200bps) - 1

begin

-- we fisrt need to sample the input signal
process(clk)
begin
	if clk'event and clk='1' then
		rxi <= rx;
	end if;
end process;

-- the FSM of the module...
process(clk)
begin
   if rising_edge(clk) then
      if reset='1' then
         state <= idle;
      else
         case state is
            when idle            => if rxi    = '0' then state <= zero_as_input;    end if;
            when zero_as_input   => if rxi    = '1' then state <= idle;
                                 elsif cnt    =  0  then state <= wait_next_bit;    end if;
            when wait_next_bit   => if cnt    =  0  then state <= bit_sample;       end if;
            when bit_sample      => if cnt    =  0  then state <= bit_received;     end if;
            when bit_received    => if nbbits <  8  then state <= wait_next_bit;
                                 elsif ref_bit= '1' then state <= wait_stop_bit;
                                                    else state <= last_bit_is_zero; end if;
            when wait_stop_bit   => if rxi    = '0' then state <= last_bit_is_zero;
                                 elsif cnt    =  0  then state <= idle;             end if;
            when last_bit_is_zero=> if cnt    =  0  then state <= idle;             end if;
         end case;
      end if;
   end if;
end process;

-- here we manage the counter 
process(clk)
begin
   if rising_edge(clk) then
      if reset='1' then
         cnt <= quarter;
      else
         case state is
            when idle            =>                        cnt <= quarter;
            when zero_as_input   => if cnt = 0        then cnt <= three_quarters;               -- transition, we prepare the next waiting time
                                                      else cnt <= cnt - 1;          end if;
            when wait_next_bit   => if cnt = 0        then cnt <= quarter;                      -- transition, we prepare the next waiting time
                                                      else cnt <= cnt - 1;          end if;
            when bit_sample      => if ref_bit /= rxi then cnt <= quarter;                -- if bit change, we restart the counter
                                                      else cnt <= cnt - 1;          end if;
            when bit_received    => if nbbits <  8    then cnt <= three_quarters;
                                 elsif ref_bit = '0'  then cnt <= full;
                                                      else cnt <= half;             end if;
            when wait_stop_bit   =>                        cnt <= cnt - 1;
            when last_bit_is_zero=> if rxi = '0'      then cnt <= full;
                                                      else cnt <= cnt - 1;          end if;
         end case;
      end if;
   end if;
end process;

-- we now manage the reference bit that should remain constant for 1/4 period during bit_sample
-- we affect ref_bit in both wait_next_bit (so that we arrive in bit_sample with initialized value)
-- and in bit_sample because if different, we consider each previous value as a mistake, and if equal
-- it has no consequence...
process(clk)
begin
   if rising_edge(clk) then
      if state = wait_next_bit or state = bit_sample then
         ref_bit <= rxi;
      end if;
   end if;
end process;


-- output (shift) register
process (clk)
begin
   if rising_edge(clk) then
      if state = bit_sample and cnt = 0 and nbbits < 8 then
         shift <= ref_bit & shift (7 downto 1);
      end if;
   end if;
end process;


-- nbbits management
process (clk)
begin
   if rising_edge(clk) then
      if state = idle then
         nbbits <= 0;
      elsif state = bit_received then
         nbbits <= nbbits + 1;
      end if;
   end if;
end process;

-- outputs
process(clk)
begin
   if rising_edge(clk) then
      if reset = '1' then
         dat_en <= '0';
      elsif state = wait_stop_bit and cnt = 0 then
         dat_en <= '1';
         dat    <= shift;
      else
         dat_en <= '0';
      end if;
   end if;
end process;

end Behavioral;