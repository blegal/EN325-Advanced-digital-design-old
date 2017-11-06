----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_RGB2YCbCr is
end;

architecture bench of tb_RGB2YCbCr is

  component RGB2YCbCr
    PORT (
      clk     : in  STD_LOGIC;
      i_data  : in  STD_LOGIC_VECTOR (23 downto 0);
      o_data  : out STD_LOGIC_VECTOR (23 downto 0);
      i_valid : in  STD_LOGIC;
      o_valid : out STD_LOGIC
    );
  end component;

  signal clk    : STD_LOGIC;
  signal i_data : STD_LOGIC_VECTOR (23 downto 0);
  signal o_data : STD_LOGIC_VECTOR (23 downto 0);
  signal i_valid: STD_LOGIC;
  signal o_valid: STD_LOGIC ;

begin

  uut: RGB2YCbCr port map ( clk     => clk,
                            i_data  => i_data,
                            o_data  => o_data,
                            i_valid => i_valid,
                            o_valid => o_valid );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
