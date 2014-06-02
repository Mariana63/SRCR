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
    
    public static String menuAnimal() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n######################## Animal ###########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Classe                                            #");
	System.out.println("#   2 - Regime                                            #");
	System.out.println("#   3 - Reprodução                                        #");
	System.out.println("#   4 - Grupo                                             #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(animal,classe(X),RESPOSTA).";
                break;
            case "2":
                query="p(animal,regime(X),RESPOSTA).";
                break;
            case "3":
                query="p(animal,reproducao(X),RESPOSTA).";
                break;
            case "4":
                query="p(animal,grupo(X),RESPOSTA).";
                break;   
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuMamifero() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n####################### Mamifero ##########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Locomoção                                         #");
	System.out.println("#   2 - Grupo                                             #");
	System.out.println("#   3 - Revestimento                                      #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(mamifero,locomocao(X),RESPOSTA).";
                break;
            case "2":
                query="p(mamifero,grupo(X),RESPOSTA).";
                break;
            case "3":
                query="p(mamifero,revestimento(X),RESPOSTA).";
                break;   
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuAve() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n########################## Ave ############################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Locomoção                                         #");
	System.out.println("#   2 - Classe                                            #");
	System.out.println("#   3 - Revestimento                                      #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(ave,locomocao(X),RESPOSTA).";
                break;
            case "2":
                query="p(ave,classe(X),RESPOSTA).";
                break;
            case "3":
                query="p(ave,revestimento(X),RESPOSTA).";
                break;   
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuBatman() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n######################## Batman ###########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Cor                                               #");
	System.out.println("#   2 - Alimento                                          #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(batman,cor(X),RESPOSTA).";
                break;
            case "2":
                query="p(batman,alimento(X),RESPOSTA).";
                break; 
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuAvestruz() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n####################### Avestruz ##########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Locomoção                                         #");
	System.out.println("#   2 - Cor                                               #");
	System.out.println("#   3 - Reprodução                                        #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(avestruz,locomocao(X),RESPOSTA).";
                break;
            case "2":
                query="p(avestruz,cor(X),RESPOSTA).";
                break;
            case "3":
                query="p(avestruz,reproducao(X),RESPOSTA).";
                break;   
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuMorcego() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n####################### Morcego ###########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Locomoção                                         #");
	System.out.println("#   2 - Cor                                               #");
	System.out.println("#   3 - Revestimento                                      #");
	System.out.println("#   4 - Alimento                                          #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(morcego,locomocao(X),RESPOSTA).";
                break;
            case "2":
                query="p(morcego,cor(X),RESPOSTA).";
                break;
            case "3":
                query="p(morcego,revestimento(X),RESPOSTA).";
                break;
            case "4":
                query="p(morcego,alimento(X),RESPOSTA).";
                break;     
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuOrni() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n#################### Ornitorrinco #########################");
	System.out.println("#                                                         #");
    	System.out.println("#   Qual a questão:                                       #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Cor                                               #");
	System.out.println("#   2 - Reprodução                                        #");
	System.out.println("#   3 - Revestimento                                      #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query="p(ornitorrinco,cor(X),RESPOSTA).";
                break;
            case "2":
                query="p(ornitorrinco,reproducao(X),RESPOSTA).";
                break;
            case "3":
                query="p(ornitorrinco,revestimento(X),RESPOSTA).";
                break;    
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
    public static String menuPersonalizado() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n################ Pedido Personalizado #####################");
	System.out.println("#                                                         #");
    	System.out.println("#   Efetue o pedido:                                      #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        
        query=opt;
        return query;
    }
    
    public static String menuQuestao() throws IOException, ClassNotFoundException {
	String query=null;
        System.out.println("\n######################## PEDIDOS ##########################");
	System.out.println("#                                                         #");
    	System.out.println("#   De que agente pretende fazer o pedido:                #");
    	System.out.println("#                                                         #");
	System.out.println("#   1 - Animal                                            #");
	System.out.println("#   2 - Mamifero                                          #");
	System.out.println("#   3 - Ave                                               #");
	System.out.println("#   4 - Batman                                            #");
	System.out.println("#   5 - Avestruz                                          #");
	System.out.println("#   6 - Morcego                                           #");
	System.out.println("#   7 - Ornitorrinco                                      #");
	System.out.println("#   8 - Pedido personalizado                              #");
	System.out.println("#                                                         #");
	System.out.println("###########################################################");
    	String opt = in.next();
        switch (opt) {
            case "1":
                query=menuAnimal();
                break;
            case "2":
                query=menuMamifero();
                break;
            case "3":
                query=menuAve();
                break;
            case "4":
                query=menuBatman();
                break;
            case "5":
                query=menuAvestruz();
                break;
            case "6":
                query=menuMorcego();
                break;
            case "7":
                query=menuOrni();
                break;
            case "8":
                query=menuPersonalizado();
                break; 
            default:
                System.out.println("Opcão inválida!");
                query="erro";
                break;
        }
        return query;
    }
    
  public static String menuServidor() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n############################################################");
	System.out.println("#                                                          #");
        System.out.println("# Digite o server address para se conectar                 #");
        System.out.println("#                                                          #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
        query="linda_client('maleite-pc':'"+opt+"').";
        
        return query;
    }
  
  public static String menuInicial() throws IOException, ClassNotFoundException {
	String query=null;
        
        System.out.println("\n############################################################");
	System.out.println("#                                                          #");
        System.out.println("# Escolha o ficheiro que pretende abrir:                   #");
        System.out.println("#                                                          #");
	System.out.println("############################################################");
    	String opt = in.next();
   	
        query=opt;
        
        return query;
    }
  
  public static void main(String[] argv) throws SPException, IOException, Exception {
  
      SICStus sp; //, spAnimal, spAve, spAvestruz, spBatman, spInterface, spMamifero, spMorcego, spOrni;
      String server; //, nomeFicheiro;
      //nomeFicheiro = menuInicial();
      server = menuServidor();  
      sp = new SICStus(argv,null);
      /**spAnimal = new SICStus(argv,null);
      spAve = new SICStus(argv,null);
      spAvestruz = new SICStus(argv,null);
      spBatman = new SICStus(argv,null);
      spInterface = new SICStus(argv,null);
      spMamifero = new SICStus(argv,null);
      */
      
      sp.load("C:\\interface.pl");
      /**spAnimal.load("C:\\animal.pl");
      spAve.load("C:\\ave.pl");
      spAvestruz.load("C:\\avestruz.pl");
      spBatman.load("C:\\batman.pl");
      spInterface.load("C:\\interface.pl");
      spMamifero.load("C:\\mamifero.pl");
      spMorcego.load("C:\\morcego.pl");
      spOrni.load("C:\\ornitorrinco.pl");
      */
      String queryS = null;
      HashMap map = new HashMap();
      Query query = null;
      int vez=0;
      do{   if(vez==0){
            map = new HashMap();
            query = sp.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            /**map = new HashMap();
            query = spAnimal.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spAve.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spAvestruz.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spBatman.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spMamifero.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spMorcego.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            map = new HashMap();
            query = spOrni.openPrologQuery(server,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }*/
            vez++;
            }
            else{
            queryS=menuQuestao();
            //System.out.println(queryS);
            if(queryS.equals("erro")==false){
            map = new HashMap();
            query = sp.openPrologQuery(queryS,map);
                while (query.nextSolution()) {
                    System.out.println(map.toString());
                }
            }
            }
        }while(true);
    }
}