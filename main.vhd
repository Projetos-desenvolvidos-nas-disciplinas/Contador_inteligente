library ieee;
use ieee.std_logic_1164.all;

entity main is
port(
A2, A1, A0: in std_logic_vector(3 downto 0);
load, clr, clk, max_min, stp: in std_logic;
S2min, S1min, S0min, S2max, S1max, S0max, S0step: out std_logic_vector(3 downto 0)
);
end main;

architecture ckt of main is

component regmin is
port(
A2, A1, A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S2, S1, S0: out std_logic_vector(3 downto 0)
);
end component;

component regmax is
port(
A2, A1, A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S2, S1, S0: out std_logic_vector(3 downto 0)
);
end component;

component step is
port(
A0: in std_logic_vector(3 downto 0);
load, clr, clk: in std_logic;
S0: out std_logic_vector(3 downto 0)
);
end component;

component demux is
port(
load, sel0, sel1: in std_logic;
S0, S1, S2, S3: out std_logic
);
end component;

signal ldmin, ldmax, step1, step2, ldstep, nclear: std_logic;

begin
nclear <= clr;

main_demux: demux port map(load, stp, max_min, ldmin, ldmax, step1, step2);

ldstep <= step1 OR step2;

min: regmin port map(A2, A1, A0, ldmin, nclear, clk, S2min, S1min, S0min);

max: regmax port map(A2, A1, A0, ldmax, nclear, clk, S2max, S1max, S0max);

main_step: step port map(A0, ldstep, nclear, clk, S0step);
end ckt;
