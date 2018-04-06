library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Decod_7Seg is
    Port ( BCD : in STD_LOGIC;
           Seg : out STD_LOGIC);
end Decod_7Seg;

architecture Behavioral of Decod_7Seg is

begin
		process(BCD)
	begin
		case BCD is
			when "0000" => Seg <= "11000000"; --0
            when "0001" => Seg <= "11111001"; --1
            when "0010" => Seg <= "10100100"; --2
            when "0011" => Seg <= "10110000"; --3
            when "0100" => Seg <= "10011001"; --4
            when "0101" => Seg <= "10010010"; --5
            when "0110" => Seg <= "10000010"; --6
            when "0111" => Seg <= "11111000"; --7
            when "1000" => Seg <= "10000000"; --8
            when "1001" => Seg <= "10011000"; --9
            when "1010" => Seg <= "10001000"; --A
            when "1011" => Seg <= "10000011"; --b
            when "1100" => Seg <= "10100111"; --c
            when "1101" => Seg <= "10100001"; --d
            when "1110" => Seg <= "10000110"; --E
            when "1111" => Seg <= "10001110"; --F
            when others => Seg <= "11000000"; --0
		end case;
	end process;

end Behavioral;