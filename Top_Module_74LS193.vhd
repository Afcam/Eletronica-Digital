library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Top_Module_74LS193 is
	Port (	Data : in STD_LOGIC_VECTOR(3 downto 0);
			Clear : in STD_LOGIC;
			Load : in STD_LOGIC;
			Count_Up : in STD_LOGIC;
			Count_Down : in STD_LOGIC;
			Clk : in STD_LOGIC;
			led : out STD_LOGIC_VECTOR(3 downto 0); -- Outputs
			Borrow : out STD_LOGIC;
			Carry : out STD_LOGIC);
end Top_Module_74LS193;

architecture Behavioral of Top_Module_74LS193 is

--Divisor de Clock ------------------------------------------------------------------------------
Component Clock_Divider is
	Generic(Preset : INTEGER);
    Port ( 	Clk_in : in STD_LOGIC;
    		Reset : in STD_LOGIC;
    		Clk_out : out STD_LOGIC);
end Component;

-- Sinais Utilizados no Divisor de Clock
signal sClk_1Hz: STD_LOGIC := '0';
------------------------------------------------------------------------------------
--Contador Up / Down ------------------------------------------------------------------------------
Component Count_Up_Down is
    Port ( 	Reset : in STD_LOGIC;
    		Data : in STD_LOGIC_VECTOR(3 downto 0);
    		Load : in STD_LOGIC;
    		Up_Down : in STD_LOGIC;
    		Clk : in STD_LOGIC;
    		Borrow: out STD_LOGIC;
    		Carry: out STD_LOGIC;
    		Num : out STD_LOGIC_VECTOR(3 downto 0));
end Component;

-- Sinais Utilizados no Contador
signal sSel: STD_LOGIC := '0';
------------------------------------------------------------------------------------
begin

	Clock_1Hz: Clock_Divider generic map (Preset => 10) 
							 port map (	Clk_in => Clk,
										Reset => Clear,
										Clk_out => sClk_1Hz);

	Butons: process (Count_Up,Count_Down)
		begin
			if(Count_up = '1') then
				sSel <= '0';
			elsif(Count_Down = '1') then
				sSel <= '1';
			end if;
		end process;				
							 
	Count: Count_Up_Down port map (	Reset => Clear,
									Data => Data,
									Load => Load,
									Up_Down => sSel,
									Clk => sClk_1Hz,
									Borrow => Borrow,
    								Carry => Carry,
									Num => led);
end Behavioral;