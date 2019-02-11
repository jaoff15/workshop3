

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;


entity debounce is
    Port ( btn : in STD_LOGIC;
           sw   : in std_logic_vector (3 downto 0);
           clk : in STD_LOGIC;
           output : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

    signal prescaler        : unsigned(31 downto 0) := x"00000000";
    signal shift_register   : std_logic_vector(3 downto 0)  := "0000";

    signal  clock_run   : std_logic;

begin
    
    output <= shift_register(3) and shift_register(2) and shift_register(1) and shift_register(0); 


    with sw select    
    clock_run <=    prescaler(24) when "0000",
                    prescaler(23) when "0001", 
                    prescaler(22) when "0010", 
                    prescaler(21) when "0011",
                    prescaler(20) when "0100",
                    prescaler(19) when "0101", 
                    prescaler(18) when "0110", 
                    prescaler(17) when "0111",
                    prescaler(16) when "1000",
                    prescaler(15) when "1001", 
                    prescaler(14) when "1010", 
                    prescaler(13) when "1011",
                    prescaler(12) when "1100",
                    prescaler(11) when "1101", 
                    prescaler(10) when "1110", 
                    prescaler(9)  when "1111";


prescaling:
process (clk)
begin
   if rising_edge(clk) then
        prescaler <= prescaler + 1;
   end if;
end process;


update_shift_regiser:
process (clock_run)
begin
    if rising_edge(clock_run) then  
          
        -- 4-bit shift register
        shift_register(2 downto 0) <= shift_register(3 downto 1);
        
        -- insert ones or zeros into shift register based on button state
        shift_register(3) <= btn;

    end if;
end process;

end Behavioral;
