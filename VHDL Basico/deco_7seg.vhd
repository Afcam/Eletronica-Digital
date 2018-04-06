library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco_7seg is
    Port ( entrada : in  STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out  STD_LOGIC_VECTOR (7 downto 0));
end deco_7seg;

architecture Behavioral of deco_7seg is

begin

	process(entrada)
	begin
		case entrada is
			when "0000" => segmentos <= "11000000"; --0
            when "0001" => segmentos <= "11111001"; --1
            when "0010" => segmentos <= "10100100"; --2
            when "0011" => segmentos <= "10110000"; --3
            when "0100" => segmentos <= "10011001"; --4
            when "0101" => segmentos <= "10010010"; --5
            when "0110" => segmentos <= "10000010"; --6
            when "0111" => segmentos <= "11111000"; --7
            when "1000" => segmentos <= "10000000"; --8
            when "1001" => segmentos <= "10011000"; --9
            when "1010" => segmentos <= "10001000"; --A
            when "1011" => segmentos <= "10000011"; --b
            when "1100" => segmentos <= "10100111"; --c
            when "1101" => segmentos <= "10100001"; --d
            when "1110" => segmentos <= "10000110"; --E
            when "1111" => segmentos <= "10001110"; --F
            when others => segmentos <= "11000000"; --0
		end case;
	end process;

end Behavioral;

