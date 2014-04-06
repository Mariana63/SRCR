/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package srcr;

import java.io.IOException;
import java.util.ArrayList;
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
  

    public static String menuConjunto() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n################ Distancia entre cidades ##################");
	System.out.println("#                                                         #");
    	System.out.println("#   Para cada cidade que pretenda passar, insira o seu    #");
        System.out.println("#   nome (exemplo: Braga), seguido de ENTER.              #");
        System.out.println("#   No caso de haver espaços, utilize o caracter '_' em   #");
        System.out.println("#   detrimento destes (exemplo: Viana_Castelo).           #");
        System.out.println("#   Assim que tenha  terminado  o trajecto pretendido,    #");
        System.out.println("#   escreva a palavra FIM, mais ENTER.                    \n#");
        in.nextLine();
        String cidade="";
        String token="";
        ArrayList<String> cidades = new ArrayList<String> (); 
        int vez=0;
        do{
            if(vez==0){
                System.out.println("#   Insira o nome da cidade de partida:                   #");
                cidade = in.nextLine();
                if((cidade.equals("FIM")==true)||(cidade.equals("Fim")==true)||(cidade.equals("fim")==true)){
                    token="]";
                    vez++;
                    break;
                }
                else {
                token="'"+cidade+"'";
                cidades.add(token);
                vez++;}
                }
            else {
                System.out.println("\n#   Insira o nome da "+(vez+1)+"ª cidade pretendida:                #");
                System.out.println("#        (ou \"Fim\" para terminar o conjunto)              #");
                cidade = in.nextLine();
                if((cidade.equals("FIM")==true)||(cidade.equals("Fim")==true)||(cidade.equals("fim")==true)){
                    token="]";
                    vez++;
                    break;
                }
                else {
                token="'"+cidade+"'";
                cidades.add(token);
                vez++;}
                }
        }while((cidade.equals("FIM")==false)||(cidade.equals("Fim")==false)||(cidade.equals("fim")==false)); 
        
        System.out.println("#                                                         #");
	System.out.println("###########################################################");
        String lista = cidades.toString();
        //System.out.println(lista);
        query="conjuntoCusto("+lista+",DISTANCIA,CONJUNTO).";
        
        return query;
    }
    
    public static String menuSequencia() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n################ Distancia entre cidades ##################");
	System.out.println("#                                                         #");
    	System.out.println("#   Para cada cidade que pretenda passar, insira o seu    #");
        System.out.println("#   nome (exemplo: Braga), seguido de ENTER.              #");
        System.out.println("#   No caso de haver espaços, utilize o caracter '_' em   #");
        System.out.println("#   detrimento destes (exemplo: Viana_Castelo).           #");
        System.out.println("#   Assim que tenha  terminado  o trajecto pretendido,    #");
        System.out.println("#   escreva a palavra FIM, mais ENTER.                    \n#");
        in.nextLine();
        String cidade="";
        String token="";
        ArrayList<String> cidades = new ArrayList<String> (); 
        int vez=0;
        do{
            if(vez==0){
                System.out.println("#   Insira o nome da cidade de partida:                   #");
                cidade = in.nextLine();
                if((cidade.equals("FIM")==true)||(cidade.equals("Fim")==true)||(cidade.equals("fim")==true))
                    break;
                else {
                token="'"+cidade+"'";
                cidades.add(token);
                vez++;}
                }
            else {
                System.out.println("\n#   Insira o nome da "+(vez+1)+"ª cidade pretendida:                #");
                System.out.println("#    (ou \"Fim\" para terminar o conjunto ou sequencia)     #");
                cidade = in.nextLine();
                if((cidade.equals("FIM")==true)||(cidade.equals("Fim")==true)||(cidade.equals("fim")==true))
                    break;
                else {
                token="'"+cidade+"'";
                cidades.add(token);
                vez++;}
                }
        }while((cidade.equals("FIM")==false)||(cidade.equals("Fim")==false)||(cidade.equals("fim")==false)); 
        
        System.out.println("#                                                         #");
	System.out.println("###########################################################");
        String lista = cidades.toString();
        //System.out.println(lista);
        query="sequenciaMinima("+lista+",DISTANCIA).";
        
        return query;
    }
    
    public static String menuCidadeRegiao() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n################### Cidades por região ####################");
	System.out.println("#                                                         #");
    	System.out.println("#   De que zona do país pretende ver                      #");
    	System.out.println("#                                                         #");
	System.out.println("#   Prima:                                                #");
	System.out.println("#            N - Norte                                    #");
	System.out.println("#            C - Centro                                   #");
	System.out.println("#            S - Sul                                      #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "N":
            case "n":
                query="zona(CIDADE,'Norte').";
                break;
            case "C":
            case "c":
                query="zona(CIDADE,'Centro').";
                break;
            case "S":
            case "s":
                query="zona(CIDADE,'Sul').";
                break;
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuPercursos() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n################# Distâncias de Percursos #################");
	System.out.println("#                                                         #");
        System.out.println("#   1 - Ligações entre cidades                            #");
    	System.out.println("#   2 - Conjunto de pontos a percorrer                    #");
    	System.out.println("#   3 - Distância mínima para uma sequência               #");
	System.out.println("#                                                         #");
	System.out.println("#   Escolha uma opção:                                    #");
	System.out.println("###########################################################");
    	String opt = in.next();
   	
        if(opt.equals("1"))
                { query="ligacao(ÍNICIO,FIM,DISTANCIA)."; } else
        if(opt.equals("2"))
                { query=menuConjunto(); } else
    	if(opt.equals("3"))
                { query=menuSequencia(); }
        else { System.out.println("Opcão inválida!");
               query="erro"; }
                
        return query;
    }
    
    public static String menuInfoCidades() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n########### Informações dos pontos de entrega  ############");
	System.out.println("#                                                         #");
    	System.out.println("#   1 - Listar todos os pontos de entrega do país         #");
        System.out.println("#   2 - Coordenadas cartesianas                           #");
    	System.out.println("#   3 - Cidades por região                                #");
        System.out.println("#   4 - Tipo de entrega entre cidades                     #");
	System.out.println("#                                                         #");
	System.out.println("#   Escolha uma opção:                                    #");
	System.out.println("###########################################################");
    	String opt = in.next();
   		
        if(opt.equals("1"))
                { query="servTO(LOJA)."; } else
    	if(opt.equals("2"))
                { query="localizacao(CIDADE,COORDENADAS)."; } else
        if(opt.equals("3"))
                { query=menuCidadeRegiao(); } else	
        if(opt.equals("4"))
                { System.out.println("\ntipo: \n 0 - Normal\n 1 - Express\n");
                    query="tipoEntrega(CIDADE,TIPO)."; } 
        else { System.out.println("Opcão inválida!");
               query="erro";
             }
                
        return query;
    }
    
    public static String menuPrincipal() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n################ Transporte de Mercadorias #################");
	System.out.println("#                                                          #");
    	System.out.println("#   1 - Informações dos pontos de entrega                  #");
    	System.out.println("#   2 - Percursos entre cidades                            #");
        System.out.println("#                                                          #");
	System.out.println("#   0 - Sair                                               #");
	System.out.println("#                                                          #");
	System.out.println("#   Escolha uma opção:                                     #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
        if(opt.equals("1"))
                { query=menuInfoCidades(); 
                } else	
        if(opt.equals("2"))
                { query=menuPercursos(); } else
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

      sp.load("C:\\tudo.pl");
      String queryS = null;
      HashMap map = new HashMap();
      Query query = null;
      
      do{   queryS=menuPrincipal();
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