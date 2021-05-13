library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.parameters.all;

entity spi_tb is
end spi_tb;

architecture spi_tb_behav of spi_tb is



	SIGNAL s_CLK, s_CS, s_MOSI, s_SCLK, s_RST, s_SET_DATA, s_BUSY: std_logic;
	SIGNAL s_DATA: std_logic_vector(c_LEN downto 0) := (others => '0');
	SIGNAL s_DATA_LEN: integer := 8;

	

begin
	spi_unit: entity work.spi 
				port map( p_i_clk => 		s_CLK,
							p_o_spi_cs => 	s_CS,
							p_o_spi_clk => 	s_SCLK,
							p_o_spi_mosi => s_MOSI,
							p_i_rst	=> 		s_RST,
							p_i_data => 	s_DATA,
							p_i_data_len =>	s_DATA_LEN,
							p_i_set_data =>	s_SET_DATA,
							p_o_out_busy => s_BUSY
						);

	process begin
		s_CLK <= '1';
		wait for 1 ns;
		s_CLK <= '0';
		wait for 1 ns;
	end process;

	process begin
		s_RST <= '0';
		wait for 10 ns;
		s_RST <= '1';
		wait for 10 ns;
		s_RST <= '0';
		wait;
	end process;

	process begin
		s_DATA(c_LEN downto c_LEN - 7) <= x"AB";
		s_SET_DATA <= '0';
		s_DATA_LEN <= 8;
		wait for 40 ns;
		s_SET_DATA <= '1';
		wait for 5 ns;
		s_SET_DATA <= '0';
		wait;
	end process;


end spi_tb_behav;