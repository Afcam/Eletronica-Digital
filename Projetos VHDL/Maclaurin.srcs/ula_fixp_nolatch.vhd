----------------------------------------------------------------------------------
-- Company: FGA/UnB
-- Engineer: Prof. Daniel M. Muñoz
-- 
-- Create Date: 09/13/2017 11:18:45 AM
-- Design Name: Lab PDE2 
-- Module Name: fsm_ula_fixp_B - Behavioral
-- Project Name: 
-- Target Devices: Artix7
-- Tool Versions: 
-- Description: This is a FSM implementation of a 12 bits fix point ULA 
--              It was supposed that only one 12 bits input is avaliable; 
--              therefore, two states for register the operands were required.
--              This FSM was implemented using one sequencial process for registering states.
--              one combinational process for state transition and one sequencial processes 
--              for each output. It was also included a flag called 'ready_oper' that indicates
--              when a operand was effectively registered.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Students should include +1, <=, >= and = operations
--                      It is suggested that students practice IP-core instantiation
--                      for implementing a 12 bits division operation
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity ula_fixp_nolatch is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           oper : in STD_LOGIC_VECTOR (11 downto 0);
           lopA : in STD_LOGIC;
           lopB : in STD_LOGIC;
           saida : out STD_LOGIC_VECTOR (11 downto 0);
           ready_oper : out STD_LOGIC;
           ready : out STD_LOGIC);
end ula_fixp_nolatch;

architecture Behavioral of ula_fixp_nolatch is

type t_state is (inicio,regopA,regopB,add,sub,mul,div,shiftL,shiftR,Land,Lor,Lxor,display);
signal current_state, next_state : t_state := inicio;
signal opA, opB, s_saida : std_logic_vector(11 downto 0):=(others=>'0');
signal mul_out : std_logic_vector(23 downto 0):=(others=>'0');

begin

mul_out <= opA * opB;

with sel select
s_saida <= opA + opB when "0000",
           opA - opB when "0001",
           mul_out(23) & mul_out(16 downto 6) when "0010", -- Estou fazendo aqui o truncamento. Eliminei estado Trunc 
           opA + opB when "0011", -- modifique aqui para colocar saida do IP de divisao 
           opA(10 downto 0)&'0' when "1000",
           '0'&opA(11 downto 1) when "1001",
           opA and opB when "1010",
           opA or opB when "1011",
           opA xor opB when "1100",
           (others=>'0') when others;

-- processo sequencial para armazenar estado atual
process(clk,reset)
begin
    if rising_edge(clk) then
        if reset='1' then
            current_state <= inicio;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

-- processo combinacional para transicao de estados
process(current_state,oper,lopA,lopB,start,sel)
begin
    case current_state is
        when inicio =>
            if lopA='1' then
                next_state <= regopA;
            elsif lopB='1' then
                next_state <= regopB;
            elsif start='1' and sel="0000" then
                next_state <= add;
            elsif start='1' and sel="0001" then
                next_state <= sub;
            elsif start='1' and sel="0010" then
                next_state <= mul;
            elsif start='1' and sel="0011" then
                next_state <= div;
            elsif start='1' and sel="1000" then
                next_state <= shiftL; 
            elsif start='1' and sel="1001" then
                next_state <= shiftR; 
            elsif start='1' and sel="1010" then
                next_state <= Land;
            elsif start='1' and sel="1011" then
                next_state <= Lor; 
            elsif start='1' and sel="1100" then
                next_state <= Lxor; 
            else
                next_state <= inicio; 
            end if;
        when regopA =>
            next_state <= inicio;
        when regopB =>
            next_state <= inicio;
        when add =>
            next_state <= display;
        when sub =>
            next_state <= display;
        when mul =>
            next_state <= display;
        when div =>
            --- Quem tem coragem de colocar um IP-Core?
            next_state <= display;
        when shiftL =>
            next_state <= display;
        when shiftR =>
            next_state <= display;
        when Land =>
            next_state <= display;
        when Lor =>
            next_state <= display;
        when Lxor =>
            next_state <= display;
        --when trunc =>
        --    next_state <= display;
        when display =>
            next_state <= inicio;
        when others => 
            next_state <= inicio;
    end case;
end process;

process(clk,reset)
begin
    if rising_edge(clk) then
        case current_state is
            when regopA => opA <= oper;
            when others => null;
        end case;
    end if;
end process;

process(clk,reset)
begin
    if rising_edge(clk) then
        case current_state is
            when regopB => opB <= oper;
            when others => null;
        end case;
    end if;
end process;

process(clk,reset)
begin
    if rising_edge(clk) then
        saida <= s_saida;
--        case current_state is
--            when trunc =>  
--                saida(11) <= mul_out(23);
--                saida(10 downto 0) <= mul_out(16 downto 6);
--            when others =>
--                saida <= s_saida;
--        end case;
    end if;
end process;

process(clk,reset)
begin
    if rising_edge(clk) then
        case current_state is
            when inicio => ready <= '0';
            when display => ready <= '1';
            when others => ready <= '0';
        end case;
    end if;
end process;

-- processo para ready operando
process(clk,reset)
begin
    if rising_edge(clk) then
        case next_state is
            when regopA => ready_oper <= '1';
            when regopB => ready_oper <= '1';
            when others => ready_oper <= '0';
        end case;
    end if;
end process;

end Behavioral;















