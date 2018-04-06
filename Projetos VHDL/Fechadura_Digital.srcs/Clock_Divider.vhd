library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Clock_Divider is
	Generic (Preset : INTEGER);
    Port ( 	Clk_in : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		Clk_out : out STD_LOGIC);
end Clock_Divider;

architecture Behavioral of Clock_Divider is

	signal sClk : STD_LOGIC := '0';
	signal sCount : INTEGER := 0;

begin

	Clk_out <= sClk;

	Clock_Divider: process(Clk_in,Reset)
		begin	
			if rising_edge(Clk_in) then
	            if Reset = '1' then
	                sCount <= 0;
	                sClk <= '0';
	            elsif sCount = Preset then
	                sClk <= not sClk;
	                sCount <= 0;
	            else
	                sCount <= sCount + 1;
	            end if;
	        end if;
	    end process;
end Behavioral;