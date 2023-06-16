library ieee;
use ieee.std_logic_1164.all;

entity regmin is
port(
A2, A1, A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S2, S1, S0: out std_logic_vector(3 downto 0)
);
end regmin;

architecture ckt of regmin is

component reg_4bits_v2 is
port(
I: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end component;

begin
Q2: reg_4bits_v2 port map (A2, load, clr, clk, S2);
Q1: reg_4bits_v2 port map (A1, load, clr, clk, S1);
Q0: reg_4bits_v2 port map (A0, load, clr, clk, S0);
end ckt;
