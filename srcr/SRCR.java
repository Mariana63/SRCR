/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package srcr;

import java.io.IOException;
import se.sics.jasper.SICStus;
import java.util.HashMap;
import java.util.Scanner;
import se.sics.jasper.Query;

/**
 *
 * @author maleite
 */
public class SRCR {

    public static Scanner in = new Scanner(System.in);
  
    public static void menuPrincipal() throws IOException, ClassNotFoundException {
	System.out.println("#################### Menu Pastelarias ######################");
	System.out.println("#                                                          #");
    	System.out.println("#   1 - Listar pastelarias                                 #");
    	System.out.println("#   2 - Calcular distâncias                                #");
    	System.out.println("#   3 - Pastelarias por região                             #");
	System.out.println("#                                                          #");
	System.out.println("#   Escolha uma opção                                      #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
    	do {
    		if(opt.equals("1"))
    			
    		if(opt.equals("2"))
    			
    		if(opt.equals("3"))
    			
    		} else {
    			System.out.println("Opcão inválida!");
                menuPrincipal();
            }
                
    	} while(!(opt.equals("1") || opt.equals("2") || opt.equals("3")));
    }
  
  public static void main(String[] argv) {
  
  SICStus sp;
    
  try 
    {
      sp = new SICStus(argv,null);

      sp.load("C:\\Users\\maleite\\Desktop\\trab.pl");
      String queryS="pai('jose',X).";
      //String queryS="descendente('jose',X).";
      //String queryS="avo(X,'joao').";
      HashMap map = new HashMap();
      Query query = sp.openPrologQuery(queryS,map);

      while (query.nextSolution()) { 
          System.out.println(map.toString());
        }
    }
  catch ( Exception e )
    {
      e.printStackTrace();
    }
    
    }
}
