library ieee;
use ieee.std_logic_1164.all;

entity compmag1 is
port(
  A,B,AigualB,AmaiorB,AmenorB: in std_logic;
  igual,maior,menor: out std_logic 
);
end compmag1;

architecture ckt of compmag1 is

begin
  igual <= (A xor B) and AigualB;
  maior <= (AigualB and (A and (not B))) or AmaiorB;
  menor <= (AigualB and ((not A) and B)) or AmenorB;
end ckt;