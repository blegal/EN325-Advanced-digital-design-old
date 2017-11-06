----------------------------------------------------------------------------------
--
-- UART_fifoed_send_V1
-- Version 1.1
-- 
-- V1.1 : Written by Yannick Bornat (2016/04/20)
--       - build from UART_send v1.1, named to fit the same version number
--
-- Sends chars on the UART line, has a built-in fifo to accept char inputs while
-- sending an older char
-- during character send, busy output bit is set to '1' and the module ignores inputs.
-- works at 100MHz with 115.200kbps transfer rate
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_fifoed_send is
    Generic ( fifo_size             : integer := 2048;
              fifo_almost           : integer := 508;
              drop_oldest_when_full : boolean := False;
              asynch_fifo_full      : boolean := True);
    Port ( clk_100MHz : in  STD_LOGIC;
           reset      : in  STD_LOGIC;
           dat_en     : in  STD_LOGIC;
           dat        : in  STD_LOGIC_VECTOR (7 downto 0);
           TX         : out STD_LOGIC;
           fifo_empty : out STD_LOGIC;
           fifo_afull : out STD_LOGIC;
           fifo_full  : out STD_LOGIC);
end UART_fifoed_send;

architecture Behavioral of UART_fifoed_send is

type t_fifo is array (0 to fifo_size - 1) of STD_LOGIC_VECTOR (7 downto 0);

signal cnt         : integer range 0 to 1023;           -- counter to divide clock events
signal top         : STD_LOGIC;                         -- strobe to make state machine progress
signal shift       : STD_LOGIC_VECTOR (8 downto 0);     -- UART shift register
signal nbbits      : integer range 0 to 15;             -- remaining number of bits to transfer
signal FIFO        : t_fifo;                            -- array to store elements in fifo
signal read_index  : integer range 0 to fifo_size - 1;  -- points to the next element to read from FIFO
signal write_index : integer range 0 to fifo_size - 1;  -- points to the next free room in FIFO array
signal n_elements  : integer range 0 to fifo_size;      -- number of elements in FIFO

alias clk is clk_100MHz;

begin

top  <= '1' when cnt=0 else '0';
TX   <= shift(0);

fifo_empty <= '1' when n_elements = 0            else '0';
fifo_afull <= '1' when n_elements >= fifo_almost else '0';
fifo_full  <= '1' when n_elements = fifo_size or 
                      (asynch_fifo_full and dat_en = '1' and nbbits < 12 and n_elements = fifo_size - 1)   else '0';
-- if user manages fifo_full in asynchronous to prevent writing, asserting fifo_full on write will create
-- an synchronous loop (ring oscillator), but if not, we must assert as soon as possible to avoid loosing
-- data

process(clk)
begin
	if clk'event and clk='1' then
		if reset='1' then
			cnt <= 0;
		elsif nbbits>=12 or cnt=0 then
			cnt <= 107;--867; -- (100MHz /  115200bps) - 1
		else
			cnt <= cnt-1;
		end if;
	end if;
end process;

process (clk)
begin
	if clk'event and clk='1' then
		if reset='1' then
			shift  <= "111111111";
			nbbits <= 12;
		elsif nbbits>=12 then
			-- this state waits for data to send
			if n_elements > 0 then -- data present in fifo
				shift  <= FIFO(read_index) & '0';
				nbbits <= 9;
			end if;
		else
			-- this part actually sends the bits
			if top='1' then
				shift  <= '1' & shift(8 downto 1);
				if nbbits=0 then
				   nbbits <= 15;
				else
				   nbbits <= nbbits -1;
				end if;
			end if;
			
		end if;
	end if;
end process;


process(clk)
begin
   if clk'event and clk = '1' then
      if reset = '1' then
         read_index <= 0;
      elsif (n_elements > 0 and nbbits >= 12) or (dat_en = '1' and n_elements = fifo_size and drop_oldest_when_full) then
         -- conditions to increase read_index :
         --    * sending ready, and fifo not empty
         --    * writing element to FIFO with FIFO full, and prefering to loose oldest element rather than
         --      droping new element written
         if read_index = fifo_size - 1 then
            read_index <= 0;
         else
            read_index <= read_index + 1;
         end if;
      end if;
   end if;
end process;


process(clk)
begin
   if clk'event and clk = '1' then
      if reset = '1' then
         n_elements <= 0;
      elsif dat_en = '1' then
         -- user wants to write data
         if n_elements = 0 then
            -- if FIFO is empty, elements must first be written into the array
            -- so it will not be read instantly (default array behavior is "read before write"
            -- while performing the two operations in the same clock cycle) 
            n_elements <= 1;
         elsif nbbits < 12 and n_elements < fifo_size then
            -- we only increase the number of elements if there is still room in the array and
            -- if there is no simultaneous read
            n_elements <= n_elements + 1;         
         end if;
      elsif n_elements > 0 and nbbits >= 12 then
         -- no data written, we decrease element number if sending new element (sending ready and
         -- element present in fifo)
         n_elements <= n_elements - 1;
      end if;
   end if;
end process;




process(clk)
begin
   if clk'event and clk = '1' then
      if reset = '1' then
         write_index <= 0;
      elsif dat_en = '1' and (n_elements < fifo_size or drop_oldest_when_full) then
         -- dat_en = '1' means, user wants to write a new element in fifo, we do it provided
         -- fifo is not full or user prefers loosing oldest element rather than giving up writing
         if write_index = fifo_size - 1 then
            write_index <= 0;
         else
            write_index <= write_index + 1;
         end if;
         -- by the way, we also write data in array :)
         FIFO(write_index) <= dat;
      end if;
   end if;
end process;


end Behavioral;