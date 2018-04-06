library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity overflow is
    Port ( clk : in STD_LOGIC;
           en: std_logic;
           opA : in STD_LOGIC_VECTOR (11 downto 0);
           opB : in STD_LOGIC_VECTOR (11 downto 0);
           overflow : out STD_LOGIC);
end overflow;

architecture Behavioral of overflow is
signal soverflow: std_logic;
signal soma: std_logic_vector(11 downto 0);
begin
soma<= opA + opB;
overflow<= soverflow;
overflowProcess: process(clk,opA,opB,soma)
begin
    if rising_edge(clk) then
        if en = '0' then
           soverflow<= '0';
        else    
            if opA(11) = '0' and opB(11) = '0' and soma(11)='1' then
                soverflow<= '1';
            else
                soverflow<= '0';
            end if;    
        end if;      
    end if;
end process;  

end Behavioral;
