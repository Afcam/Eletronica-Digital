library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity mux4_1 is
	Port (  reset : in std_logic;
			clk : in std_logic;
			dig1 : in STD_LOGIC_VECTOR (3 downto 0);
			dig2 : in STD_LOGIC_VECTOR (3 downto 0);
			dig3 : in STD_LOGIC_VECTOR (3 downto 0);
			dig4 : in STD_LOGIC_VECTOR (3 downto 0);
			saida : out STD_LOGIC_VECTOR (3 downto 0));
end mux4_1;

architecture Behavioral of mux4_1 is
	signal sel : STD_LOGIC_VECTOR (1 downto 0) := "00";

begin
	with sel select
		saida <= dig1 when "00",
				 dig2 when "01",
				 dig3 when "10",
				 dig4 when others;
				 
	process(clk,reset)
	begin
		if rising_edge(clk) then
			if reset='1' then
				sel<="00";
			else
				sel <= sel+"01";
			end if;
		end if;
	end process;
end Behavioral;