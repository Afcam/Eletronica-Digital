library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



entity Top_Module_PWM is
    Port ( 	Clk : in STD_LOGIC;
    		swTimer : in STD_LOGIC_VECTOR(3 downto 0);
    		swDuty : in STD_LOGIC_VECTOR(3 downto 0);
    		swEnable : in STD_LOGIC;
    		swReset : in STD_LOGIC;
    		Led : out STD_LOGIC);
end Top_Module_PWM;

architecture Behavioral of Top_Module_PWM is

--Component de PWM -----------------------------------------------------------------------------
Component PWM is
    Port ( 	Timer : in STD_LOGIC_VECTOR(3 downto 0);
    		Duty : in STD_LOGIC_VECTOR(3 downto 0);
    		Enable : in STD_LOGIC;
    		Clk : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		PWM_out : out STD_LOGIC);
end Component;
------------------------------------------------------------------------------------
begin
	PWM_Module : PWM port map ( Timer => swTimer,
								Duty => swDuty,
								Enable => swEnable,
								Clk => Clk,
								Reset => swReset,
								PWM_out => Led);

end Behavioral;

