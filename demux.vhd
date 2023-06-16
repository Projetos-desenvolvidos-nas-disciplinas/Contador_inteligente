library ieee;
use ieee.std_logic_1164.all;

entity demux is
port(
load, sel0, sel1: in std_logic;
S0, S1, S2, S3: out std_logic
);
end demux;

architecture ckt of demux is
begin
S0 <= not sel0 AND not sel1 AND load;
S1 <= not sel0 AND sel1 AND load;
S2 <= sel0 AND not sel1 AND load;
S3 <= sel0 AND sel1 AND load;
end ckt;
