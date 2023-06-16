--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade Somador Completo
entity Somador_completo is 
port(
--Entrada A,B e CarryIn
A,B,Cin :in std_logic;
--Saídas S e CarryOut
S,Cout :out std_logic
);
end Somador_completo;

--Arquitetura de Somador completo
architecture somador of Somador_completo is
--Sinais complementares
--A e B; Ou A ou B; (Ou A ou B) e Cin
signal AB, AxorB, AxorBCin : std_logic;

begin
  --A e B
  AB <= A AND B;
  --Ou A ou B
  AxorB <= A XOR B;
  --(Ou A ou B) e Cin
  AxorBCin <= AxorB and Cin;
  
  S <= Cin XOR AxorB; 
  Cout<= AxorBCin OR AB;
end somador;