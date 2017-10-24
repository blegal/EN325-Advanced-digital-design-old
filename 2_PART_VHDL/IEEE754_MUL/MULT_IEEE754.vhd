----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name:
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_SIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL ;

ENTITY MUL_FLOAT32b IS
	PORT (
		INPUT_1         : IN  Std_Logic_Vector(31 DOWNTO 0)  ;
		INPUT_2         : IN  Std_Logic_Vector(31 DOWNTO 0)  ;
		OUTPUT_1         : OUT Std_Logic_Vector(31 DOWNTO 0)  
	);
END MUL_FLOAT32b ;

ARCHITECTURE comportementale OF MUL_FLOAT32b IS 
BEGIN
	ProcessOperateur_3 : PROCESS (INPUT_1, INPUT_2)
		VARIABLE exception  : Std_Logic 					:= '0';
		VARIABLE ex_sortie  : Std_Logic_Vector(31 DOWNTO 0) := "00000000000000000000000000000000";
		CONSTANT cste_pINF  : Std_Logic_Vector(31 DOWNTO 0) := "11111111100000000000000000000000";
		CONSTANT cste_pZERO : Std_Logic_Vector(31 DOWNTO 0) := "00000000000000000000000000000000";
		CONSTANT cste_mZERO : Std_Logic_Vector(31 DOWNTO 0) := "10000000000000000000000000000000";
		CONSTANT cste_ZERO  : Std_Logic_Vector(31 DOWNTO 0) := "X0000000000000000000000000000000";
		CONSTANT cste_mINF  : Std_Logic_Vector(31 DOWNTO 0) := "01111111100000000000000000000000";
		
		-- ATTENTION LA DESCRIPTION DE NaN CORRESPOND AUSSI A pINF et mINF.
		CONSTANT cste_NaN     : Std_Logic_Vector(31 DOWNTO 0) := "X11111111XXXXXXXXXXXXXXXXXXXXXXX";
		CONSTANT valeur_NaN   : Std_Logic_Vector(31 DOWNTO 0) := "11111111111111111111111111111111";
		
		VARIABLE sa, sb, sc : Std_Logic;
		VARIABLE ea, eb, ec : Std_Logic_Vector(7  DOWNTO 0);
		VARIABLE ma, mb, mc : Std_Logic_Vector(22 DOWNTO 0);
		
		-- VARIABLES NECESSAIRES POUR LE CALCUL DE LA MANTISSE
		VARIABLE na         : Std_Logic_Vector(23 DOWNTO 0) := "000000000000000000000000";
		VARIABLE nb         : Std_Logic_Vector(23 DOWNTO 0) := "000000000000000000000000";
		VARIABLE nr         : Std_Logic_Vector(23 DOWNTO 0) := "000000000000000000000000";
		VARIABLE nc         : Std_Logic_Vector(47 DOWNTO 0);
		VARIABLE nd         : Std_Logic_Vector(45 DOWNTO 0);
		VARIABLE ne         : Std_Logic_Vector(22 DOWNTO 0);
		VARIABLE t          : INTEGER;

	BEGIN
		--IF clock'EVENT AND clock = '1' THEN
			--IF start = '1' THEN

				-- DECOMPOSITION DU NOMBRE A
				sa := INPUT_1( 31 );
				ea := INPUT_1( 30 DOWNTO 23 );
				ma := INPUT_1( 22 DOWNTO 0  );
				
				--IF fonction = '0' THEN
				sb := INPUT_2( 31 );
				eb := INPUT_2( 30 DOWNTO 23 );
				mb := INPUT_2( 22 DOWNTO 0  );
				--ELSE
				--	sb := INPUT_1( 31 );
				--	eb := INPUT_1( 30 DOWNTO 23 );
				--	mb := INPUT_1( 22 DOWNTO 0  );
				--END IF;

		
				-----------------------------------------------
				-- GESTION DES EXCEPTIONS
				--IF (INPUT_1= cste_pINF AND floatB = cste_ZERO) OR (INPUT_1= cste_ZERO AND floatB = cste_pINF) then
				--    ex_sortie := cste_pINF;
				--    exception := '1';
				    
				--ELSIF INPUT_1= cste_pINF AND floatB = cste_pINF then
				--    ex_sortie := cste_pINF;
				--    exception := '1';

				--ELSIF (INPUT_1= cste_pINF AND floatB = cste_mINF) OR (INPUT_1 = cste_mINF AND floatB = cste_pINF) then
				--    ex_sortie := cste_mINF;
				--    exception := '1';

				--ELSIF (INPUT_1= 0 AND floatB = cste_pINF) OR (floatA = cste_pINF AND floatB = cste_ZERO) then
				--    ex_sortie := valeur_NaN;
				--    exception := '1';
				    
				--ELSIF (floatA = 0 AND floatB = cste_mINF) OR (floatA = cste_mINF AND floatB = cste_ZERO) then
				--    ex_sortie := valeur_NaN;
				--    exception := '1';
				    
				--ELSIF (floatA = cste_mINF) OR (floatB = cste_mINF) then
				--    ex_sortie := cste_mINF;
				--    exception := '1';
				    
				--ELSIF (floatA = cste_pINF) OR (floatB = cste_pINF) then
				--    ex_sortie := cste_pINF;
				--    exception := '1';
				    
				--ELSIF (floatA = cste_NaN) OR (floatB = cste_NaN) then
				--    ex_sortie := valeur_NaN;
				--    exception := '1';
				
				--ELSE
				--    exception := '0';
				
				--END IF;
				-----------------------------------------------
			
				na(22 DOWNTO 0) := ma; na(23) := '1';
				nb(22 DOWNTO 0) := mb; nb(23) := '1';
		        
				nc := unsigned(na) * unsigned(nb);

		        -- nd = (nc.test(47)==1)?nc.range(46, 1):nc.range(45, 0);
				if( nc(47) = '1' ) then
					nd := nc(46 DOWNTO 1);
				else
					nd := nc(45 DOWNTO 0);
				end if;

				-- ON RECUPERE NOTRE NOUVELLE MANTISSE
		        ne := nd(45 DOWNTO 23);

				-- GESTION DE L'ARRONDI DE LA MANTISSE
				   if(nd(23)='1') and (nd(22)='1') then
				     mc := unsigned(ne) + 1;
				       
		        elsif( nd(22) = '1' ) then
		                if( nd(21) = '1' OR nd(20) = '1' OR nd(19) = '1' OR nd(18) = '1' OR nd(17) = '1' OR nd(16) = '1' OR nd(15) = '1' OR nd(14) = '1'
							 OR nd(13) = '1' OR nd(12) = '1' OR nd(11) = '1' OR nd(10) = '1' OR nd(9) = '1' OR nd(8) = '1' OR nd(7) = '1' OR
							 nd(6) = '1' OR nd(5) = '1' OR nd(4) = '1' OR nd(3) = '1' OR nd(2) = '1' OR nd(1) = '1' OR nd(0) = '1' ) then
						
							mc := unsigned(ne) + 1;	-- TODO : verifier que l'on ne genere pas une retenue !

							
						else
							mc := ne;
						end if;
				else
						mc := ne;
				end if;

				-- GESTION DU CALCUL DE L'EXPOSANT
				if( nc(47) = '1' ) then
					t  := CONV_INTEGER(ea) + CONV_INTEGER(eb) + 1;
				else
					t  := CONV_INTEGER(ea) + CONV_INTEGER(eb);
				end if;
				
				t := (t - 127);
		      	
				-- TODO: Il faut gerer les exceptions au niveau de l'exposant
				ec := CONV_STD_LOGIC_VECTOR(t, 8);


				-- GESTION DU SIGNE DU PRODUIT          
				sc := sa XOR sb;
			
				-- RECOMPOSITION DU NOMBRE C
				--if( exception = '0' ) then
				OUTPUT_1( 31 )           <= sc;
				OUTPUT_1( 30 DOWNTO 23 ) <= ec;
				OUTPUT_1( 22 DOWNTO 0  ) <= mc;
				--produit<=nd;
				
				--else
				--   floatC <= ex_sortie;
				   
				--end if;


			--END IF;
		--END IF ;
	END PROCESS ProcessOperateur_3 ;

END comportementale ;