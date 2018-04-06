library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisao is
    Port ( opA : in STD_LOGIC_VECTOR (11 downto 0);
           opB : in STD_LOGIC_VECTOR (11 downto 0);
           div : out STD_LOGIC_VECTOR (11 downto 0));
end divisao;

architecture Behavioral of divisao is
signal binario: STD_LOGIC_VECTOR (11 downto 0);
signal binario2: STD_LOGIC_VECTOR (11 downto 0);
signal s_decimalA: integer;
signal s_decimalB: integer;
signal divInte: integer;

begin
binario<= opA;
binario2<=opB;
s_decimalA <= to_integer(signed(binario(11 downto 0))); 
s_decimalB <= to_integer(signed(binario2(11 downto 0))); 
--funcao to_interger faz a conversao para decimal de um binario
divInte<= s_decimalA/s_decimalB;
div<=
end Behavioral;

