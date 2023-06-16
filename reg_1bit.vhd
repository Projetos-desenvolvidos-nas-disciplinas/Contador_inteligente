library ieee;
use ieee.std_logic_1164.all;

entity reg_1bit is
port(
I, load, clr, set, clk: in std_logic;
q: out std_logic
);
end reg_1bit;

architecture ckt of reg_1bit is
signal q_temp: std_logic;
begin
process(clk, set, clr)
begin
IF clr = '1' THEN
	q_temp <= '0';
ELSIF set = '1' THEN
	q_temp <= '1';
ELSIF clk'EVENT and clk = '1' THEN
	IF load = '1' THEN
		q_temp <= I;
	ELSE
		q_temp <= q_temp;
	end IF;
end IF;
end PROCESS;
q <= q_temp;
end ckt;
