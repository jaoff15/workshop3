
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;


entity level_shift is
    Port ( up : in STD_LOGIC;
           down : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end level_shift;

architecture Behavioral of level_shift is
    signal counter : unsigned(3 downto 0) := "0100";
    
    signal counter_up : unsigned(3 downto 0) := "0100";
    signal counter_down : unsigned(3 downto 0) := "0100";

--    signal state  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

--    state <= std_logic_vector(counter);
    
    counter <= counter_up - counter_down;
    output <= std_logic_vector(counter);

count_up: 
process (up)
begin
   if rising_edge(up) then
            counter_up <= counter_up + 1;
   end if;
end process;

count_down: 
process (down)
begin
   if rising_edge(down) then
            counter_down <= counter_down + 1;
   end if;
end process;

end Behavioral;
