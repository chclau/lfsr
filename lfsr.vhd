------------------------------------------------------------------
-- Name		     : lfsr1.vhd
-- Description : Part of the LFSR tutorial
-- Designed by : Claudio Avi Chami - FPGA Site
--               https://fpgasite.blogspot.com
-- Date        : 10/April/2017
-- Version     : v1 	- Initial
------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;

entity lfsr1 is
  port (
    reset  : in  std_logic;
    clk    : in  std_logic; 
    count  : out std_logic_vector (3 downto 0) 	  -- lfsr output
  );
end entity;

architecture rtl of lfsr1 is
    signal count_i    : std_logic_vector (3 downto 0);
    signal feedback 	: std_logic;

begin

	-- option for LFSR size 4
  feedback <= not(count_i(3) xor count_i(2));		

  sr_pr : process (clk) 
    begin
      if (rising_edge(clk)) then
        if (reset = '1') then
          count_i <= (others=>'0');
  else
    count_i <= count_i(2 downto 0) & feedback;
  end if;  
      end if;
    end process sr_pr;
  count <= count_i;
  
end architecture;
