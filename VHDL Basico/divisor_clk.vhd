library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity divisor_clk is
	generic (preset : std_logic_vector(24 downto 0):= (others=>'0'));
	port (  reset : in STD_LOGIC;
			clk : in STD_LOGIC;
			outclk : out STD_LOGIC);
end divisor_clk;

architecture Behavioral of divisor_clk is

	signal count : std_logic_vector(24 downto 0) := (others=>'0');
	signal clkaux : std_logic := '0';

begin

	outclk <= clkaux;
	process(clk,reset)
	begin
		if rising_edge(clk) then
			if reset='1' then
				count <= (others=>'0');
				clkaux <= '0';
			elsif count=preset then
				clkaux <= not clkaux;
				count <= (others=>'0');
			else
				count <= count + '1';
			end if;
		end if;
	end process;

end Behavioral;