library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity main is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           L : in STD_LOGIC;
           C : in STD_LOGIC;
           R : in STD_LOGIC;
           BL : in STD_LOGIC_VECTOR (1 downto 0);
           LM : out STD_LOGIC_VECTOR (1 downto 0);
           RM : out STD_LOGIC_VECTOR (1 downto 0);
           ledPotMotor: out Std_logic_vector (1 downto 0));
end main;
architecture Behavioral of main is

type estados is (inicial, movD, movE, movF, parado);

signal next_state, current_state: estados:= inicial;
signal s_LM, s_RM, s_led: std_logic_vector(1 downto 0);
signal sDuty: std_logic_vector (3 downto 0);
signal sEnableD, sEnableE: std_logic;

component PWM is
    Port ( 	Duty : in STD_LOGIC_VECTOR(3 downto 0);
    		Enable : in STD_LOGIC;
    		Clk : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		PWM_out : out STD_LOGIC);
end component;

begin

--Processo sequencial p/ armazenar estados
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            current_state <= inicial;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

--Processo para transicao de estados
-- Quando C = '1' movimento suave & '0' rapido
process(rst,R,L,C,current_state,clk)
begin
if rising_edge(clk) then
    case current_state is
        when inicial =>
            if rst = '1' then
                s_LM <= (OTHERS=>'0');
                s_RM <= (OTHERS=>'0');
                s_led <= "00";
                next_state <= inicial;
            elsif R = '1' and L = '0' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movD;
            elsif R = '0' and L = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movE;
            elsif R = '0' and L = '0' and C = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= movF;
            else
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= parado;
           end if;
        when movD =>
            if rst = '1' then
                s_LM <= (OTHERS=>'0');
                s_RM <= (OTHERS=>'0');
                s_led <= "00";
                next_state <= inicial;
            elsif R = '1' and L = '0' then
                if C = '1' then
                    s_LM <= "01";
                    s_Rm <= "00";
                    s_led <= "10";
                    next_state <= movD;
                else
                     s_LM <= "01";
                     s_Rm <= "10";
                     s_led <= "11";
                     next_state <= movD;
                end if;
            elsif R = '0' and L = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movE;
            elsif R = '0' and L = '0' and C = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= movF;
            else
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= parado;
            end if;        
        when movE =>
            if rst = '1' then
                s_LM <= (OTHERS=>'0');
                s_RM <= (OTHERS=>'0');
                s_led <= "00";
                next_state <= inicial;
            elsif R = '1' and L = '0' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movD;
            elsif R = '0' and L = '1' then
                if C = '1' then
                    s_LM <= "00";
                    s_Rm <= "01";
                    s_led <= "01";
                    next_state <= movE;
                else
                     s_LM <= "10";
                     s_Rm <= "01";
                     s_led <= "11";
                     next_state <= movE;
                end if;
            elsif R = '0' and L = '0' and C = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= movF;
            else
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= parado;
            end if;
        when MovF =>
            if rst = '1' then
                s_LM <= (OTHERS=>'0');
                s_RM <= (OTHERS=>'0');
                s_led <= "00";
                next_state <= inicial;
            elsif R = '1' and L = '0' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movD;
            elsif R = '0' and L = '1' then
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00";
                next_state <= movE;
            elsif R = '0' and L = '0' and C = '1' then
                s_LM <= "01";
                s_RM <= "01";
                s_led <= "11"; 
                next_state <= movF;
            else
                s_LM <= "00";
                s_RM <= "00";
                s_led <= "00"; 
                next_state <= parado;
            end if;
        when parado =>
            s_LM <= "00";
            s_RM <= "00";
            s_led<= "00";
            next_state <= inicial;
     end case;
 end if;            
end process;

LM<= s_LM;
RM<= s_RM;
sEnableD <= s_led(0);
sEnableE <= s_led(1);

process(BL, sEnableE, sEnableD)
begin
    if BL = "00" then
        if sEnableD = '1' and sEnableE= '0' then
            sDuty <= "1011";
        elsif sEnableD = '0' and sEnableE= '1' then
            sDuty <= "1011";
        else
            sDuty <= "1111";
        end if;          
    elsif BL = "01" and (sEnableD = '1' or sEnableE = '1') then
        if sEnableD = '1' and sEnableE= '0' then
            sDuty <= "0111";
        elsif sEnableD = '0' and sEnableE= '1' then
            sDuty <= "0111";
        else
            sDuty <= "1011";
        end if;
    elsif BL = "10" and (sEnableD = '1' or sEnableE = '1') then
        if sEnableD = '1' and sEnableE= '0' then
            sDuty <= "0011";
        elsif sEnableD = '0' and sEnableE= '1' then
            sDuty <= "0011";
        else
            sDuty <= "0111";
        end if;
    else
        if sEnableD = '1' and sEnableE= '0' then
            sDuty <= "0000";
        elsif sEnableD = '0' and sEnableE= '1' then
            sDuty <= "0000";
        else
            sDuty <= "0011";
        end if;
    end if;   
end process;
 PWM_ModuleE : PWM port map ( 	Duty => sDuty,
								Enable => sEnableE,
								Clk => clk,
								Reset => rst,
								PWM_out => ledPotMotor(1));
PWM_ModuleD : PWM port map (    Duty => sDuty,
								Enable => sEnableD,
								Clk => clk,
								Reset => rst,
								PWM_out => ledPotMotor(0));
								
end Behavioral;
