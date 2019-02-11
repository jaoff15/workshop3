 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( btn : in STD_LOGIC_VECTOR (3 downto 0);
           switches : in STD_LOGIC_VECTOR (3 downto 0);
           clock_125M : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is
-- Define running_leds module interface
    component running_leds is
    Port ( clock_125M : in STD_LOGIC;
           frequency : in STD_LOGIC_VECTOR (3 downto 0);
           leds : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;
    
    -- Define debound module interface
    component debounce is
    Port ( btn      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           output   : out STD_LOGIC;
           sw       : in STD_LOGIC_VECTOR(3 downto 0)
           );
    end component;
    
    -- Define level_shift interface
    component level_shift is
    Port ( up      : in STD_LOGIC;
           down      : in STD_LOGIC;
           output   : out STD_LOGIC_VECTOR(3 downto 0)
           );
    end component;
    
    -- Define some signals
    signal up_sig : STD_LOGIC;
    signal down_sig : STD_LOGIC;
    signal led_sig : STD_LOGIC_VECTOR(3 downto 0);
    
begin

-- Create instance of running_leds
running_leds0:running_leds
port map(
    clock_125M  => clock_125M,
    frequency   => led_sig,
    leds        => leds
);

-- Create instance of level_shift
level_shift0:level_shift
port map(
    up      => up_sig,
    down    => down_sig,
    output  => led_sig
);

-- Create instance of debounce, used for counting up
debounce_up:debounce
port map(
    btn     => btn(0),
    clk     => clock_125M,
    sw      => switches,
    output  => up_sig
);

-- Create instance of debounce, used for counting down
debounce_down:debounce
port map(
    btn     => btn(1),
    clk     => clock_125M,
    sw      => switches,
    output  => down_sig
);


end Behavioral;
