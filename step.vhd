library ieee;
use ieee.std_logic_1164.all;

entity step is
port(
A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S0: out std_logic_vector(3 downto 0)
);
end step;

architecture ckt of step is

component reg4set1 is
port(
I: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end component;

begin
Q0: reg4set1 port map (A0, load, clr, clk, S0);
end ckt;
