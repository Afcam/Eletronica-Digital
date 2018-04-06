library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component main is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           L : in STD_LOGIC;
           C : in STD_LOGIC;
           R : in STD_LOGIC;
           BL : in STD_LOGIC_VECTOR (1 downto 0);
           LM : out STD_LOGIC_VECTOR (1 downto 0);
           RM : out STD_LOGIC_VECTOR (1 downto 0);
           ledPotMotor: out Std_logic_vector (1 downto 0));
end component;
signal sclk, srst, sL, sC, sR: std_logic := '0';
signal sBL, sLM, sRM, sled: std_logic_vector (1 downto 0);
begin
 utt: main port map(clk => sclk,
                    rst => srst,
                    L => sL,
                    C => sC,
                    R => sR,
                    BL => sBL,
                    LM => sLM,
                    RM => sRM,
                    ledPotMotor => sled);
                    
 Clk: process
    begin 
	   sClk <= '0';
	   wait for 10 ns;
	   sClk <= '1';
	   wait for 10 ns;
 end process;
 Mov: process
    begin
        srst <= '1';
        sBL<= "00";
        sL <= '0';
        sC <= '0';
        sR <= '0';
        wait for 5 ns;
        srst <= '0';
        wait for 20ns;
        sBL<= "00";
        sL <= '1';
        sC <= '0';
        sR <= '0'; 
        wait for 500 ns;
        sBl<= "01";
        wait for 500 ns;
        sBl<= "10";
        wait for 500 ns;
        sBl<= "11";
        wait for 500 ns;
        sBl<= "00";
        sL <= '1';
        sC <= '1';
        sR <= '0';
        wait for 500 ns;
        sBl<= "01";
        wait for 500 ns;
        sBl<= "10";
        wait for 500 ns;
        sBl<= "11";
        wait for 550 ns;
        sBl<= "00";
        sL <= '0';
        sC <= '1';
        sR <= '0';
        wait for 550 ns;
        sBl<= "00";
        sL <= '0';
        sC <= '1';
        sR <= '1';
        wait for 500 ns;
        sBl<= "01";
        wait for 500 ns;
        sBl<= "10";
        wait for 500 ns;
        sBl<= "11";
        wait for 500 ns;
        srst <= '1';
        sBL<= "00";
        sL <= '0';
        sC <= '0';
        sR <= '0';
        wait for 10 ns;
        srst <= '0';
        wait for 20ns;
        sBl<= "00";
        sL <= '0';
        sC <= '0';
        sR <= '1';
        wait for 500 ns;
        sBl<= "01";
        wait for 500 ns;
        sBl<= "10";
        wait for 500 ns;
        sBl<= "11";
        wait for 750 ns;
        srst <= '1';
        sBL<= "00";
        sL <= '0';
        sC <= '0';
        sR <= '0';
        wait;        
 end process;        
end Behavioral;
