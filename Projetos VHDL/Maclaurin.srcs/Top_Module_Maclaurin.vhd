----------------------------------------------------------------------------------
-- Company: FGA/UnB
-- Engineer: Arthur Faria Campos & Felipe
-- 
-- Create Date: 10/01/2017 12:08:46 PM
-- Design Name: 
-- Module Name: Top_Module_Maclaurin - Behavioral
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity Top_Module_Maclaurin is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC; --Botao superior
           start : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR (11 downto 0);
           fx : out STD_LOGIC_VECTOR (11 downto 0);
           ready : out STD_LOGIC);
end Top_Module_Maclaurin;

architecture Behavioral of Top_Module_Maclaurin is

component ula_fixp_nolatch is
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
end component;

-- parametros
constant a :std_logic_vector(11 downto 0) := "000000100000";-- +0.5 
constant b :std_logic_vector(11 downto 0) := "000000001010";-- +0.16650
constant c :std_logic_vector(11 downto 0) := "000001000000";-- +1.0 
 
-- sinais da FSM
type t_state is (inicio,e0a,e0b,e0c,e1a,e1b,e1c,e2a,e2b,e2c,e3a,e3b,e3c);
signal state : t_state := inicio;

-- sinais intermediarios
signal oper_ula1 : std_logic_vector(11 downto 0) := (others=>'0');
signal oper_ula2 : std_logic_vector(11 downto 0) := (others=>'0');
signal saida_ula1 : std_logic_vector(11 downto 0) := (others=>'0');
signal saida_ula2 : std_logic_vector(11 downto 0) := (others=>'0');
signal sel_ula1 : std_logic_vector(3 downto 0) := (others=>'0');
signal sel_ula2 : std_logic_vector(3 downto 0) := (others=>'0');
signal lopa_ula1 : std_logic := '0';
signal lopa_ula2 : std_logic := '0';
signal lopb_ula1 : std_logic := '0';
signal lopb_ula2 : std_logic := '0';
signal start_ula1 : std_logic := '0';
signal start_ula2 : std_logic := '0';
signal ready_ula1 : std_logic := '0';
signal ready_ula2 : std_logic := '0';
signal ready_oper1 : std_logic := '0';
signal ready_oper2 : std_logic := '0';

signal s_x : std_logic_vector(11 downto 0) := (others=>'0');

begin

ula1 : ula_fixp_nolatch port map(
    reset => reset,
    clk => clk,
    start => start_ula1,
    sel => sel_ula1,
    oper => oper_ula1,
    lopA => lopa_ula1,
    lopB => lopb_ula1,
    saida => saida_ula1,
    ready_oper => ready_oper1,
    ready => ready_ula1);

ula2 : ula_fixp_nolatch port map(
    reset => reset,
    clk => clk,
    start => start_ula2,
    sel => sel_ula2,
    oper => oper_ula2,
    lopA => lopa_ula2,
    lopB => lopb_ula2,
    saida => saida_ula2,
    ready_oper => ready_oper2,
    ready => ready_ula2);

process (x)
begin
    if( x(11) = '1' )then
       s_x <= (not x ) + "100000000001";
    else
        s_x <= x;
     end if;
end process;


-- FSM em um unico processo
process(clk,reset)
begin
    if reset ='1' then
        state <= inicio;
        fx <= (others=>'0');
        ready <= '0';
    elsif rising_edge(clk) then    
        case state is
            when inicio =>
                ready <= '0';
                if start = '1' then
                    oper_ula1 <= s_x;
                    oper_ula2 <= s_x;
                    lopa_ula1 <= '1';
                    lopa_ula2 <= '1';
                    state <= e0a;
                end if;
            when e0a => 
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= s_x;
                    oper_ula2 <= b;
                    lopb_ula1 <= '1';
                    lopb_ula2 <= '1';
                    state <= e0b;
                end if;

            when e0b =>
                lopb_ula1 <= '0';
                lopb_ula2 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0010";
                    sel_ula2 <= "0010";
                    start_ula1 <= '1';
                    start_ula2 <= '1';
                    state <= e0c;
                end if;

            when e0c =>
                start_ula1 <= '0';
                start_ula2 <= '0';
                if ready_ula2 = '1' then
                    oper_ula1 <= saida_ula1;
                    oper_ula2 <= saida_ula2;
                    lopa_ula1 <= '1';
                    lopa_ula2 <= '1';
                    state <= e1a;
                end if; 
            when e1a =>
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= a;
                    oper_ula2 <= saida_ula1;
                    lopb_ula1 <= '1';
                    lopb_ula2 <= '1';
                    state <= e1b;
                end if;

            when e1b =>
                lopb_ula1 <= '0';
                lopb_ula2 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0010";
                    sel_ula2 <= "0010";
                    start_ula1 <= '1';
                    start_ula2 <= '1';
                    state <= e1c;
                end if;

            when e1c => 
                start_ula1 <= '0';
                start_ula2 <= '0';
                if ready_ula2 = '1' then
                    oper_ula1 <= saida_ula1;
                    oper_ula2 <= saida_ula2;
                    lopa_ula1 <= '1';
                    lopa_ula2 <= '1';
                    state <= e2a;
                end if; 

            when e2a =>
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= c;
                    oper_ula2 <= s_x;
                    lopb_ula1 <= '1';
                    lopb_ula2 <= '1';
                    state <= e2b;
                end if;

            when e2b =>
                lopb_ula1 <= '0';
                lopb_ula2 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0000";
                    sel_ula2 <= "0000";
                    start_ula1 <= '1';
                    start_ula2 <= '1';
                    state <= e2c;
                end if;

            when e2c => 
                start_ula1 <= '0';
                start_ula2 <= '0';
                if ready_ula2 = '1' then
                    oper_ula2 <= saida_ula1;
                    lopa_ula2 <= '1';
                    state <= e3a;
                end if; 
     
            when e3a =>
                lopa_ula2 <= '0';
                if ready_oper2='1' then
                    oper_ula2 <= saida_ula2;
                    lopb_ula2 <= '1';
                    state <= e3b;
                end if;

            when e3b =>
                lopb_ula2 <= '0';
                if ready_oper2='1' then
                    sel_ula2 <= "0000";
                    start_ula2 <= '1';
                    state <= e3c;
                end if;

            when e3c => 
                start_ula2 <= '0';
                if ready_ula2 = '1' then
                    ready <= '1';
                    fx <= saida_ula2;
                    state <= inicio;
                end if;
                
            when others => state <= inicio; 
        end case;
    end if;
end process;

end Behavioral;












