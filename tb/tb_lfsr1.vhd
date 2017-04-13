------------------------------------------------------------------
-- File Name   : tb_lfsr1.vhd
--  Comments   : Test bench for the LFSR tutorial
--				 Version 1.2 (Chapter 3-4)
------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_textio.all;
  use ieee.numeric_std.ALL;
  use std.textio.all;
  use work.lfsr_pkg.all;
    
entity tb_lfsr1 is
end entity;

architecture test of tb_lfsr1 is

    constant PERIOD  : time   := 10 ns;
    constant log_file: string := "res.log";

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '1';
    signal en        : std_logic := '0';
    signal count     : std_logic_vector (LFSR_W-1 downto 0);
    signal endSim	   : boolean   := false;

    component lfsr1 is
      port (
        reset     : in  std_logic;                       
        clk       : in  std_logic;
        en        : in  std_logic;          
        count     : out std_logic_vector (LFSR_W-1 downto 0)   
      );
    end component;

begin
  clk     <= not clk after PERIOD/2;
  reset   <= '0' after  PERIOD*10;

	-- Main simulation process
	main_pr : process 
	begin
		wait until (reset = '0');
		wait until (clk = '1');
		wait until (clk = '1');
		wait until (clk = '1');
		en <= '1';
		for i in 0 to 7 loop
		  wait until (clk = '1');
		end loop;
		en <= '0';  
		wait until (clk = '1');
		en <= '1'; 
		while (not endSim) loop
      wait until (clk = '1');
    end loop;  
	end process main_pr;	

	-- End the simulation
	stop_pr : process 
	begin
		if (endSim) then
			assert false 
				report "End of simulation." 
				severity failure; 
		end if;
		wait until (clk = '1');
	end process stop_pr;	

  DUT : lfsr1
    port map (
      clk      => clk,
      reset    => reset,
      en       => en,
      count    => count
    );

  -- Save data to file
  save_data_pr : process 
		file 		file_id: 	text;
		variable 	line_num: 	line;
		variable	cnt:		integer := 0;
	begin
		-- Open the file
		file_open(file_id, log_file, WRITE_MODE);
		wait until (reset = '0' and en = '1');
		wait until (clk = '1');
		
		-- Loop and write all values to a file		
		for cnt in 0 to 2048*2-1 loop
   	  write(line_num, to_integer(unsigned(count)) ); 
		  writeline(file_id, line_num);
		  wait until (en = '1' and clk = '1');
		end loop;
		
		file_close(file_id);
		endSim <= true;
		wait until (clk = '1');

	end process save_data_pr;	

end architecture;