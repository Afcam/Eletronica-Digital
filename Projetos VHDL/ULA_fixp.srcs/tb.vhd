----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.10.2017 12:15:03
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component ula_fixp_nolatch is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           oper : in STD_LOGIC_VECTOR (11 downto 0);
           lopA : in STD_LOGIC;
           lopB : in STD_LOGIC;
           saida : out STD_LOGIC_VECTOR (11 downto 0);
           ready_oper : out STD_LOGIC;
           ready : out STD_LOGIC;
           overflowled:out std_logic;
           underflowled: out std_logic);
end component;
signal sreset,sstart,sclk,slopA,slopB,sready_oper,sready,soverflow,sunderflow: std_logic;
signal soper,ssaida:std_logic_vector(11 downto 0);
signal ssel:std_logic_vector(3 downto 0);

begin
utt: ula_fixp_nolatch 
    Port map (reset=>sreset,
              clk=>sclk,
              start=>sstart,
              sel=>ssel,
              oper=>soper,
              lopA=>slopA,
              lopB=>slopB,
              saida=>ssaida,
              ready_oper=>sready_oper,
              ready=>sready,
              overflowled=>soverflow,
              underflowled=>sunderflow); 
Clk: process
   begin 
        sClk <= '0';
        wait for 10 ns;
        sClk <= '1';
        wait for 10 ns;
   end process;
testB: process
   begin
   sreset<='1';
   slopA<='0';
   slopB<='0';
   ssel<= "0000";
   soper<=(others=>'0');
   sstart<='0';
   wait for 20ns;
   sreset<='0';
   wait for 20ns;
   slopA<='1';
   wait for 20ns;
   soper<= "010110010100";
   wait for 20ns;
   slopa<='0';
   slopB<='1';
   soper<=(others=>'0');
   wait for 20ns;
   soper<= "001101011011";
   wait for 20ns;
   slopB<='0';
   soper<=(others=>'0');
   wait for 20ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0001";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0010";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0100";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0101";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0110";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="0111";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;   
   sstart<='0';
   ssel<="1000";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="1001";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="1010";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   sstart<='0';
   ssel<="1011";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   ssel<="1100";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   ssel<="1101";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   ssel<="1110";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
   ssel<="1111";
   wait for 20 ns;
   sstart<='1';
   wait for 200 ns;
      
   end process;  

end Behavioral;
