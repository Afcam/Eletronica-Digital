library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity FSM2_Fechadura_Digital is
    Port ( 	Clk : in STD_LOGIC; -- Clock da Placa
    		Enable: in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
           	Aplica :in STD_LOGIC;	-- Btn para Aplicar
           	Password : in STD_LOGIC_VECTOR(11 downto 0);	-- Led Aberto/Fechado
           	Abre : out STD_LOGIC;	-- Led Aberto/Fechado
           	Alarme : out STD_LOGIC);	--Led de Alarme  
end FSM2_Fechadura_Digital;

architecture Behavioral of FSM2_Fechadura_Digital is

	type Estado is (Init,S0,S1,S2,S3,E1,E2,E3);
	signal Estado_Atual, Proximo_Estado : Estado := S0;



begin

	Estados : process (Clk, Reset,Enable)
		begin
			if Reset = '1' then
				Estado_Atual <= Init;
			elsif Enable = '1' then
			    Estado_Atual <= Init;
			elsif rising_edge(Clk)  then
				Estado_Atual <= Proximo_Estado;
			end if;
	end process;

	Transicao : process(Estado_Atual,Aplica,Switch,Password,Enable)
		begin
			case Estado_Atual is
				when Init =>
                        if (Enable ='0') then
                            Proximo_Estado <= S0 ;
                        else
                            Proximo_Estado <= Init;
                        end if;
				when S0 =>
						if (Aplica ='1' and Password(11 downto 8) = Switch) then 
                            Proximo_Estado <= S1;
                        elsif (Aplica ='1' and Password(11 downto 8) /= Switch) then 
                            Proximo_Estado <= E1;
                        else
                     	    Proximo_Estado <= S0;
                        end if;
				when S1 =>
						if (Aplica ='1' and Password(7 downto 4) = Switch) then 
                            Proximo_Estado <= S2;
                        elsif (Aplica ='1' and Password(7 downto 4) /= Switch) then 
                            Proximo_Estado <= E2;
                        else
                     	    Proximo_Estado <= S1;
                        end if;
				when S2 =>
						if (Aplica ='1' and Password(3 downto 0) = Switch) then 
                            Proximo_Estado <= S3;
                        elsif (Aplica ='1' and Password(3 downto 0) /= Switch) then 
                            Proximo_Estado <= E3;
                        else
                     	    Proximo_Estado <= S2;
                        end if;
				when S3 =>
						if Aplica ='1' then 
                            Proximo_Estado <= S0;
                           else
                     	    Proximo_Estado <= S3;
                        end if;
               when E1 =>
						if Aplica ='1' then 
                            Proximo_Estado <= E2;
                           else
                     	    Proximo_Estado <= E1;
                        end if;
                when E2 =>
						if Aplica ='1' then 
                            Proximo_Estado <= E3;
                           else
                     	    Proximo_Estado <= E2;
                        end if;
                when E3 =>
						Proximo_Estado <= S0;
			end case;
	end process;

	Saidas : process (Estado_Atual)
	begin
			if (Estado_Atual = S3) then
				Abre <= '1';
			else
				Abre <= '0';
			end if;
			if (Estado_Atual = E3) then
				Alarme <= '1';
			else
				Alarme <= '0';
			end if;
	end process;
end Behavioral;