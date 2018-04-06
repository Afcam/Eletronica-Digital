library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity underflow is
    Port ( clk: in std_logic;
           en: in std_logic;
           opA : in STD_LOGIC_VECTOR (11 downto 0);
           opB : in STD_LOGIC_VECTOR (11 downto 0);
           underflow : out STD_LOGIC);
end underflow;

architecture Behavioral of underflow is
signal sunderflow: std_logic;
signal sub: std_logic_vector(11 downto 0);
begin
sub<= opA - opB;
underflow<= sunderflow;
underflow_pro: process(clk,opA,opB,sub)
begin
    if rising_edge(clk) then
        if en = '0' then
            sunderflow<= '0';
        else    
            if opA(11) = '1' and opB(11) = '1' and sub(11)='0' then
                sunderflow<= '1';
            else
                sunderflow<= '0';
            end if;            
        end if;      
    end if;
end process;  
end Behavioral;
