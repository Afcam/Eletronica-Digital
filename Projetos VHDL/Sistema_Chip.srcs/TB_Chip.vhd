library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_signed.ALL;



entity TB_Chip is
--  Port ( );
end TB_Chip;

architecture Behavioral of TB_Chip is

Component Top_Module_Chip is
    Port ( clk : in STD_LOGIC;
    	   reset : in STD_LOGIC;
           sw_A : in STD_LOGIC_VECTOR(5 downto 0) := (others=>'0');
           sw_B : in STD_LOGIC_VECTOR(5 downto 0) := (others=>'0');
           sel : in STD_LOGIC_VECTOR(1 downto 0);
           led : out STD_LOGIC_VECTOR(11 downto 0);
           anodo : out STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR(7 downto 0));
end Component;

signal s_clk :  STD_LOGIC;
signal s_reset :  STD_LOGIC;
signal s_sw :  STD_LOGIC_VECTOR(11 downto 0);
signal  s_sel :  STD_LOGIC_VECTOR(1 downto 0);
signal s_led :  STD_LOGIC_VECTOR(11 downto 0);
signal s_anodo :  STD_LOGIC_VECTOR(3 downto 0);
signal  s_seg :  STD_LOGIC_VECTOR(7 downto 0);


begin

utt: Top_Module_Chip 
    Port map( clk => s_clk,
    	   	reset => s_reset,
           	   sw_A => s_sw(5 downto 0),
           	   sw_B => s_sw(11 downto 6),
           	  sel => s_sel,
              led => s_led,
            anodo => s_anodo,
              seg => s_seg);


Clk: process
begin 
	s_clk <= '0';
	wait for 1 ns;
	s_clk <= '1';
	wait for 1 ns;
end process;


Stim: process
begin
	s_reset <= '1';
	s_sel<="00"	;
	s_sw(5 downto 0)  <= "000101";
	s_sw(11 downto 6) <= "001001";
	wait for 10 ns;
	s_sel<="11";
	s_reset <= '0';
	wait for 100 ns;
	s_sel<="00";
	wait for 1000 us;
		s_sel<="10";
	wait for 100 ns;
	s_sel<="00";

    wait;

    
end process;
end Behavioral;