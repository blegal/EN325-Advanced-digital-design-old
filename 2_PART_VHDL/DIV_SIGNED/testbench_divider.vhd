--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:14:07 01/06/2010
-- Design Name:   
-- Module Name:   C:/Temp/Carac_IEEE754_Virtex5/testbench_divider.vhd
-- Project Name:  Carac_IEEE754_Virtex5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: divider_generic
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY testbench_divider IS
END testbench_divider;
 
ARCHITECTURE behavior OF testbench_divider IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT divider_generic
    PORT(
         INPUT_1 : IN  std_logic_vector(7 downto 0);
         INPUT_2 : IN  std_logic_vector(7 downto 0);
         OUTPUT_1 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal INPUT_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal INPUT_2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal OUTPUT_1 : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divider_generic PORT MAP (
          INPUT_1 => INPUT_1,
          INPUT_2 => INPUT_2,
          OUTPUT_1 => OUTPUT_1
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period := 1ns;
 
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
		INPUT_1 <= std_logic_vector( TO_UNSIGNED( 200, 8 ) );
		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 1,   8 ) );
      wait for 10ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 2,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 3,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 4,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 5,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 7,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 13,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 20,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 200,   8 ) );
      wait for 10 ns;	

		INPUT_2 <= std_logic_vector( TO_UNSIGNED( 201,   8 ) );
      wait for 10 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
