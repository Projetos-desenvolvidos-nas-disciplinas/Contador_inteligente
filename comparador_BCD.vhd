library ieee;
use ieee.std_logic_1164.all;

entity comparador_BCD is 
	port(
			acent, bcent,adeze,bdeze,auni,buni: in std_logic_vector(3 downto 0);
			igual,maior,menor: out std_logic
	);
end comparador_BCD;

architecture ckt of comparador_BCD is

	component compmag4 is

		port(
				A,B: in std_logic_vector (0 to 3);
				AigualB, AmaiorB, AmenorB: in std_logic;
				igual4b, maior4b, menor4b: out std_logic
		);
		
	end component;
	
	signal igual_cent, maior_cent, menor_cent, igual_deze, maior_deze, menor_deze, igual_uni, maior_uni, menor_uni: std_logic;
	
	begin
	
		C: compmag4 port map(acent,bcent,'1', '0', '0', igual_cent, maior_cent, menor_cent);
		D: compmag4 port map(adeze,bdeze,igual_cent, maior_cent, menor_cent, igual_deze, maior_deze, menor_deze);
		U: compmag4 port map(auni, buni,igual_deze, maior_deze, menor_deze, igual,maior,menor);
		
end ckt;