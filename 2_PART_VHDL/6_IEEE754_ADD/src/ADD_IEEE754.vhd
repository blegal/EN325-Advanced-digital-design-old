--------------------------------------------------------------------------------------
--
--IYAMBA ASSA Stage VHDL Juin 2007
--Unité d'addition:bloc complet
--
--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work; 
use work.all;


entity ADD_FLOAT32b is
port( INPUT_1: in std_logic_vector(31 downto 0);
      INPUT_2: in std_logic_vector(31 downto 0);
      OUTPUT_1: out std_logic_vector(31 downto 0)
      );
end ADD_FLOAT32b;

Architecture corps of ADD_FLOAT32b is

 COMPONENT selection is 
   port( 
         INPUT_1: in std_logic_vector(31 downto 0);
         INPUT_2: in std_logic_vector(31 downto 0);
         m_grand: out std_logic_vector(22 downto 0);
         m_petit: out std_logic_vector(23 downto 0);
         --expo_egal: out std_ulogic;
         expo_grand: out std_logic_vector(7 downto 0);
          diff_expo_bin: out std_logic_vector (4 downto 0);
         sr: out std_logic);
  end component;
  
  COMPONENT aligneur_mantisse is
    port( 
           m_grand: in std_logic_vector(22 downto 0);
      m_petit: in std_logic_vector(23 downto 0);
      --expo_egal: in std_ulogic;
      diff_expo_bin: in std_logic_vector (4 downto 0);
      grand_m: out Std_Logic_Vector (26 downto 0 );
      petit_m: out Std_Logic_Vector (26 downto 0 )
          );
   end component;


  COMPONENT renormalisation is
   port( 
         somme_mantisse: in std_logic_vector(27 downto 0);           
        expo_grand: in std_logic_vector(7 downto 0);
        Z : in Std_Logic_Vector (5 downto 0 );
         m_finale: out std_logic_vector(22 downto 0);
         --j: out integer;
         expo_final: out std_logic_vector (7 downto 0)
       );
   end component;
   
   component Addition_mantisse is
port( c: in std_logic;
      d: in std_logic;
      grand_m: in Std_Logic_Vector (26 downto 0 );
      petit_m: in Std_Logic_Vector (26 downto 0 );
      somme_mantisse: out std_logic_vector(27 downto 0);
      Z: out Std_Logic_Vector (5 downto 0 )
      );
      
  end component;
  
 
  signal m_grand: std_logic_vector (22 downto 0);
  signal m_petit: std_logic_vector (23 downto 0);
  signal petit_m,grand_m: std_logic_vector (26 downto 0);
  --signal egalite: std_ulogic;
  --signal j:  integer;
  signal signe: std_ulogic;
  signal somme: std_logic_vector(27 downto 0);
  signal somme_finale: std_logic_vector(22 downto 0);
  signal expo: std_logic_vector (7 downto 0);
  signal expo_diff: std_logic_vector (4 downto 0);
  signal grand_expo:std_logic_vector(7 downto 0);
  signal Z: Std_Logic_Vector (5 downto 0 );
 
  
  
   
 begin
     
     sel: selection port map(INPUT_1,INPUT_2,m_grand,m_petit,grand_expo,expo_diff, signe);
     aligneur: aligneur_mantisse port map(m_grand, m_petit,expo_diff,grand_m,petit_m );
     addition: Addition_mantisse port map(INPUT_1(31),INPUT_2(31),grand_m,petit_m,somme,Z);
     norme: renormalisation port map(somme,grand_expo,Z,somme_finale,expo);
	  OUTPUT_1<= signe & expo & somme_finale;

end corps;     
  
     

--------------------------------------------------------------------------------------
--IYAMBA ASSA Stage VHDL Juin 2007
--Bloc de sortie additionneur
--
--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work; 
use work.all;


entity renormalisation is
port( somme_mantisse: in std_logic_vector(27 downto 0);            
      expo_grand: in std_logic_vector(7 downto 0);
      Z : in Std_Logic_Vector (5 downto 0 );
      m_finale: out std_logic_vector(22 downto 0);
      --j:out integer;
      expo_final: out std_logic_vector (7 downto 0)
    );
end renormalisation;

Architecture corps of renormalisation is

  begin
 
    
  
        process(somme_mantisse,expo_grand,Z)
            
           variable expo_final_tmp: std_logic_vector (7 downto 0);
           variable somme: std_logic_vector (27 downto 0);
           variable sommebis:bit_vector (27 downto 0);
           variable s:bit_vector (27 downto 0);
           variable i:integer;
           variable a: Std_Logic_Vector (5 downto 0 );
           variable tmp:std_logic_vector (22 downto 0);
            
            
            
            begin 
               
          
          i:=conv_integer(Z);
          --j<=i;
          somme:=somme_mantisse;
          sommebis:=To_bitvector(somme);
          s:= sommebis sll conv_integer(Z);
			
			 --test sur l'arrondi
			   
			   if ((s(3)='1' and s(4)='1') or (s(3)='1' and (s(2)='1' or s(1)='1' or s(0)='1')) ) then
			       tmp:=To_stdlogicvector(s(26 downto 4))+"00000000000000000000001";
			       m_finale<=tmp;  
			       
--			   elsif (s(3)='1' and (s(2)='1' or s(1)='1' or s(0)='1')) then
--			       tmp:=To_stdlogicvector(s(26 downto 4))+"00000000000000000000001";
--			       m_finale<=tmp; 
			    else
			       m_finale<=To_stdlogicvector(s(26 downto 4));
			    end if;
			
			   
--			   if i=0 then
--			      expo_final_tmp:=expo_grand+1;
			   if i=32 then
			      expo_final_tmp:=expo_grand;
			   else
			      expo_final_tmp:=expo_grand-conv_std_logic_vector(conv_integer(Z),8)+1;
			   
			   end if;
			   
			   expo_final<=expo_final_tmp;
			   
			  end process;
			  
		end corps;
			  
			            


--------------------------------------------------------------------------------------
--IYAMBA ASSA Stage VHDL Juin 2007
--Unité d'addition:bloc d'entrée
--
--------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;
library work; 
use work.all;

entity selection is 
port( INPUT_1: in std_logic_vector(31 downto 0);
      INPUT_2: in std_logic_vector(31 downto 0);
      m_grand: out std_logic_vector(22 downto 0);
      m_petit: out std_logic_vector(23 downto 0);
      --expo_egal: out std_ulogic;
      expo_grand: out std_logic_vector(7 downto 0);
      --expo_petit: out std_logic_vector(7 downto 0);
     -- diff_expo: out integer;
      diff_expo_bin: out std_logic_vector (4 downto 0);
      sr: out std_logic);
  end selection;

architecture corps of selection is
begin
    
    process(INPUT_1,INPUT_2)
       variable sa: std_ulogic;
       variable sb: std_ulogic;
       variable ea: std_logic_vector(7 downto 0);
       variable eb:std_logic_vector(7 downto 0);
       variable ma: std_logic_vector(22 downto 0);
       variable mb: std_logic_vector(22 downto 0);   
       variable diff_expo_inter: integer;
  
        
        begin
		
            sa:=INPUT_1(31);
            sb:=INPUT_2(31);
            ea:=INPUT_1(30 downto 23);
            eb:=INPUT_2(30 downto 23);
            ma:=INPUT_1(22 downto 0);
            mb:=INPUT_2(22 downto 0);
            
          if (conv_integer(ea) = conv_integer(eb)) then
              expo_grand<= ea;
              diff_expo_inter:= 0;
              if conv_integer(ma)>conv_integer(mb) then
                  m_grand<= ma;
                  m_petit<= '1' & mb;
                  sr<= sa ;
              else 
                 m_grand<=mb;
                 m_petit<='1' & ma;
                 sr<=sb;
                 
              end if;

          elsif conv_integer(ea)>conv_integer(eb) then
              expo_grand<= ea;
              m_grand<= ma;
              m_petit<= '1' & mb;
              diff_expo_inter:= conv_integer(ea)-conv_integer(eb);
              sr<= sa;
          
           else     --elsif conv_integer(ea)<conv_integer(eb) then
              expo_grand<= eb;
              m_grand<= mb;
              m_petit<= '1' & ma;
              diff_expo_inter:= conv_integer(eb)-conv_integer(ea);
              sr<= sb;

          end if;
          
         if conv_integer(diff_expo_inter)>=27 then
         diff_expo_inter:=27;
			else
				diff_expo_inter:=diff_expo_inter;
        end if;
        diff_expo_bin<=conv_std_logic_vector(diff_expo_inter,5);

      end process;
   end corps;
        
		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use work.txt_util.all;

library work; 
use work.all;


entity Addition_mantisse is
port( c: in std_logic;
      d: in std_logic;
      grand_m: in Std_Logic_Vector (26 downto 0 );
      petit_m: in Std_Logic_Vector (26 downto 0 );
      somme_mantisse: out std_logic_vector(27 downto 0);
      Z : out Std_Logic_Vector (5 downto 0 ) 
      );
end Addition_mantisse;
    
     
architecture corps of Addition_mantisse is
component ZLC_32b is
port ( E : in  Std_Logic_Vector (31 downto 0 ) ; 
       Z : out Std_Logic_Vector (5 downto 0 ) ) ; 
end component;


signal E:Std_Logic_Vector (31 downto 0 );


begin  
    nb_Z: ZLC_32b port map(E,Z);
     
     process (petit_m,grand_m,c,d)
         variable somme: Std_Logic_Vector (27 downto 0 );
         variable tmp1,tmp2: Std_Logic_Vector (27 downto 0 );        

        begin
            
         tmp1:='0' & grand_m;
         tmp2:='0' & petit_m;
         if c=d then
                somme:= tmp1 + tmp2;
                somme_mantisse<=somme;
            else
                somme:= tmp1-tmp2;
                somme_mantisse<=somme;
             end if;
             E<= somme & "0000";  
               
      end process;
     
      
  end corps;

  
--------------------------------------------------------------------------------------
--IYAMBA ASSA Stage VHDL Juin 2007
--Unité d'addition:bloc d'entrée
--
--------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;
library work; 
use work.all;

entity aligneur_mantisse is
port( 
      m_grand: in std_logic_vector(22 downto 0);
      m_petit: in std_logic_vector(23 downto 0);
     -- expo_egal: in std_ulogic;
      diff_expo_bin: in std_logic_vector (4 downto 0);
      grand_m: out Std_Logic_Vector (26 downto 0 );
      petit_m: out Std_Logic_Vector (26 downto 0 )
      --somme_mantisse: out std_logic_vector(27 downto 0)
      );
  end aligneur_mantisse;
  
  
  architecture corps of aligneur_mantisse is
      
    component Shift is
      port ( Entree : in  Std_Logic_Vector (23 downto 0 ) ;   -- E : input
       D : in  Std_Logic_Vector (4 downto 0 ) ;    -- D : positions
       S : out Std_Logic_Vector (26 downto 0 ) ) ;
   end component;
         
         signal S: Std_Logic_Vector (26 downto 0 );    
         --signal entree: Std_Logic_Vector (23 downto 0 );
         --signal D: Std_Logic_Vector (4 downto 0 );  
         signal pm,gm:std_logic_vector(26 downto 0);
              
         begin 
            -- entree<='1' & m_petit;
             --D<=conv_std_logic_vector(diff_expo,5);
             decaleur: Shift port map (m_petit,diff_expo_bin ,S);
       
              gm<='1' & m_grand & "000";
              pm<= S ;
              grand_m<=gm;
              petit_m<=pm;
         
          end corps;
          
                  

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--
--
--  Synthese OPAR Version 1 (Demo)
--
--     Compteur de zeros en tete
-- synthétisé le Lundi 18 Juin 2007
--
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--

library IEEE;
use IEEE.STD_LOGIC_1164.All;

entity ZLC_32b is
port ( E : in  Std_Logic_Vector (31 downto 0 ) ;  -- E : bit string
		--clk: in std_logic;
       Z : out Std_Logic_Vector (5 downto 0 ) ) ; -- Z : number of leading zeroes
end ZLC_32b ;

architecture structural of ZLC_32b is
signal P : Std_Logic_Vector (119 downto 0) ; -- internal signals

begin
--process (clk)
--begin
	--if clk'event and clk='1' then

P(119 downto 88) <= not E ; -- row of inverters

 -- row 1
P(87) <= P(119) and P(118) ; P(86) <= P(119) and not P(118) ; 
P(85) <= P(117) and P(116) ; P(84) <= P(117) and not P(116) ; 
P(83) <= P(115) and P(114) ; P(82) <= P(115) and not P(114) ; 
P(81) <= P(113) and P(112) ; P(80) <= P(113) and not P(112) ; 
P(79) <= P(111) and P(110) ; P(78) <= P(111) and not P(110) ; 
P(77) <= P(109) and P(108) ; P(76) <= P(109) and not P(108) ; 
P(75) <= P(107) and P(106) ; P(74) <= P(107) and not P(106) ; 
P(73) <= P(105) and P(104) ; P(72) <= P(105) and not P(104) ; 
P(71) <= P(103) and P(102) ; P(70) <= P(103) and not P(102) ; 
P(69) <= P(101) and P(100) ; P(68) <= P(101) and not P(100) ; 
P(67) <= P(99) and P(98) ; P(66) <= P(99) and not P(98) ; 
P(65) <= P(97) and P(96) ; P(64) <= P(97) and not P(96) ; 
P(63) <= P(95) and P(94) ; P(62) <= P(95) and not P(94) ; 
P(61) <= P(93) and P(92) ; P(60) <= P(93) and not P(92) ; 
P(59) <= P(91) and P(90) ; P(58) <= P(91) and not P(90) ; 
P(57) <= P(89) and P(88) ; P(56) <= P(89) and not P(88) ; 

 -- row 2
P(55) <= P(87) and P(85) ; P(54) <= P(87) and not P(85) ; P(53) <= P(86) or (P(87) and P(84)) ; 
P(52) <= P(83) and P(81) ; P(51) <= P(83) and not P(81) ; P(50) <= P(82) or (P(83) and P(80)) ; 
P(49) <= P(79) and P(77) ; P(48) <= P(79) and not P(77) ; P(47) <= P(78) or (P(79) and P(76)) ; 
P(46) <= P(75) and P(73) ; P(45) <= P(75) and not P(73) ; P(44) <= P(74) or (P(75) and P(72)) ; 
P(43) <= P(71) and P(69) ; P(42) <= P(71) and not P(69) ; P(41) <= P(70) or (P(71) and P(68)) ; 
P(40) <= P(67) and P(65) ; P(39) <= P(67) and not P(65) ; P(38) <= P(66) or (P(67) and P(64)) ; 
P(37) <= P(63) and P(61) ; P(36) <= P(63) and not P(61) ; P(35) <= P(62) or (P(63) and P(60)) ; 
P(34) <= P(59) and P(57) ; P(33) <= P(59) and not P(57) ; P(32) <= P(58) or (P(59) and P(56)) ; 

 -- row 3
P(31) <= P(55) and P(52) ; P(30) <= P(55) and not P(52) ; P(29) <= P(54) or (P(55) and P(51)) ; P(28) <= P(53) or (P(55) and P(50)) ; 
P(27) <= P(49) and P(46) ; P(26) <= P(49) and not P(46) ; P(25) <= P(48) or (P(49) and P(45)) ; P(24) <= P(47) or (P(49) and P(44)) ; 
P(23) <= P(43) and P(40) ; P(22) <= P(43) and not P(40) ; P(21) <= P(42) or (P(43) and P(39)) ; P(20) <= P(41) or (P(43) and P(38)) ; 
P(19) <= P(37) and P(34) ; P(18) <= P(37) and not P(34) ; P(17) <= P(36) or (P(37) and P(33)) ; P(16) <= P(35) or (P(37) and P(32)) ; 

 -- row 4
P(15) <= P(31) and P(27) ; P(14) <= P(31) and not P(27) ; P(13) <= P(30) or (P(31) and P(26)) ; P(12) <= P(29) or (P(31) and P(25)) ; P(11) <= P(28) or (P(31) and P(24)) ; 
P(10) <= P(23) and P(19) ; P(9) <= P(23) and not P(19) ; P(8) <= P(22) or (P(23) and P(18)) ; P(7) <= P(21) or (P(23) and P(17)) ; P(6) <= P(20) or (P(23) and P(16)) ; 

 -- row 5
P(5) <= P(15) and P(10) ; P(4) <= P(15) and not P(10) ; P(3) <= P(14) or (P(15) and P(9)) ; P(2) <= P(13) or (P(15) and P(8)) ; P(1) <= P(12) or (P(15) and P(7)) ; P(0) <= P(11) or (P(15) and P(6)) ; 

Z <= P(5 downto 0) ;
--end if;
--end process;
end structural;




--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--
--
--  Synthese OPAR Version 1 (Demo)
--
--             Decaleur
-- synthétisé le Lundi 18 Juin 2007
--
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--

library IEEE;
use IEEE.STD_LOGIC_1164.All;

entity Shift is
port ( Entree : in  Std_Logic_Vector (23 downto 0 ) ;   -- E : input
       D : in  Std_Logic_Vector (4 downto 0 ) ;    -- D : positions
		 --clk:in std_logic;
       S : out Std_Logic_Vector (26 downto 0 ) ) ; -- Z : E shifted D positions
end Shift ;

architecture structural of Shift is
signal sticky : Std_Logic ; -- sticky bit
signal P0, P1, P2, P3, P4, P5 : Std_Logic_Vector (25 downto 0) ; -- internal signals

begin
--process (clk)
--begin
--if clk'event and clk='1' then

P5 <= Entree & "00" ; -- guard and round bits

with D(4) select P4 <= P5 when '0' , "0000000000000000" & P5(25 downto  16) when others ;

with D(3) select P3 <= P4 when '0' , "00000000" & P4(25 downto 8 ) when others ;

with D(2) select P2 <= P3 when '0' , "0000" & P3(25 downto 4) when others ;

with D(1) select P1 <= P2 when '0' , "00" & P2(25 downto 2) when others ;

with D(0) select P0 <= P1 when '0' , "0" & P1(25 downto 1) when others ;

sticky <= ((P5(15) or P5(14) or P5(13) or P5(12) or P5(11) or P5(10) or P5(9) or P5(8) or
            P5(7) or P5(6) or P5(5) or P5(4) or P5(3) or P5(2) or P5(1) or P5(0)) and D(4)) or
          ((P4(7) or P4(6) or P4(5) or P4(4) or P4(3) or P4(2) or P4(1) or P4(0)) and D(3)) or
          ((P3(3) or P3(2) or P3(1) or P3(0)) and D(2)) or
          ((P2(1) or P2(0)) and D(1)) or (P1(0) and D(0)) ;
S <= P0 & sticky ;
--end if;
--end process;
end structural ;