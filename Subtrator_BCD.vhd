--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade Subtrator BCD
entity Subtrator_Bcd is 
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
end Subtrator_Bcd;

architecture subtrator of Subtrator_Bcd is
  
  --Trazendo o componente Somador 4bits
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
  
  --Trazendo o componente Somador BCD
  component Somador_Bcd is
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
  
  --Sinais Auxiliares
  --Somar Cin
  --Somar Sinal para somar com B
  Signal AC: std_logic_vector(3 downto 0);
  --Saída Sinal SC
  Signal SC: std_logic_vector(3 downto 0);
  --Carry da Soma
  Signal CoutC: std_logic;
  
  --Para o complemento de 9
  --Vetor de entrada para o complemento de 9
  Signal A9: std_logic_vector(3 downto 0);
  --Cout do complemento de 9
  Signal Cout9: std_logic;
  --Vetor do numero que vai realizar o complemento de 9
  Signal B9: std_logic_vector(3 downto 0);
  --Vetor de saida do complemento de 9
  Signal S9: std_logic_vector(3 downto 0);
  
  --Somador BCD
  --CarryOut do somador
  Signal CoutS: std_logic;
  --Saida do somador
  Signal SS: std_logic_vector(3 downto 0);
  
  --Ajuste
  --Entrada B do ajuste
  Signal BA: std_logic_vector(3 downto 0);
  --Entrada A do ajuste
  Signal AA: std_logic_vector(3 downto 0);
  --Cout do ajuste
  Signal CoutA: std_logic;
  --CoutS negado
  Signal NCoutS: std_logic;
  
  begin
    
    --Setando AC
    AC(3) <= '0';
    AC(2) <= '0';
    AC(1) <= '0';
    AC(0) <= '0';
    --Somar Cin com B
    U0: Somador_4bits port map(AC, B, Cin, SC, CoutC);
    
    --Complemento de 9
    --Setando A9
    A9(3) <= '1';
    A9(2) <= '0';
    A9(1) <= '1';
    A9(0) <= '0';
    --Setando B9
    B9(3) <= SC(3) XOR '1';
    B9(2) <= SC(2) XOR '1';
    B9(1) <= SC(1) XOR '1';
    B9(0) <= SC(0) XOR '1';
    --Somador
    U1:Somador_4bits port map(A9,B9,'1', S9, Cout9);
    
    --Somador BCD
    U2:Somador_BCD port map(A, S9, '0', SS, CoutS);
    
    NCoutS <= NOT(CoutS);
    --Ajuste
    --Setando AA
    AA(3) <= NCoutS;
    AA(2) <= '0';
    AA(1) <= NCoutS;
    AA(0) <= '0';
    --Setando BA
    BA(3) <= SS(3) XOR NCoutS;
    BA(2) <= SS(2) XOR NCoutS;
    BA(1) <= SS(1) XOR NCoutS;
    BA(0) <= SS(0) XOR NCoutS;
    
    Cout <= NOT(CoutS);
    
    U3: Somador_4bits port map(AA, BA, NCoutS, S, CoutA);
end subtrator;