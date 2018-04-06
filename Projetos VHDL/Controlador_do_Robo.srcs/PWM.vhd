library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity PWM is
    Port ( 	Duty : in STD_LOGIC_VECTOR(3 downto 0);
    		Enable : in STD_LOGIC;
    		Clk : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		PWM_out : out STD_LOGIC);
end PWM;

architecture Behavioral of PWM is

	signal sCycle_off : STD_LOGIC_VECTOR(3 downto 0);
	signal sCount : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	signal sPWM_out : STD_LOGIC;
    signal Timer: STD_LOGIC_VECTOR(3 downto 0) :="0000";
begin
    Timer<= "1111";
	sCycle_off <= Timer - Duty - '1';

-- Caso Especial

 PWM_out<= sPWM_out;

	PWM: process (Clk,Reset)
		begin
			if(Reset = '1') then
				sPWM_out <= '0';
				sCount <= "0000";
			elsif rising_edge(Clk) then
				if (Enable = '1') then
					sCount <= sCount + '1';
					if (Duty >= Timer) then 
						sPWM_out <= '1';
					elsif ( sCount = sCycle_off) then
						sPWM_out <= '1';
					elsif ( sCount = Timer) then 
						sPWM_out <= '0';
						sCount <= "0000";
					end if;
				else
					sPWM_out <= '0';
					sCount <= "0000";
				end if;
			end if;
	end process;					

end Behavioral;
