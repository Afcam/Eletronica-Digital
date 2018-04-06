----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2017 10:07:15
-- Design Name: 
-- Module Name: comparacao - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comparacao is
    Port ( clk: in std_logic;
           opA : in STD_LOGIC_VECTOR (11 downto 0);
           opB : in STD_LOGIC_VECTOR (11 downto 0);
           igual : out STD_LOGIC;
           menorQ : out STD_LOGIC;
           maiorQ : out STD_LOGIC);
end comparacao;

architecture Behavioral of comparacao is
signal sigual,smenorQ,smaiorQ: std_logic;
begin
igual<=sigual;
menorQ<=smenorQ;
maiorQ<=smaiorQ;
process(clk,opA,OpB)
begin
    if rising_edge(clk) then
        if Opa>OpB then
            smaiorQ<= '1';
            smenorQ<= '0';
            sigual<='0';
        elsif OpA<OpB then 
            smenorQ<= '1';
            smaiorQ<= '0';
            sigual<='0';
        else
            smenorQ<= '0';
            smaiorQ<= '0';
            sigual<= '1';
        end if;
    end if;                            
end process;

end Behavioral;
