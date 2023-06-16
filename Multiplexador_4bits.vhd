--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Multiplexador 4 bits
entity Mux_4bits is
port(
  --Entradas A e B
  A,B: in std_logic_vector(3 downto 0);
  --Chave
  K: in std_logic;
  --Saida
  S: out std_logic_vector(3 downto 0)
);
end Mux_4bits;

architecture mux of Mux_4bits is
 
 begin
  S(3) <= (A(3) AND K) OR (B(3) AND (NOT K));
  S(2) <= (A(2) AND K) OR (B(2) AND (NOT K));
  S(1) <= (A(1) AND K) OR (B(1) AND (NOT K));
  S(0) <= (A(0) AND K) OR (B(0) AND (NOT K));
end mux;