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
  
    public static String distPastelarias() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("#################### Menu Distancias ######################");
	System.out.println("#                                                         #");
    	in.nextLine();
        System.out.println("#   Insira a pastelaria origem:                           #");
        String origem = in.nextLine();
    	System.out.println("#   Insira a pastelaria destino:                          #");
    	String destino = in.nextLine();
        System.out.println("#                                                         #");
	System.out.println("###########################################################");
        
        
        //ESTÁ MAL!!!
        query="distancia(local(origem,X,Y),local(destino,A,B),DISTANCIA).";
        
        return query;
   
    }
    
    public static void pastRegiao() throws IOException, ClassNotFoundException {
	System.out.println("############## Pastelarias por região ###############");
	System.out.println("#                                                   #");
    	System.out.println("#   De que região pretende ver                      #");
    	System.out.println("#                                                   #");
	System.out.println("#   Prima:                                          #");
	System.out.println("#            N - Norte                              #");
	System.out.println("#            C - Centro                             #");
	System.out.println("#            S - Sul                                #");
	System.out.println("#                                                   #");
	System.out.println("#####################################################");
    	String opt = in.next();
   	
    	do {
    		if(opt.equals("N") || opt.equals("n"))
                { }	
    		if(opt.equals("C") || opt.equals("c"))
                { }	
    		if(opt.equals("S") || opt.equals("s"))
                { }	
                else {
    			System.out.println("Opcão inválida!");
                menuPrincipal();
            }
                
    	} while(!((opt.equals("N")) || (opt.equals("n")) || (opt.equals("C")) || (opt.equals("c")) || (opt.equals("S")) || (opt.equals("s"))));
    }
    
    public static String calcularDistancias() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("#################### Menu Distancias ######################");
	System.out.println("#                                                         #");
    	System.out.println("#   1 - Distancia entre 2 pastelarias                     #");
    	System.out.println("#   2 - Lista de pontos a percorrer                       #");
    	System.out.println("#   3 - Distancia mínima                                  #");
	System.out.println("#                                                         #");
	System.out.println("#   Escolha uma opção                                     #");
	System.out.println("###########################################################");
    	String opt = in.next();
   	
    	do {
    		if(opt.equals("1"))
                { query=distPastelarias(); }	
    		if(opt.equals("2"))
                { }	
    		if(opt.equals("3"))
                { }	
                else {
    			System.out.println("Opcão inválida!");
                menuPrincipal();
            }
                
    	} while(!(opt.equals("1") || opt.equals("2") || opt.equals("3")));
        
        return query;
    }
    
    public static String menuPrincipal() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("#################### Menu Pastelarias ######################");
	System.out.println("#                                                          #");
    	System.out.println("#   1 - Listar pastelarias                                 #");
    	System.out.println("#   2 - Calcular distâncias                                #");
    	System.out.println("#   3 - Pastelarias por região                             #");
	System.out.println("#   4 - Sair                                               #");
	System.out.println("#                                                          #");
	System.out.println("#   Escolha uma opção                                      #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
    	do {
    		if(opt.equals("1"))
                { query="pastelaria(Nome)."; 
                } else	
    		if(opt.equals("2"))
                { query=calcularDistancias(); } else
    		if(opt.equals("3"))
                { pastRegiao(); } else
                if(opt.equals("4")) 
                { System.exit(0); }
                else {
    			System.out.println("Opcão inválida!");
                //menuPrincipal();
            }
                
    	} while(!(opt.equals("1") || opt.equals("2") || opt.equals("3")));
        
        return query;
    }
  
    
  public static void main(String[] argv) {
  
  SICStus sp;
    
  try 
    {
      sp = new SICStus(argv,null);

      sp.load("C:\\Users\\maleite\\Desktop\\trab.pl");
      String queryS = null;
      
      queryS=menuPrincipal();
      //String queryS="pai('jose',X).";
      //String queryS="descendente('jose',X).";
      //String queryS="avo(X,'joao').";
      HashMap map = new HashMap();
      Query query = sp.openPrologQuery(queryS,map);

      while (query.nextSolution()) { 
          System.out.println(map.toString());
        }
      menuPrincipal();
    }
  catch ( Exception e )
    {
      e.printStackTrace();
    }
    
    }
}
