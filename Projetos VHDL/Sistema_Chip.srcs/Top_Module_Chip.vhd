---------------------------------------------------------------------------------
-- Company: FGA/UnB
-- Engineer: Arthur Faria Campos & Felipe
-- 
-- Create Date: 18.10.2017 11:24:22
-- Design Name: 
-- Module Name: picoblaze_somador_B - Behavioral
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;



entity Top_Module_Chip is
    Port (   clk : in STD_LOGIC := '0';
    	   reset : in STD_LOGIC := '0';
            sw_A : in STD_LOGIC_VECTOR(5 downto 0) := (others=>'0');
            sw_B : in STD_LOGIC_VECTOR(5 downto 0) := (others=>'0');
             sel : in STD_LOGIC_VECTOR(1 downto 0) := (others=>'0');
             led : out STD_LOGIC_VECTOR(11 downto 0) := (others=>'0');
           anodo : out STD_LOGIC_VECTOR(3 downto 0) := (others=>'0');
             seg : out STD_LOGIC_VECTOR(7 downto 0) := (others=>'0'));
end Top_Module_Chip;

architecture Behavioral of Top_Module_Chip is
----------------------------------------------------------------------------------
Component kcpsm6 is
  	generic(               hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
           scratch_pad_memory_size : integer := 64);
  	port (                 address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
  	end Component;
-----------------------------------------------------------
----------------------------------------------------------------------------------
	Component somador is
  		generic(             C_FAMILY : string := "7S"; 
                	C_RAM_SIZE_KWORDS : integer := 2;
             	 C_JTAG_LOADER_ENABLE : integer := 0);
  		Port (    address : in std_logic_vector(11 downto 0);
          instruction : out std_logic_vector(17 downto 0);
               enable : in std_logic;
                  rdl : out std_logic;                    
                  clk : in std_logic);
  	end Component;
  	
  	Component mult is
        generic(             C_FAMILY : string := "7S"; 
                    C_RAM_SIZE_KWORDS : integer := 2;
                 C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      address : in std_logic_vector(11 downto 0);
                instruction : out std_logic_vector(17 downto 0);
                     enable : in std_logic;
                        rdl : out std_logic;                    
                        clk : in std_logic);
    end Component;

    Component shift is
  		generic(             C_FAMILY : string := "7S"; 
              		C_RAM_SIZE_KWORDS : integer := 2;
           		 C_JTAG_LOADER_ENABLE : integer := 0);
  		Port (      address : in std_logic_vector(11 downto 0);
          instruction : out std_logic_vector(17 downto 0);
               enable : in std_logic;
                  rdl : out std_logic;                    
                  clk : in std_logic);
  	end Component;
------------------------------------------

    signal         address_A : std_logic_vector(11 downto 0) := (others => '0');
    signal     instruction_A : std_logic_vector(17 downto 0) := (others => '0');
    signal     bram_enable_A : std_logic := '0';
    signal         in_port_A : std_logic_vector(7 downto 0) := (others => '0');
    signal        out_port_A : std_logic_vector(7 downto 0) := (others => '0');
    signal         port_id_A : std_logic_vector(7 downto 0) := (others => '0');
    signal    write_strobe_A : std_logic := '0';
    signal  k_write_strobe_A : std_logic := '0';
    signal     read_strobe_A : std_logic := '0';
    signal       interrupt_A : std_logic := '0';
    signal   interrupt_ack_A : std_logic := '0';
    signal    kcpsm6_sleep_A : std_logic := '0';
    signal    kcpsm6_reset_A : std_logic := '0';
    signal             rdl_A : std_logic := '0';

    signal         address_B : std_logic_vector(11 downto 0) := (others => '0');
    signal     instruction_B : std_logic_vector(17 downto 0) := (others => '0');
    signal     bram_enable_B : std_logic := '0';
    signal         in_port_B : std_logic_vector(7 downto 0) := (others => '0');
    signal        out_port_B : std_logic_vector(7 downto 0) := (others => '0');
    signal         port_id_B : std_logic_vector(7 downto 0) := (others => '0');
    signal    write_strobe_B : std_logic := '0';
    signal  k_write_strobe_B : std_logic := '0';
    signal     read_strobe_B : std_logic := '0';
    signal       interrupt_B : std_logic := '0';
    signal   interrupt_ack_B : std_logic := '0';
    signal    kcpsm6_sleep_B : std_logic := '0';
    signal    kcpsm6_reset_B : std_logic := '0';
    signal             rdl_B : std_logic := '0';

    signal         address_C : std_logic_vector(11 downto 0) := (others => '0');
    signal     instruction_C : std_logic_vector(17 downto 0) := (others => '0');
    signal     bram_enable_C : std_logic := '0';
    signal         in_port_C : std_logic_vector(7 downto 0) := (others => '0');
    signal        out_port_C : std_logic_vector(7 downto 0) := (others => '0');
    signal         port_id_C : std_logic_vector(7 downto 0) := (others => '0');
    signal    write_strobe_C : std_logic := '0';
    signal  k_write_strobe_C : std_logic := '0';
    signal     read_strobe_C : std_logic := '0';
    signal       interrupt_C : std_logic := '0';
    signal   interrupt_ack_C : std_logic := '0';
    signal    kcpsm6_sleep_C : std_logic := '0';
    signal    kcpsm6_reset_C : std_logic := '0';
    signal             rdl_C : std_logic := '0';
----------------------------------------------------------------------------------
    Component registrador_deslocamento is
	Port (  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
		   anodos : out STD_LOGIC_VECTOR (3 downto 0));
	end Component;

	Component mux4_1 is
	Port ( reset : in std_logic;
		     clk : in std_logic;
			dig1 : in STD_LOGIC_VECTOR (3 downto 0);
			dig2 : in STD_LOGIC_VECTOR (3 downto 0);
			dig3 : in STD_LOGIC_VECTOR (3 downto 0);
			dig4 : in STD_LOGIC_VECTOR (3 downto 0);
		   saida : out STD_LOGIC_VECTOR (3 downto 0));
	end Component;

	Component deco_7seg is
    Port ( entrada : in  STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out  STD_LOGIC_VECTOR (7 downto 0));
	end Component;

	Component divisor_clk is
	generic (preset : std_logic_vector(24 downto 0):= (others=>'0'));
	port (  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
		   outclk : out STD_LOGIC);
	end Component;

	Component Conversor_BinBCD is
    Port ( Valor : in integer range 0 to 4095;
          	   M : out STD_LOGIC_VECTOR (3 downto 0);--N??mero dos Milhares.
           	   C : out STD_LOGIC_VECTOR (3 downto 0);--N??mero das Centenas.
           	   D : out STD_LOGIC_VECTOR (3 downto 0);--N??mero das dezenas.
           	   U : out STD_LOGIC_VECTOR (3 downto 0)); -- numero para os leds
	end Component;

	signal Clk_256Hz : STD_LOGIC := '0';
	signal     s_mux : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
	signal	  s_dig1 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
	signal	  s_dig2 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
	signal	  s_dig3 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
	signal	  s_dig4 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');


	signal	 s_Valor_A : STD_LOGIC_VECTOR (11 downto 0):= (others=>'0');
	signal	 s_Valor_B : STD_LOGIC_VECTOR (11 downto 0):= (others=>'0');
	signal	 s_Valor_C : STD_LOGIC_VECTOR (11 downto 0):= (others=>'0');
	signal	 Aux_signal : STD_LOGIC_VECTOR (11 downto 0):= (others=>'0');
----------------------------------------------------------------------------------
begin

---Pico Blaze 1 : Soma--------------------------------------------------------------------------
	PB_Soma: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address_A,
               instruction => instruction_A,
               bram_enable => bram_enable_A,
                   port_id => port_id_A,
              write_strobe => write_strobe_A,
            k_write_strobe => k_write_strobe_A,
                  out_port => out_port_A,
               read_strobe => read_strobe_A,
                   in_port => in_port_A,
                 interrupt => interrupt_A,
             interrupt_ack => interrupt_ack_A,
                     sleep => kcpsm6_sleep_A,
                     reset => kcpsm6_reset_A,
                       clk => clk);

	ROM_A: somador                   --Name to match your PSM file
    generic map( C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                 C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 0)      --Include JTAG Loader when set to '1' 
    port map(      address => address_A,      
               instruction => instruction_A,
                    enable => bram_enable_A,
                       rdl => rdl_A,
                       clk => clk);

    kcpsm6_reset_A <= rdl_A or reset;

    Soma: process(clk)
    begin
       	if rising_edge(clk) then
            if port_id_A(1 downto 0) = "01"  and read_strobe_A ='1' then
                in_port_A <= "00" & sw_A;
            elsif port_id_A(1 downto 0) = "10" and read_strobe_A ='1' then
            	in_port_A <= "00" & sw_B;
            elsif port_id_A(1 downto 0) = "11" and write_strobe_A ='1' then
            	s_Valor_A <= "0000" & out_port_A;
            end if;
       end if;
    end process;

----------------------------------------------------------------------------------
---Pico Blaze 2 : Multiplicacao--------------------------------------------------------------------------
	PB_Mult: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address_B,
               instruction => instruction_B,
               bram_enable => bram_enable_B,
                   port_id => port_id_B,
              write_strobe => write_strobe_B,
            k_write_strobe => k_write_strobe_B,
                  out_port => out_port_B,
               read_strobe => read_strobe_B,
                   in_port => in_port_B,
                 interrupt => interrupt_B,
             interrupt_ack => interrupt_ack_B,
                     sleep => kcpsm6_sleep_B,
                     reset => kcpsm6_reset_B,
                       clk => clk);

	ROM_B: mult                   --Name to match your PSM file
    generic map( C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                 C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 0)      --Include JTAG Loader when set to '1' 
    port map(      address => address_B,      
               instruction => instruction_B,
                    enable => bram_enable_B,
                       rdl => rdl_B,
                       clk => clk);

    kcpsm6_reset_B <= rdl_B or reset;

    Multiplicador: process(clk)
    begin
        if rising_edge(clk) then
            if port_id_B(1 downto 0) = "00"  and read_strobe_B ='1' then
                in_port_B <= "00" & sw_A;
            elsif port_id_B(1 downto 0) = "01" and read_strobe_B ='1' then
            	in_port_B <= "00" & sw_B;
            elsif port_id_B(1 downto 0) = "10" and write_strobe_B ='1' then
            	s_Valor_B(7 downto 0) <= out_port_B;
            elsif port_id_B(1 downto 0) = "11" and write_strobe_B ='1' then
            	s_Valor_B(11 downto 8) <= out_port_B(3 downto 0);
            end if;
        end if;
    end process;


----------------------------------------------------------------------------------
---Pico Blaze 3 : ShiftRight--------------------------------------------------------------------------
	PB_Shift: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address_C,
               instruction => instruction_C,
               bram_enable => bram_enable_C,
                   port_id => port_id_C,
              write_strobe => write_strobe_C,
            k_write_strobe => k_write_strobe_C,
                  out_port => out_port_C,
               read_strobe => read_strobe_C,
                   in_port => in_port_C,
                 interrupt => interrupt_C,
             interrupt_ack => interrupt_ack_C,
                     sleep => kcpsm6_sleep_C,
                     reset => kcpsm6_reset_C,
                       clk => clk);

	ROM_C: shift                   --Name to match your PSM file
    generic map( C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                 C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 0)      --Include JTAG Loader when set to '1' 
    port map(      address => address_C,      
               instruction => instruction_C,
                    enable => bram_enable_C,
                       rdl => rdl_C,
                       clk => clk);

    kcpsm6_reset_C <= rdl_C or reset;

    Desloca: process(clk,read_strobe_C,port_id_C)
    begin
    	--if rising_edge(clk) then
        	if port_id_C(2 downto 0) = "100" and read_strobe_C ='1' then
            	in_port_C <= "0000000" & sel(1);
            elsif port_id_C(2 downto 0) = "000"  and read_strobe_C ='1' then
                in_port_C <= Aux_signal(7 downto 0);
            elsif port_id_C(2 downto 0) = "001" and read_strobe_C ='1' then
            	in_port_C <= "0000" & Aux_signal(11 downto 8);
            elsif port_id_C(2 downto 0) = "010" and write_strobe_C ='1' then
            	s_Valor_C(7 downto 0) <= out_port_C;
            elsif port_id_C(2 downto 0) = "011" and write_strobe_C ='1' then
            	s_Valor_C(11 downto 8) <= out_port_C(3 downto 0);
            end if;
        --end if;
    end process;
----------------------------------------------------------------------------------


    -- Mux da seletora sw(14)
    with sel(0) select
    	Aux_signal <= s_Valor_A when '0',
    				  s_Valor_B when others;

    led <= s_Valor_C;  --Conecta nos leds


   Divisor: divisor_clk 
	generic map (preset => "0000000101111101011110000") --256Hz "0000000101111101011110000"   "0000000000000000000000011"
	port map (   reset => reset,
					clk => clk,
				 outclk => Clk_256Hz);

	Decod: deco_7seg 
    Port map( entrada => s_mux,
            segmentos => seg);

	BinBCD: Conversor_BinBCD 
    Port map(  Valor => to_integer(unsigned(Aux_signal)),
		           M => s_dig1,
		           C => s_dig2,
		           D => s_dig3,
		           U => s_dig4); -- numero para os leds


    Mux1: mux4_1 
	Port map(  reset => reset,
				 clk => Clk_256Hz,
				dig1 => s_dig1,
				dig2 => s_dig2,
				dig3 => s_dig3,
				dig4 => s_dig4,
			   saida => s_mux);

	Anodos_Shift: registrador_deslocamento 
	Port map(  reset => reset,
				 clk => Clk_256Hz,
		   	  anodos => anodo);

end Behavioral;