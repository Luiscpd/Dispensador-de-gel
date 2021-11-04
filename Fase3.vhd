
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fase3 is

Generic(
	Tt: Integer := 240000
--	Ta: Integer := 30000
);


    Port ( Display : out  STD_LOGIC_VECTOR (7 downto 0);
			  sel: out Std_logic_vector (2 downto 0);
			  up : in STD_LOGIC;
			  down : in STD_LOGIC;
			  clk : in  STD_LOGIC;
			  DPS :  in		Std_Logic_Vector(3 downto 0);
			  PWM :		out	Std_Logic;
			  alerta: out STD_LOGIC;
			  reset: in STD_LOGIC
			  );

end Fase3;

architecture Behavioral of Fase3 is

signal numeros, u, d,c : integer range 0 to 10;
signal Cnt: integer range 0 to Tt;
signal Ta: integer range 0 to Tt;

begin

process(clk)
	begin
			if(rising_edge(clk)) then
				if up='0' then
				Case DPS is
					When "0000" =>
						Ta<=6000;
					When "0100" =>
						Ta<=30000; --180° 		
					When others =>
						Ta<=6000;						
				End Case;
				elsif up='1' then
				Ta<=30000;
				end if; 
				if (u=5 and d=1) then
				Ta<=6000;
				alerta<='1';
				else
				alerta<='0';
				end if;
				
				if(Cnt=Tt-1) then
					Cnt<=0;
				else
					Cnt<=Cnt+1;
				end if;
				
				if(Cnt<Ta) then
					PWM<='1';
				else
					PWM<='0';
				end if;
				
			end if;
			
			if reset = '0' then 
			Ta<=6000;
			alerta<='0';
			end if;
end process;




process(clk) 

variable tiempo: integer range 0 to 11999999;
variable bandera: integer range 0 to 3;
variable contador: integer range 0 to 12000;

begin
	if(rising_edge(clk)) then
		if up='1' then
		if(tiempo = 11999999) then
			tiempo := 0;
			u <= u +1;
			if (u = 9) then
			 u<=0;
			 d<=d+1;
			 end if;
				if (d=1) then
					d<=1;
					c<=0;
					if (u = 5) then
					u<=5;
					end if;
				end if;
		else
			tiempo:= tiempo +1;
		end if;		
		end if;	
		
		if down='0' then
		if(tiempo = 11999999) then
			tiempo := 0;
			u <= u -1;
			if (u = 0) then
				u<=9;
			if (u = 9) then
				u<=0;
		 d<=d-1;
			 end if;
				if (d=1) then
					d<=1;
					c<=0;
					if (u = 5) then
						u<=5;
						u <= u -1;					
						
					end if;
				end if;
				if (u = 0) then
				d<=0;
				end if;
			end if; 
				if (d = 0) then
					u <= u-1;
						if (u = 0) then 
							u<=0;
						end if;
				end if;		
		else
			tiempo:= tiempo +1;
		end if;		
		end if;

			if reset = '0' then 
			u<=0;
			d<=0;
			c<=0;
			end if;	


	
	if contador = 12000 then
		contador :=0;
		bandera := bandera +1;
			if bandera = 1 then
				numeros <= u;
				sel <= "011";
			elsif bandera = 2 then
				numeros <= d;
				sel <= "101";
			elsif bandera = 3 then
				numeros <= c;
				sel <= "110";
				bandera :=0;
			end if;
		else
			contador:= contador +1;
		end if;
		
		case numeros is 
			-------------------------hgfedcba
				 when 0 => Display <= "11000000";
				 when 1 => Display <= "11111001";
				 when 2 => Display <= "10100100";
				 when 3 => Display <= "10110000";
				 when 4 => Display <= "10011001";
				 when 5 => Display <= "10010010";
				 when 6 => Display <= "10000010";
				 when 7 => Display <= "11111000";
				 when 8 => Display <= "10000000";
				 when 9 => Display <= "10011000";
				 when others => Display <= "00000000";
		end case;
		
	
	end if;
 
end process;


end Behavioral;

