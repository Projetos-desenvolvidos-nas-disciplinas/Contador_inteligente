library ieee;
use ieee.std_logic_1164.all;

entity seg7 is
	
	port(Inp : in std_logic_vector(3 downto 0);
		SO : out std_logic_vector(6 downto 0));

end seg7;
		
architecture ckt of seg7 is

signal A, B, C, D : std_logic;

	begin
	
	A <= Inp(3);
	B <= Inp(2);
	C <= Inp(1);
	D <= Inp(0);
	
		SO(6) <= ((A OR C) OR (B XNOR D));
		SO(5) <= ((C XNOR D) OR NOT(B));
		SO(4) <= (B OR D OR NOT(C));
		SO(3) <= (((NOT(D) OR NOT(B)) AND C) OR (A) OR (NOT (B) AND NOT (D)) OR (B AND NOT(C) AND D));
		SO(2) <= ((C OR NOT(B))AND NOT(D));
		SO(1) <= (((NOT(C) OR NOT(D)) AND B) OR (NOT (C) AND NOT(D)) OR A);
		SO(0) <= (((NOT(D) OR NOT(B)) AND C) OR (NOT(C) AND B) OR (A));
end ckt;