LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm IS
PORT (
      RESET      : IN  STD_LOGIC;
      CLOCK      : IN  STD_LOGIC;
      
      B_UP       : IN  STD_LOGIC;
      B_DOWN     : IN  STD_LOGIC;
      B_CENTER   : IN  STD_LOGIC;
      B_LEFT     : IN  STD_LOGIC;
      B_RIGHT    : IN  STD_LOGIC;

      PLAY_PAUSE : OUT STD_LOGIC;
	   RESTART    : OUT STD_LOGIC;
      FORWARD    : OUT STD_LOGIC;		
      VOLUME_UP  : OUT STD_LOGIC;
      VOLUME_DW  : OUT STD_LOGIC
      );
END fsm;

ARCHITECTURE Behavioral OF fsm IS
	TYPE STATE_TYPE IS (init, play_fwd, play_bwd, pause, stop);
	SIGNAL current_state, next_state : STATE_TYPE;
BEGIN


--State register

  PROCESS (CLOCK, RESET)
   BEGIN
      IF RESET = '1' THEN
         current_state  <= INIT;
      ELSIF (CLOCK'EVENT AND CLOCK = '1') THEN
         current_state <= next_state;
      END IF;
   END PROCESS;
 
 --Next state computation
  
   PROCESS (current_state, B_UP, B_DOWN, B_CENTER, B_LEFT, B_RIGHT)
    BEGIN       
         CASE current_state IS
            WHEN INIT =>
               IF B_CENTER = '1' THEN
						next_state <= PLAY_FWD;
               ELSE
						next_state <= INIT;
               END IF;
            WHEN PLAY_FWD =>
               IF B_CENTER = '1' THEN
						next_state <= PAUSE;
               ELSE
						next_state <= PLAY_FWD;
               END IF;
            WHEN PLAY_BWD =>
               IF B_CENTER = '1' THEN
						next_state <= PAUSE;
               ELSE
						next_state <= PLAY_BWD;
               END IF;
            WHEN PAUSE =>
               IF B_LEFT = '1' THEN
						next_state <= PLAY_BWD;
               ELSIF B_RIGHT = '1' THEN
						next_state <= PLAY_FWD;
               ELSIF B_CENTER = '1' THEN
						next_state  <= STOP;
               ELSE
						next_state <= PAUSE;
               END IF;
            WHEN STOP =>
               IF B_CENTER = '1' THEN
						next_state <= PLAY_FWD;
               ELSE
						next_state <= STOP;
               END IF;

            WHEN OTHERS=>
					   next_state <= INIT;
         END CASE;
	END PROCESS;

--Output signal computation

  PROCESS (current_state, B_UP, B_DOWN)
   BEGIN
    CASE current_state IS
      WHEN INIT =>    PLAY_PAUSE<= '0';
                      RESTART   <= '1';
		                FORWARD   <= '0';
		                VOLUME_UP <= '0';
		                VOLUME_DW <= '0';

     WHEN PLAY_BWD => PLAY_PAUSE <= '1';
                      RESTART    <= '0';
			             FORWARD    <= '0';
                      VOLUME_UP  <= B_UP;
                      VOLUME_DW  <= B_DOWN;

    WHEN PLAY_FWD =>  PLAY_PAUSE <= '1';
                      RESTART    <= '0';
                      FORWARD    <= '1';
                      VOLUME_UP  <= B_UP;
                      VOLUME_DW  <= B_DOWN;
                      
    WHEN PAUSE =>     PLAY_PAUSE  <= '0';
                      FORWARD     <= '0';
                      RESTART     <= '0';
                      VOLUME_UP   <= '0';
                      VOLUME_DW   <= '0';

    WHEN STOP =>      PLAY_PAUSE<= '0';
                      RESTART   <= '1';
                      FORWARD   <= '0';
                      VOLUME_UP <= '0';
                      VOLUME_DW <= '0';

    END CASE;
   END PROCESS;

END Behavioral;
