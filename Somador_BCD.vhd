--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade Somador BCD
entity Somador_Bcd is 
port(
  --Entrada Vetores A e B
  A, B: in std_logic_vector(3 downto 0);
  --Entrada Cin
  Cin: in std_logic;
  --Saída Vetor S
  S: out std_logic_vector(3 downto 0);
  --Saída de Carry
  Cout: out std_logic
);
end Somador_Bcd;

architecture somador of Somador_Bcd is
  
  --Trazendo o componente Somador 8bits
  component Somador_4bits is
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
  end component;
  
  --Sinais auxiliares
  --Vetor de saída do primeiro somador
  Signal S0: std_logic_vector(3 downto 0);
  --Cout do primeiro somador
  Signal C0: std_logic;
  --Lógica para Cout
  Signal LC: std_logic;
  --Entrada do segundo somador
  Signal S2: std_logic_vector(3 downto 0);
  --Recebe o Cout do segundo somador(ignorado)
  Signal CI: std_logic;
  
  begin
  --Primeiro Somador
  U1: Somador_4bits port map(A, B, Cin, S0, C0);
  --Logica para Cout
  LC <= (((S0(1) OR S0(2)) AND S0(3)) OR C0);
  Cout <= LC;
  --Atribuindo os valores da segunda entrada do segundo somador
  S2(3) <= '0';
  S2(2) <= LC;
  S2(1) <= LC;
  S2(0) <= '0';
  --Segundo Somador
  U2: Somador_4bits port map(S0, S2, '0', S, CI);
  
    
end somador;