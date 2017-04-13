------------------------------------------------------------------
-- Name		   : lfsr_pkg.vhd
-- Description : Package for LFSR - Part of the LFSR tutorial
-- Designed by : Claudio Avi Chami - FPGA Site
--               https://fpgasite.wordpress.com
-- Date        : 09/Aug/2016
-- Version     : 01
------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
	use ieee.numeric_std.ALL;
    
package lfsr_pkg is
    constant LFSR_W : natural := 11;		-- LFSR width
end lfsr_pkg;
