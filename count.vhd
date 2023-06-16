library ieee;
use ieee.std_logic_1164.all;

entity count is
	port(updw,mxmi,step,load,clr,clk: in std_logic;
	     a2, a1, a0: in std_logic_vector(3 downto 0);
	     ck, led : out std_logic;
	     HEX2, HEX1, HEX0: out std_logic_vector(0 to 6));
end count;

architecture ckt of count is 

component ck_div is
   port (ck_in : in  std_logic;
         ck_out: out std_logic);
end component;

component seg7 is
	port(Inp : in std_logic_vector(3 downto 0);
		  SO  : out std_logic_vector (6 downto 0));
end component;
	
component reg_4bits_v2 is
	port(I: in std_logic_vector(3 downto 0);
        load, clr, clk: in std_logic;
		  Q: out std_logic_vector(3 downto 0));
end component;
	
component mux_2x1 is
    port (a, b : in std_logic_vector(11 downto 0);
          sel : in std_logic;
          y : out std_logic_vector(11 downto 0));
end component;

component Contador is
	port(MCen, MDez, MUni, step: in std_logic_vector(3 downto 0);
		  UpDw : in std_logic;
        SinalPos, SinalNeg: out std_logic;
        Cen, Dez, Uni: out std_logic_vector(3 downto 0));
end component;

component comparador_BCD is 
	port(acent,bcent,adeze,bdeze,auni,buni: in std_logic_vector(0 to 3);
		  igual,maior,menor: out std_logic);
end component;

component main is
	port(A2, A1, A0: in std_logic_vector(3 downto 0);
        load, clr, clk, max_min, stp: in std_logic;
        S2min, S1min, S0min, S2max, S1max, S0max, S0step: out std_logic_vector(3 downto 0));
end component;

signal s_clk,s_ct_neg,s_ct_pos,s_cmp_mx_i,s_cmp_mx_a,s_cmp_mx_e,s_cmp_mi_i,s_cmp_mi_a,s_cmp_mi_e,s_or_mx,s_or_mi,s_or_sla ,s_or_slb : std_logic; 
signal s_main_mi_cen,s_main_mi_dez,s_main_mi_und,s_main_mx_cen,s_main_mx_dez,s_main_mx_und : std_logic_vector(3 downto 0);
signal s_main_step,s_reg4_cen,s_reg4_dez,s_reg4_und,s_ct_o_cen,s_ct_o_dez,s_ct_o_und : std_logic_vector(3 downto 0);
signal s_mx_reg,s_count_out,s_mx_final_a,s_mx_final_b,s_mx_aa,s_mx_ba : std_logic_vector(11 downto 0);
signal sHEX0,sHEX1,sHEX2 : std_logic_vector(0 to 6);

signal s_step,s_load,s_clr : std_logic;

begin

s_step <= not(step);
s_load <= not(load);
s_clr <= not(clr);

u00: ck_div port map(clk,s_clk);

u01: main port map(a2, a1, a0, s_load, s_clr, s_clk, mxmi, s_step, s_main_mi_cen,s_main_mi_dez,s_main_mi_und, s_main_mx_cen,s_main_mx_dez,s_main_mx_und, s_main_step);
u02: reg_4bits_v2 port map(s_mx_reg(11 downto 8),'1',s_clr,s_clk,s_reg4_cen);
u03: reg_4bits_v2 port map(s_mx_reg( 7 downto 4),'1',s_clr,s_clk,s_reg4_dez);
u04: reg_4bits_v2 port map(s_mx_reg( 3 downto 0),'1',s_clr,s_clk,s_reg4_und);
u05: Contador port map(s_reg4_cen,s_reg4_dez,s_reg4_und,s_main_step,updw,s_ct_pos,s_ct_neg,s_ct_o_cen,s_ct_o_dez,s_ct_o_und);

--u02: reg_4bits_v2 port map(s_count_out(11 downto 8),'1',clr,s_clk,s_reg4_cen);
--u03: reg_4bits_v2 port map(s_count_out( 7 downto 4),'1',clr,s_clk,s_reg4_dez);
--u04: reg_4bits_v2 port map(s_count_out( 3 downto 0),'1',clr,s_clk,s_reg4_und);
--u05: Contador port map(s_reg4_cen,s_reg4_dez,s_reg4_und,"0001",updw,s_ct_pos,s_ct_neg,s_ct_o_cen,s_ct_o_dez,s_ct_o_und);

u06: comparador_BCD port map(s_main_mx_cen,s_ct_o_cen,s_main_mx_dez,s_ct_o_dez,s_main_mx_und,s_ct_o_und,s_cmp_mx_i,s_cmp_mx_a,s_cmp_mx_e);
u07: comparador_BCD port map(s_main_mi_cen,s_ct_o_cen,s_main_mi_dez,s_ct_o_dez,s_main_mi_und,s_ct_o_und,s_cmp_mi_i,s_cmp_mi_a,s_cmp_mi_e);
u08: mux_2x1 port map(s_mx_final_a,s_mx_final_b,updw,s_mx_reg);
u09: mux_2x1 port map(s_count_out,s_mx_aa,s_or_sla,s_mx_final_a);
u10: mux_2x1 port map(s_mx_ba,s_count_out,s_or_slb,s_mx_final_b);
u11: seg7 port map(s_reg4_cen, sHEX2);
u12: seg7 port map(s_reg4_dez, sHEX1);
u13: seg7 port map(s_reg4_und, sHEX0);

HEX2 <= not(sHEX2);
HEX1 <= not(sHEX1);
HEX0 <= not(sHEX0); 

s_or_mx  <= s_cmp_mx_i OR s_cmp_mx_a;
s_or_mi  <= s_cmp_mi_i OR s_cmp_mi_e;
s_or_sla <= s_or_mi OR s_ct_neg;
s_or_slb <= s_or_mx OR s_ct_pos;
s_mx_ba <= s_main_mx_cen & s_main_mx_dez & s_main_mx_und;
s_mx_aa <= s_main_mi_cen & s_main_mi_dez & s_main_mi_und;
s_count_out <= s_ct_o_cen & s_ct_o_dez & s_ct_o_und;

led <= s_or_sla OR s_or_slb; 
ck <= s_clk;

end ckt;