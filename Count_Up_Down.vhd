library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Count_Up_Down is
    Port ( 	Reset : in STD_LOGIC;
    		Data : in STD_LOGIC_VECTOR(3 downto 0);
    		Load : in STD_LOGIC;
    		Up_Down : in STD_LOGIC;
    		Clk : in STD_LOGIC;
    		Borrow: out STD_LOGIC;
    		Carry: out STD_LOGIC;
    		Num : out STD_LOGIC_VECTOR(3 downto 0));
end Count_Up_Down;

architecture Behavioral of Count_Up_Down is

	signal sCount : std_logic_vector(3 downto 0) := "0000";
	signal sBorrow: STD_LOGIC:='0';
	signal sCarry: STD_LOGIC:='0';
	
begin
	Num <= sCount;
	Borrow <= sBorrow;
	Carry <= sCarry;
	process(Clk,Reset,Load)
		begin
			if rising_edge(Clk) then
			    sCarry <= '0';
                sBorrow <= '0';
				if reset = '1' then
					sCount<="0000";
				elsif Load = '1' then   
					sCount <= Data;
				elsif Up_Down='0' then
					if(sCount = "1111") then
						sCarry <= '1';
					end if;
					sCount <= sCount + '1';
				elsif Up_Down='1' then
					if(sCount = "0000") then
						sBorrow <= '1';
					end if;
					sCount<=sCount - '1';
				end if;
			end if;
		end process;
end Behavioral;