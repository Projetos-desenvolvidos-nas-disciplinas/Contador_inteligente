library ieee;
use ieee.std_logic_1164.all;

entity compmag4 is 
port(
A,B: in std_logic_vector (3 downto 0);
AigualB, AmaiorB, AmenorB: in std_logic;
igual4b, maior4b, menor4b: out std_logic
);
end compmag4;

architecture ckt of compmag4 is 

component compMag1 is
port(
  A,B,AigualB,AmaiorB,AmenorB: in std_logic;
  igual,maior,menor: out std_logic 
);
end component;

signal igual1, maior1, menor1, igual2, maior2, menor2, igual3, maior3, menor3: STD_logic;

begin
 

C1: compmag1 port map (A(3), B(3), AigualB, AmaiorB, AmenorB, igual1, maior1, menor1);
C2: compmag1 port map (A(2), B(2), igual1, maior1, menor1, igual2, maior2, menor2);
C3: compmag1 port map (A(1), B(1), igual2, maior2, menor2, igual3, maior3, menor3);
C4: compmag1 port map (A(0), B(0), igual3, maior3, menor3, igual4b, maior4b, menor4b);

end ckt;