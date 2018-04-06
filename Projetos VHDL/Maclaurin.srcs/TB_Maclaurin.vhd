library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_signed.ALL;



entity TB_Maclaurin is
--  Port ( );
end TB_Maclaurin;

architecture Behavioral of TB_Maclaurin is

component Top_Module_Maclaurin is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR (11 downto 0);
           fx : out STD_LOGIC_VECTOR (11 downto 0);
           ready : out STD_LOGIC);
end component;

Signal sClk,sReset,sStart,sReady: STD_LOGIC := '0';
Signal sx,sfx : STD_LOGIC_VECTOR (11 downto 0);


begin

	uut: Top_Module_Maclaurin port map(	Clk => sClk,
										Reset => sReset,
										start => sStart,
										x => sx,
										fx => sfx,
										ready => sReady);


Clk: process
begin 
	sClk <= '0';
	wait for 1 ns;
	sClk <= '1';
	wait for 1 ns;
end process;




Stim: process
begin
	sReset <= '0';
	sStart <= '1';
	sx <= "000001000000";
	wait for 10 ns;
		sReset <= '0';
		wait for 100 ns;

	sx <= "100001000000";
	wait for 10 ns;


	wait for 100 ns;
		sx <= "000000001110";

	wait for 100 ns;
		sx <= "100001000000";

	wait for 100 ns;
		sx <= "100000011010";

    wait;
end process;
end Behavioral;