library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity FSM_Fechadura_Digital is
    Port (  Clk : in STD_LOGIC; -- Clock da Placa
            Enable: in STD_LOGIC;
            Reset : in STD_LOGIC;
            Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
            Aplica :in STD_LOGIC;   -- Btn para Aplicar
            Password : inout STD_LOGIC_VECTOR(11 downto 0));
end FSM_Fechadura_Digital;

architecture Behavioral of FSM_Fechadura_Digital is

    type Estado is (G0,G1,G2,G3);
    signal Estado_Atual, Proximo_Estado : Estado := G0;
    
begin

    Estados : process (Clk, Reset,Enable)
        begin
            if Reset = '1' then
                Estado_Atual <= G0;
            elsif Enable = '0' then
                Estado_Atual <= G0;
            elsif rising_edge(Clk) then
                Estado_Atual <= Proximo_Estado;
            end if;
    end process;

    Transicao : process(Estado_Atual,Aplica,Switch,Enable,Clk)
        begin
            if rising_edge(Clk) then
                case Estado_Atual is
                    when G0 =>
                            if (Enable ='0') then
                                Proximo_Estado <= G0;
                            else
                                Proximo_Estado <= G1;
                            end if;
                    when G1 =>
                            if (Aplica ='1') then
                                Password(11 downto 8) <= Switch;
                                Proximo_Estado <= G2;
                            else
                                Proximo_Estado <= G1;
                            end if;
                    when G2 =>
                            if (Aplica ='1') then
                                Password(7 downto 4) <= Switch;
                                Proximo_Estado <= G3;
                            else
                                Proximo_Estado <= G2;
                            end if;
                    when G3 =>
                            if (Aplica ='1') then
                                Password(3 downto 0) <= Switch;
                                Proximo_Estado <= G1;
                            else
                                Proximo_Estado <= G3;
                            end if;
                end case;
            end if;
    end process;

end Behavioral;