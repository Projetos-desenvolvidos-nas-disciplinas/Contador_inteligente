library ieee;
use ieee.std_logic_1164.all;

entity regmax is
port(
A2, A1, A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S2, S1, S0: out std_logic_vector(3 downto 0)
);
end regmax;

architecture ckt of regmax is

component reg4set9 is
port(
I: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end component;

begin
Q2: reg4set9 port map (A2, load, clr, clk, S2);
Q1: reg4set9 port map (A1, load, clr, clk, S1);
Q0: reg4set9 port map (A0, load, clr, clk, S0);
end ckt;
