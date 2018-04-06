library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



entity TB_DIGITAL_LOCKER is
--  Port ( );
end TB_DIGITAL_LOCKER;

architecture Behavioral of TB_DIGITAL_LOCKER is

Component Top_Module_FechaduraDigital is
    Port ( 	Clk : in STD_LOGIC; -- Clock da Placa
    		Reset : in STD_LOGIC;
    		Switch : in STD_LOGIC_VECTOR (3 downto 0); -- Switches da Senha
           	Grava : in STD_LOGIC;	-- Btn para Gravar
           	Aplica :in STD_LOGIC;	-- Btn para Aplicar
           	Abre : out STD_LOGIC;	-- Led Aberto/Fechado
           	Alarme : out STD_LOGIC;	--Led de Alarme
           	Led_Aux: out STD_LOGIC);	--Led do Clock de 4Hz
end Component;

Signal sClk,sGrava,sAplica,sAbre,sAlarme,sReset, sLed: STD_LOGIC;
Signal sSwitch : STD_LOGIC_VECTOR (3 downto 0);


begin

	uut: Top_Module_FechaduraDigital port map(	Clk => sClk,
												Reset => sReset,
												Switch => sSwitch,
												Grava => sGrava,
												Aplica => sAplica,
												Abre => sAbre,
												Alarme => sAlarme,
												Led_Aux => sLed);


Clk: process
begin 
	sClk <= '0';
	wait for 1 ns;
	sClk <= '1';
	wait for 1 ns;
end process;


Stim: process
begin
	sGrava <= '0';
	sReset <= '1';
	sAplica <= '0';
	wait for 10 ns;
	sReset <= '0';
	sGrava <= '1';
	wait for 100 ns;
	sAplica <= '1';
	sSwitch <= "0101";
	wait for 10 ns;
	sAplica <= '0';
	wait for 100 ns;
	sAplica <= '1';
	sSwitch <= "0100";
	wait for 10 ns;
	sAplica <= '0';
	wait for 100 ns;
    sAplica <= '1';
    sSwitch <= "0110";
    wait for 10 ns;
    sAplica <= '0';
    sGrava <= '0';
    wait for 500 ns;
    
    sAplica <= '1';
    sSwitch <= "0101";
    wait for 10 ns;
    sAplica <= '0';
    wait for 100 ns;
    sAplica <= '1';
    sSwitch <= "0100";
    wait for 10 ns;
    sAplica <= '0';
    wait for 100 ns;
    sAplica <= '1';
    sSwitch <= "0110";
    wait for 10 ns;
    sAplica <= '0';
    wait;
end process;
end Behavioral;
