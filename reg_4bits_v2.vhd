library ieee;
use ieee.std_logic_1164.all;

entity reg_4bits_v2 is
port(
I: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end reg_4bits_v2;

architecture ckt of reg_4bits_v2 is

component reg_1bit is
port(
I, load, clr, set, clk: in std_logic;
q: out std_logic
);
end component;

begin
Q3: reg_1bit port map (I(3), load, clr, '0', clk, Q(3));
Q2: reg_1bit port map (I(2), load, clr, '0', clk, Q(2));
Q1: reg_1bit port map (I(1), load, clr, '0', clk, Q(1));
Q0: reg_1bit port map (I(0), load, clr, '0', clk, Q(0));

end ckt;
