library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Top_Module is
--  Port ( );
end TB_Top_Module;

architecture Behavioral of TB_Top_Module is

Component Top_Module_74LS193 is
	Port (	Data : in STD_LOGIC_VECTOR(3 downto 0);
			Clear : in STD_LOGIC;
			Load : in STD_LOGIC;
			Count_Up : in STD_LOGIC;
			Count_Down : in STD_LOGIC;
			Clk : in STD_LOGIC;
			led : out STD_LOGIC_VECTOR(3 downto 0); -- Outputs
			Borrow : out STD_LOGIC;
			Carry : out STD_LOGIC);
end Component;

Signal sReset, sLoad,sCount_Up,sCount_Down,sClk,sBorrow,sCarry :STD_LOGIC;
Signal sled:STD_LOGIC_VECTOR(3 downto 0);
Signal sData :STD_LOGIC_VECTOR(3 downto 0);

begin

	uut: Top_Module_74LS193 port map(	Data => sData,
										Clear => sReset,
										Load => sLoad,
										Count_Up => sCount_Up,
										Count_Down => sCount_Down,
										Clk => sClk,
										led => sled,
										Borrow =>sBorrow,
										Carry =>sCarry);
Clk: process
begin 
	sClk <= '0';
	wait for 10 ns;
	sClk <= '1';
	wait for 10 ns;
end process;

Stim: process
begin
    sData <= "0010";
	sReset <= '1';
	sCount_Up <= '1';
	sLoad <= '0';
	sCount_Down <= '0';
	
	wait for 5 ns;	
	sReset <= '0';
	wait for 8000 ns;
	sCount_Up <= '0';
	sCount_Down <= '1';
	wait for 8000 ns;
	sLoad <= '1';
	wait for 100 ns;
	sLoad <= '0';
	wait for 8000 ns;
end process;
end Behavioral;