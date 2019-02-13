

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

begin
    
    -- calculate the output
    output <= shift_register(3) and shift_register(2) and shift_register(1) and shift_register(0); 



prescaling:
process (clk)
begin
   if rising_edge(clk) then
        prescaler <= prescaler + 1;
        if prescaler > 3125000 then           -- ((1/125000000Hz)*0.1s)/4         (4 is the length of the shift register)
            prescaler <=  x"00000000";
        end if;
   end if;
end process;


update_shift_regiser:
process (prescaler, clk)
begin
    if rising_edge(clk) then  
        if(prescaler = 0) then
            -- 4-bit shift register
            shift_register(2 downto 0) <= shift_register(3 downto 1);
            
            -- insert ones or zeros into shift register based on button state
            shift_register(3) <= btn;
        end if;
    end if;
end process;

end Behavioral;
