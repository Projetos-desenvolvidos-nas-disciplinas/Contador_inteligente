--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

entity Contador is
port(
  --Memoria de Centena, Dezena e Unidade
  MCen, MDez, MUni, step: in std_logic_vector(3 downto 0);
  --Chave Up/Dw
  UpDw: in std_logic;
  --Sinal vindo da resposta 
  --(informa para que lado do contador ele sobrecarregou o limite da contagem)
  SinalPos: out std_logic;
  SinalNeg: out std_logic;
  --Valores de Centena, Dezena e Unidade de saida
  Cen, Dez, Uni: out std_logic_vector(3 downto 0)
);
end Contador;

architecture C of Contador is
  
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
  
  --Trazendo o componente Subtrator BCD
  component Subtrator_Bcd is
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
  
    --Trazendo o componente Multiplexador 4 bits
  component Mux_4bits is
  port(
  --Entradas A e B
  A,B: in std_logic_vector(3 downto 0);
  --Chave
  K: in std_logic;
  --Saida
  S: out std_logic_vector(3 downto 0)
  );
  end component;
  
  --Sinais auxiliares
  --Somador e subtrator de unidade
  Signal USom, USub : std_logic_vector(3 downto 0);
  --Carry das operações
  Signal CoutUSom, CoutUSub: std_logic;
  
  --Somador e subtrator de dezena
  Signal DSom, DSub : std_logic_vector(3 downto 0);
  --Carry das operações
  Signal CoutDSom, CoutDSub: std_logic;
  
  --Somador e subtrator de centena
  Signal CSom, CSub : std_logic_vector(3 downto 0);
  --Carry das operações
  Signal CoutCSom, CoutCSub: std_logic;
  
  --Vetor vazio
  Signal zero : std_logic_vector(3 downto 0);
  
  --Verificação se o valor do contador é zero ou abaixo (para negativo)
  Signal Uver, Dver, Cver: std_logic;
  
  --Sinais para o complemento de 10
  Signal UComp, DComp: std_logic_vector(3 downto 0);
  
  --Vetor de entrada para o complemento de 10
  Signal A9: std_logic_vector(3 downto 0);
  --Cout do complemento de 10
  Signal Cout9: std_logic;
  --Vetor do numero que vai realizar o complemento de 10
  Signal U9, D9: std_logic_vector(3 downto 0);
  
  --Mulpiplexador para escolher a saída
  Signal UFinal, DFinal: std_logic_vector(3 downto 0);
  
  
  begin
  --Preenchendo zero
  zero(3) <= '0';
  zero(2) <= '0';
  zero(1) <= '0';
  zero(0) <= '0';  
  
  --Soma e subtração de unidade
  SomUni: Somador_Bcd port map(MUni, step, '0', USom, CoutUSom);
  SubUni: Subtrator_Bcd port map(MUni, step, '0', USub, CoutUSub);
  
  --Verifica se não é 0 
  Uver <= CoutUSub XOR (USub(3) and USub(2) and USub(1) and USub(0));
  
  --Soma e subtração de dezena
  SomDez: Somador_Bcd port map(MDez, zero, CoutUSom, DSom, CoutDSom);
  SubDez: Subtrator_Bcd port map(MDez, zero, UVer, DSub, CoutDSub);
  
  --Verifica se não é 0 
  Dver <= CoutDSub XOR (DSub(3) and DSub(2) and DSub(1) and DSub(0));
  
  --Soma e subtração de centena
  SomCen: Somador_Bcd port map(MCen, zero, CoutDSom, CSom, CoutCSom);
  SubCen: Subtrator_Bcd port map(MCen, zero, Dver, CSub, CoutCSub);

  --Verifica se não é 0    
  Cver <= CoutCSub XOR (CSub(3) and CSub(2) and CSub(1) and CSub(0));
   
  --Sinais da saída 
  SinalPos <= CoutCSom; 
  SinalNeg <= Uver AND Dver AND Cver;
  
  --Complemento de 10 Unidade
  --Setando A9
  A9(3) <= '1';
  A9(2) <= '0';
  A9(1) <= '1';
  A9(0) <= '0';
  --Setando B9
  U9(3) <= USub(3) XOR '1';
  U9(2) <= USub(2) XOR '1';
  U9(1) <= USub(1) XOR '1';
  U9(0) <= USub(0) XOR '1';
  --Somador
  UC10:Somador_4bits port map(A9,U9,'1', UComp, Cout9);
    
  --Complemento de 10 Dezena
  --Setando B9
  D9(3) <= DSub(3) XOR '1';
  D9(2) <= DSub(2) XOR '1';
  D9(1) <= DSub(1) XOR '1';
  D9(0) <= DSub(0) XOR '1';
  --Somador
  DC10:Somador_4bits port map(A9,D9,'1', DComp, Cout9);    
  
  --Escolha da saida  
  MuxU: Mux_4bits port map(UComp, USub, Uver, UFinal);
  MuxD: Mux_4bits port map(DComp, DSub, Dver, DFinal);
  
  --Valores que irão para o comparador
  RespUni: Mux_4bits port map(USom, UFinal, UpDw, Uni);
  RespDez: Mux_4bits port map(DSom, DFinal, UpDw, Dez);
  RespCen: Mux_4bits port map(CSom, CSub, UpDw, Cen);
  
end C;