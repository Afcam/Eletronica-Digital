    ----------------------------------------------------------------------------------
-- Unb/ FGA
-- Grupo 03
--
-- Create Date: 24.06.2017 15:12:30
-- Module Name: Conversor_BinBCD - Behavioral
-- Project Name: GNPA_5.0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Conversor_BinBCD is
    Port ( Valor : in integer range 0 to 4095;
           M : out STD_LOGIC_VECTOR (3 downto 0);--N?mero dos Milhares.
           C : out STD_LOGIC_VECTOR (3 downto 0);--N?mero das Centenas.
           D : out STD_LOGIC_VECTOR (3 downto 0);--N?mero das dezenas.
           U : out STD_LOGIC_VECTOR (3 downto 0)); -- numero para os leds
end Conversor_BinBCD;

architecture Behavioral of Conversor_BinBCD is

begin
Divisao: process(Valor)
Variable Un: integer;--5Recebe n?mero das dezenas.
variable Dz: integer;--Recebe o n?mero das unidades.
variable Cn: integer;--Recebe o n?mero das unidades.
variable Mi: integer;--Recebe o n?mero das unidades.

begin
    --Calculando o valor dos Milhares.
    Mi := Valor/1000;
    --Calculando o valor das Centenas.
    Cn := (Valor mod 1000) /100;
    --Calculando o valor das dezenas.
    Dz := (Valor mod 100)/10;
    --Calculando o valor das unidades.
    Un := Valor mod 10;
    --Convertendo os valores da unidades e das dezenas para um vector.
    M <= std_logic_vector(to_unsigned(Mi ,4));
    C <= std_logic_vector(to_unsigned(Cn, 4));
    D <= std_logic_vector(to_unsigned(Dz ,4));
    U <= std_logic_vector(to_unsigned(Un, 4));
end process Divisao;
end Behavioral;                                                                                    --- Arthur-fc