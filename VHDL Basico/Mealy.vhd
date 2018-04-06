library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mealy is
	Port (	A: in STD_LOGIC;
			Clk: in STD_LOGIC;
			Reset :in STD_LOGIC;
			Z : out STD_LOGIC);
end Mealy;

architecture Behavioral of Mealy is

	type Estado is (E0, E1, E2, E3);
	signal Estado_Atual, Proximo_Estado : Estado := E0;
	
begin

Estados : process (Clk, Reset)
	begin
		if Reset = '1' then
			Estado_Atual <= E0;
		elsif rising_edge(Clk) then
			Estado_Atual <= Proximo_Estado;
		end if;
end process;

	Transicao : process(Estado_Atual, A)
		begin
			case Estado_Atual is
				when E0 =>
						if A = '1' then	
							Proximo_Estado <= E1;
							Z <= '0';
						else
							Proximo_Estado <= E0;
							Z <= '0';
						end if;
				when E1 =>
						if A = '0' then	
							Proximo_Estado <= E2;
							Z <= '0';
						else
							Proximo_Estado <= E1;
							Z <= '0';
						end if;
				when E2 =>
					Z <= '0';
						if A = '0' then	
							Proximo_Estado <= E3;
							Z <= '0';
						else
							Proximo_Estado <= E1;
							Z <= '0';
						end if;
				when E3 =>
						if A = '1' then	
							Proximo_Estado <= E1;
							Z <= '1';
						else
							Proximo_Estado <= E0;
							Z <= '0';
						end if;
			end case;
	end process;
end Behavioral;