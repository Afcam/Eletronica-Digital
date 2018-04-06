library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Top_Module_PWM is
--  Port ( );
end TB_Top_Module_PWM;

architecture Behavioral of TB_Top_Module_PWM is

Component Top_Module_PWM is
    Port ( 	Clk : in STD_LOGIC;
    		swTimer : in STD_LOGIC_VECTOR(3 downto 0);
    		swDuty : in STD_LOGIC_VECTOR(3 downto 0);
    		swEnable : in STD_LOGIC;
    		swReset : in STD_LOGIC;
    		Led : out STD_LOGIC);
end Component;
Signal sClk,sEnable,sReset, sLed: STD_LOGIC;
Signal sTimer: STD_LOGIC_VECTOR(3 downto 0);
signal sDuty : STD_LOGIC_VECTOR(3 downto 0);

begin

	uut: Top_Module_PWM port map(	Clk => sClk,
						    		swTimer => sTimer,
						    		swDuty => sDuty,
						    		swEnable => sEnable,
						    		swReset => sReset,
						    		Led => sLed);
Clk: process
begin 
	sClk <= '0';
	wait for 1 ns;
	sClk <= '1';
	wait for 1 ns;
end process;
Stim: process
begin
    sTimer <= "0000";
	sEnable <= '1';
	sReset <= '1';
	sDuty <= "0000";
	wait for 10 ns;
	sTimer <= "1111";	
	sReset <= '0';
	wait for 200 ns;
	sDuty <= "0001";
		wait for 500 ns;
	sDuty <= "0010";
		wait for 500 ns;
	sDuty <= "0011";
		wait for 500 ns;
	sDuty <= "0100";
		wait for 500 ns;
	sDuty <= "0101";
		wait for 500 ns;
	sDuty <= "0110";
		wait for 500 ns;
	sDuty <= "0111";
		wait for 500 ns;
	sDuty <= "1000";
		wait for 500 ns;
	sDuty <= "1001";
		wait for 500 ns;
	sDuty <= "1010";
		wait for 500 ns;
	sDuty <= "1011";
		wait for 500 ns;
	sDuty <= "1100";
		wait for 500 ns;
	sDuty <= "1101";
		wait for 500 ns;
	sDuty <= "1110";
		wait for 500 ns;
	sDuty <= "1111";
	wait;
end process;
end Behavioral;

