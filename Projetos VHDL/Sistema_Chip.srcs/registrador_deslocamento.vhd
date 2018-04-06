library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity registrador_deslocamento is
	Port (  reset : in STD_LOGIC;
			clk : in STD_LOGIC;
			anodos : out STD_LOGIC_VECTOR (3 downto 0));
end registrador_deslocamento;

architecture Behavioral of registrador_deslocamento is
begin
	
	process(clk,reset)
	variable aux_anodo : std_logic_vector(4 downto 0) := "11110";
	begin
		if rising_edge(clk) then
			if reset='1' then
				aux_anodo := "11110";
			else
				aux_anodo := aux_anodo(3 downto 0)&'1';
				if aux_anodo = "01111" then
					aux_anodo := "11110";
				end if;
			end if;
			anodos <= aux_anodo(3 downto 0);
		end if;
	end process;

end Behavioral;