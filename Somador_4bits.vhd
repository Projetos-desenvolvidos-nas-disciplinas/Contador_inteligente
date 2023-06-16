--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade Somador de 8bits
entity Somador_4bits is
port(
  --Vetores de entrada
  A,B:in std_logic_vector(3 downto 0);
  --Entrada de Carry
  Cin: in std_logic;
  --Vetores de saida
  S: out std_logic_vector(3 downto 0);
  --CarryOut
  Cout: out std_logic
);
end Somador_4bits;

--Arquitetura do somador 8bits
architecture somador4b of Somador_4bits is

--Trazendo o somador completo
component Somador_completo is
port(
--Entrada A,B e CarryIn
  A,B,Cin :in std_logic;
--Saídas S e CarryOut
  S,Cout :out std_logic
);
end component;

--Sinais auxiliares
--Carrys intermediarios
Signal C0, C1, C2: std_logic;

--Início
begin
--Funcionamento do circuito
U1: Somador_completo port map(A(0), B(0), Cin, S(0), C0);
U2: Somador_completo port map(A(1), B(1), C0, S(1), C1);
U3: Somador_completo port map(A(2), B(2), C1, S(2), C2);
U4: Somador_completo port map(A(3), B(3), C2, S(3), Cout);

end somador4b;