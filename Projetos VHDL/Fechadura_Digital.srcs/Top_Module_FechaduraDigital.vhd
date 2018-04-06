library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Top_Module_FechaduraDigital is
    Port ( 	Clk : in STD_LOGIC; -- Clock da Placa
    		Reset : in STD_LOGIC;
    		Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
           	Grava : in STD_LOGIC;	-- Btn para Gravar
           	Aplica :in STD_LOGIC;	-- Btn para Aplicar
           	Abre : out STD_LOGIC;	-- Led Aberto/Fechado
           	Alarme : out STD_LOGIC;	--Led de Alarme
           	Led_Aux: out STD_LOGIC;
           	Grava_out : out STD_LOGIC);	--Led do Clock de 4Hz
end Top_Module_FechaduraDigital;

architecture Behavioral of Top_Module_FechaduraDigital is
--Divisor de Clock ------------------------------------------------------------------------------
Component Clock_Divider is
	Generic(Preset : INTEGER);
    Port ( 	Clk_in : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		Clk_out : out STD_LOGIC);
end Component;

-- Sinais Utilizados no Divisor de Clock
signal sClk_4Hz: STD_LOGIC := '0';
------------------------------------------------------------------------------------

--FSM 2------------------------------------------------------------------------------
Component FSM2_Fechadura_Digital is
    Port ( 	Clk : in STD_LOGIC; -- Clock da Placa
    	    Enable: in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
           	Aplica :in STD_LOGIC;	-- Btn para Aplicar
           	Password : in STD_LOGIC_VECTOR(11 downto 0);	-- Led Aberto/Fechado
           	Abre : out STD_LOGIC;	-- Led Aberto/Fechado
           	Alarme : out STD_LOGIC);	--Led de Alarme  
end Component;

-- Sinais Utilizados 
signal sAlarme : STD_LOGIC := '0';
signal sEstado_Alarme : STD_LOGIC := '0';
signal sAbre : STD_LOGIC := '0';
signal sPassword : STD_LOGIC_VECTOR ( 11 downto 0) := "000000000000"; 
------------------------------------------------------------------------------------
--FSM 1------------------------------------------------------------------------------
Component FSM_Fechadura_Digital is
    Port (  Clk : in STD_LOGIC; -- Clock da Placa
            Enable: in STD_LOGIC;
            Reset : in STD_LOGIC;
            Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
            Aplica :in STD_LOGIC;   -- Btn para Aplicar
            Password : inout STD_LOGIC_VECTOR(11 downto 0));
end Component;
------------------------------------------------------------------------------------


begin

	Led_Aux <= sClk_4Hz;
	Abre <= sAbre;
	Alarme <= sEstado_Alarme;
	Grava_out <= Grava;

	Clock_4Hz: Clock_Divider generic map (Preset => 200000000) -- Mudar para 124 999 99
							 port map (	Clk_in => Clk,
										Reset => Reset,
										Clk_out => sClk_4Hz);

	FSM2 : FSM2_Fechadura_Digital port map (	Clk => sClk_4Hz,
											Enable => Grava,
											Reset => Reset,
											Switch => Switch,
											Aplica => Aplica,
											Password => sPassword,
											Abre => sAbre,
											Alarme => sAlarme);

	FSM : FSM_Fechadura_Digital port map (	Clk => sClk_4Hz,
											Enable => Grava,
											Reset => Reset,
											Switch => Switch,
											Aplica => Aplica,
											Password => sPassword);

	
		A: process (sAlarme,sAbre)
            begin
                if (sAbre ='1') or Reset ='1' then
                    sEstado_Alarme <= '0';
                elsif rising_edge(sAlarme) then
                     sEstado_Alarme <= '1';
                end if;
		end process A;


end Behavioral;
