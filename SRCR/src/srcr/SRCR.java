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
import se.sics.jasper.SPException;

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
        
        query="verifica('"+origem+"','"+destino+"',DISTANCIA).";
        
        return query;
    }
    
    public static String restRegiao() throws IOException, ClassNotFoundException {
	String query=null;
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
        
    	if(opt.equals("N") || opt.equals("n"))
               { query="regiao(RESTAURANTE,norte)."; } else	
    	if(opt.equals("C") || opt.equals("c"))
               { query="regiao(RESTAURANTE,centro)."; } else
    	if(opt.equals("S") || opt.equals("s"))
               { query="regiao(RESTAURANTE,sul)."; }	
        else { System.out.println("Opcão inválida!");
               query="erro"; }
        
        return query;
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
   	
    	if(opt.equals("1"))
                { query=distPastelarias(); } else
    	if(opt.equals("2"))
                { } else
  	if(opt.equals("3"))
                { }	
        else { System.out.println("Opcão inválida!");
               query="erro"; }
                
        return query;
    }
    
    public static String infoRest() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("#################### Info Restaurante #####################");
	System.out.println("#                                                         #");
    	System.out.println("#   1 - Listar restaurante                                #");
    	System.out.println("#   2 - Restaurantes por região                           #");
	System.out.println("#                                                         #");
	System.out.println("#   Escolha uma opção                                     #");
	System.out.println("###########################################################");
    	String opt = in.next();
   		
        if(opt.equals("1"))
                { query="restaurante(NOME)."; } else
    	if(opt.equals("2"))
                { query=restRegiao(); } else
	if(opt.equals("3"))
                { }	
        else { System.out.println("Opcão inválida!");
               query="erro";
             }
                
        return query;
    }
    
    public static String menuPrincipal() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("#################### Menu Restaurantes ######################");
	System.out.println("#                                                          #");
    	System.out.println("#   1 - Info restaurantes                                  #");
    	System.out.println("#   2 - Calcular distâncias                                #");
        System.out.println("#                                                          #");
	System.out.println("#   0 - Sair                                               #");
	System.out.println("#                                                          #");
	System.out.println("#   Escolha uma opção                                      #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
        if(opt.equals("1"))
                { query=infoRest(); 
                } else	
        if(opt.equals("2"))
                { query=calcularDistancias(); } else
        if(opt.equals("0")) 
                { System.exit(0); }
        else { System.out.println("Opcão inválida!");
               query="erro"; 
             }
        
        return query;
    }
  
    
  public static void main(String[] argv) throws SPException, IOException, Exception {
  
  SICStus sp;
    

      sp = new SICStus(argv,null);

      sp.load("C:\\trabalho.pl");
      String queryS = null;
      HashMap map = new HashMap();
      Query query = null;
      
      do{
            queryS=menuPrincipal();
            if(queryS.equals("erro")==false){
            map = new HashMap();
            query = sp.openPrologQuery(queryS,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            }
        }while(true);
    }
}