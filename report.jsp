<%@ page import="report.Report" %>
<%@ page import="report.Anagrafica" %>
<%@ page import="report.Preferenze" %>
<%@ page import="report.Valutazioni" %>
<%@ page import="report.Confronti" %>
<%@ page import="report.Contatori" %>
<%@ page import="report.MedieMetriche" %>
<%@ page import="report.Sistema" %>
<%@ page import="classi.Math" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.logging.Logger" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Report</title>
	<link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">		 Report</a>
	</div>
	</nav>
	<%  Report.leggiLog();%>

<div class="container-fluid bg-light">
 
<p align="center">6.3.1 <b>ANALISI dell'UTENZA</b></p>	
   	<%
	///////////////////////////////ANAGRAFICA///////////////////////
	//1) anagrafiche utenti
    HashMap<String, HashMap<String, Integer>> anagrafica = null;	
    anagrafica = Anagrafica.infoUtenti();
    int numeroUtenti = Report.utenti.size();
    %>
            
     <table border="1" align="center">
          <tr>
              <td colspan="5" align="center"><h5>Statistiche utenti</h5></td>
          </tr>
          <tr>
              <td colspan="5" align="center"><b>Età</b></td>
          </tr>
          <tr>
              <td width="80" align="center"> < 18</td>
              <td width="80" align="center">18 - 25</td>
              <td width="80" align="center">26 - 35</td>
              <td width="80" align="center">36 - 50</td>
              <td width="80" align="center"> > 50</td>
          </tr>
          <tr>
              <td align="center"><%out.println(Math.perc(anagrafica.get("Eta").get("<18"), numeroUtenti));%></td>
              <td align="center"><%out.println(Math.perc(anagrafica.get("Eta").get("18-25"), numeroUtenti));%></td>
              <td align="center"><%out.println(Math.perc(anagrafica.get("Eta").get("26-35"), numeroUtenti));%></td>
              <td align="center"><%out.println(Math.perc(anagrafica.get("Eta").get("36-50"), numeroUtenti));%></td>
              <td align="center"><%out.println(Math.perc(anagrafica.get("Eta").get(">50"), numeroUtenti));%></td>
          </tr>

          <tr>
              <td colspan="5" align="center"><b>Genere</b></td>
          </tr>
          <tr>
              <td align="center" colspan="2">Uomo</td>
              <td align="center" colspan="3">Donna</td>
          </tr>
          <tr>
              <td align="center" colspan="2"><%out.println(Math.perc(anagrafica.get("Genere").get("uomo"), numeroUtenti));%></td>
              <td align="center" colspan="3"><%out.println(Math.perc(anagrafica.get("Genere").get("donna"), numeroUtenti));%></td>
          </tr>
          <tr>
              <td colspan="5" align="center"><b>Titolo di studio</b></td>
          </tr>
          <tr>
              <td  align="center">Diploma Scuola Superiore</td>
              <td align="center">Laurea Triennale</td>
              <td  align="center">Laurea Magistrale</td>
              <td  align="center">PhD</td>
              <td  align="center">Altro</td>
          </tr>
          <tr>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Titoli di studio").get("Diploma Scuola superiore"), numeroUtenti));%></td>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Titoli di studio").get("Laurea Triennale"), numeroUtenti));%></td>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Titoli di studio").get("Laurea Magistrale"), numeroUtenti));%></td>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Titoli di studio").get("Dottorato di Ricerca"), numeroUtenti));%></td>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Titoli di studio").get("Altro"), numeroUtenti));%></td>
          </tr>

          <tr>
              <td colspan="5" align="center"><b>Uso Recommender System</b></td>
          </tr>
          <tr>
              <td align="center" colspan="3">Sì</td>
              <td align="center" colspan="2">No</td>
          </tr>
          <tr>
              <td align="center" colspan="3"><%out.print(Math.perc(anagrafica.get("Uso Rec Sys").get("si"), numeroUtenti));%></td>
              <td align="center" colspan="2"><%out.println(Math.perc(anagrafica.get("Uso Rec Sys").get("no"), numeroUtenti));%></td>
          </tr>

          <tr>
              <td colspan="5" align="center"><b>Frequenza film settimanali</b></td>
          </tr>
          <tr>
              <td align="center">0-1 volta</td>
              <td align="center" colspan="2">2-4 volte</td>
              <td align="center" colspan="2">5-7 volte</td>
          </tr>
          <tr>
              <td align="center"><%out.print(Math.perc(anagrafica.get("Frequenze uscite").get("0-1 volta"), numeroUtenti));%></td>
              <td align="center" colspan="2"><%out.print(Math.perc(anagrafica.get("Frequenze uscite").get("2-4 volte"), numeroUtenti));%></td>
              <td align="center" colspan="2"><%out.print(Math.perc(anagrafica.get("Frequenze uscite").get("5-7 volte"), numeroUtenti));%></td>
          </tr>
      </table>

     <br>
<br> 
 
<p align="center"> 6.1 <b>CONTATORI</b></p>
  
	 <p align="center">
	 	<br>
     	<b >Numero Utenti</b>: <%out.println(Report.utenti.size());%> 
     	<br>
     	<b>Numero Valutazioni 1</b>: <%out.println(Report.valutazioni1.size());%> 
     	<br>       
     	<b>Numero Valurazioni 3</b>: <%out.println(Report.valutazioni3.size());%> 
     	<br>
     	<b>Numero Valutazioni 4</b>: <%out.println(Report.valutazioni4.size());%> 
     	<br><br>
 	 </p>   

 		
	 <%             
     //////////////////////////CONTATORI/////////////////
     //NUMERO CONFIGURAZIONI elaborate x ogni tipo (uni, bi, unibi);
     HashMap<String, Integer> contatoriConfig = null;		
     contatoriConfig = Contatori.contatoriConfigurazioni();
     %>
     
 	  <table align="center" border=1>
         <tr>
             <td align="center" colspan="3" width="200"><h5>Contatori CONFIGURAZIONI</h5></td>
         </tr>

         <tr>
             <td align="center" width="120">
                 Numero UNIGRAMMI
             </td>
             <td align="center" width="120">
                 Numero BIGRAMMI
             </td>
             <td align="center" width="120">
                 Numero UNIBIGRAMMI
             </td >
         </tr>
         <tr>
             <td align="center" width="120">
                 <%out.println(contatoriConfig.get("unigrammi"));%>
             </td>
             <td align="center" width="120">
                 <%out.println(contatoriConfig.get("bigrammi"));%>
             </td>
             <td align="center" width="120">
                 <%out.println(contatoriConfig.get("unibigrammi"));%>
             </td >
         </tr>

      </table>
		
	 <br><br>
	
  	 
	 <%  
     //NUMERO TECNICHE ELABORATE
     HashMap<String, Integer> contatoriTecnica= null;		
     contatoriTecnica = Contatori.contatoriTenica();
     %>
 	  <table align="center" border=1>
         <tr>
             <td align="center" colspan="3" width="200"><h5>Contatori TECNICHE</h5></td>
         </tr>

         <tr>
             <td align="center" width="120">
                 Numero PMI
             </td>
             <td align="center" width="120">
                 Numero NORMALE
             </td>
         </tr>
         <tr>
             <td align="center" width="120">
                 <%out.println(contatoriTecnica.get("pmi"));%>
             </td>
             <td align="center" width="120">
                 <%out.println(contatoriTecnica.get("normale"));%>
             </td>
         </tr>

      </table>
		
	 <br><br>
	
	
	 <%             
     //contatori NUMERO CONTESTI selezionati dagli utenti
     HashMap<Integer, Integer> contatoriContesti = 	null;		
     contatoriContesti = 	Contatori.contatoriNumeroContesti();
     %> 

      <table align="center" border=1>
          <tr>
              <td align="center" colspan="5" width="200"><h5>Contatori configurazioni</h5></td>
          </tr>

          <tr>
              <td align="center" width="120">
                  1 contesto
              </td>
              <td align="center" width="120">
                  2 contesti
              </td>
              <td align="center" width="120">
                  3 contesti
              </td>

          </tr>
          <tr>
              <td align="center" width="120">
                  <%out.println(contatoriContesti.get(1));%>
              </td>
              <td align="center" width="120">
                  <%out.println(contatoriContesti.get(2));%>
              </td>
              <td align="center" width="120">
                  <%out.println(contatoriContesti.get(3));%>
              </td >

          </tr>

      </table>

     <br><br>
				
	     
    



<p align="center">--------------------------- 6.3.3 <b>ESPERIMENTO 1 -----------------------------------</b></p>

 	 <%          
 	 /////////////////////////VALUTAZIONI////////////////////  
 	 //5) valutazioni METRICHE ASSOLUTE sulle spiegazioni CENTROIDE
     HashMap<String, HashMap<String, Double>>  valutazAssolC = null;
     valutazAssolC = 	Valutazioni.valutazioniAssoluteCentroide();
     %>
      <!--   
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Valutazioni Assolute CENTROIDE</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Unigrammi</td>
              <td align="center">Bigrammi</td>
              <td align="center">Unigrammi + Bigrammi</td>
          </tr>

          <tr>
              <td align="center">Trasparenza</td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("bigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unibigrammi").get("Trasparenza")));%></td>
          </tr>
          <tr>
              <td align="center">Persuasione</td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("bigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unibigrammi").get("Persuasione")));%></td>
          </tr>
          <tr>
              <td align="center">Coinvolgimento</td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("bigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unibigrammi").get("Coinvolgimento")));%></td>
          </tr>
          <tr>
              <td align="center">Fiducia</td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("bigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolC.get("unibigrammi").get("Fiducia")));%></td>
          </tr>

      </table>

     <br>
	 -->  		
	 <%          
     //valutazioni METRICHE ASSOLUTE sulle spiegazioni FRASI SINGOLE
     HashMap<String, HashMap<String, Double>> valutazAssolS = null;	
     valutazAssolS = 	Valutazioni.valutazioniAssoluteSingole();
     %>
            
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Valutazioni Assolute</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Unigrammi</td>
              <td align="center">Bigrammi</td>
              <td align="center">Uni-bigrammi</td>
          </tr>

          <tr>
              <td align="center">Trasparenza</td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("bigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unibigrammi").get("Trasparenza")));%></td>
          </tr>
          <tr>
              <td align="center">Persuasione</td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("bigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unibigrammi").get("Persuasione")));%></td>
          </tr>
          <tr>
              <td align="center">Coinvolgimento</td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("bigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unibigrammi").get("Coinvolgimento")));%></td>
          </tr>
          <tr>
              <td align="center">Fiducia</td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("bigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolS.get("unibigrammi").get("Fiducia")));%></td>
          </tr>

      </table>

     <br> <br>
	 
	<%          
     //valutazioni METRICHE ASSOLUTE sulle spiegazioni NORMALE
     HashMap<String, HashMap<String, Double>> valutazAssolN = null;	
     valutazAssolN = 	Valutazioni.valutazioniAssoluteNormale();
     %>
            
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Valutazioni Assolute Matrici</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Unigrammi</td>
              <td align="center">Bigrammi</td>
              <td align="center">Uni-bigrammi</td>
          </tr>

          <tr>
              <td align="center">Trasparenza</td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("bigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unibigrammi").get("Trasparenza")));%></td>
          </tr>
          <tr>
              <td align="center">Persuasione</td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("bigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unibigrammi").get("Persuasione")));%></td>
          </tr>
          <tr>
              <td align="center">Coinvolgimento</td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("bigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unibigrammi").get("Coinvolgimento")));%></td>
          </tr>
          <tr>
              <td align="center">Fiducia</td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("bigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolN.get("unibigrammi").get("Fiducia")));%></td>
          </tr>

      </table>

     <br>
     
     <%          
     //valutazioni METRICHE ASSOLUTE sulle spiegazioni PMI
     HashMap<String, HashMap<String, Double>> valutazAssolP = null;	
     valutazAssolP = 	Valutazioni.valutazioniAssolutePMI();
     %>
            
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Valutazioni Assolute PMI</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Unigrammi</td>
              <td align="center">Bigrammi</td>
              <td align="center">Uni-bigrammi</td>
          </tr>

          <tr>
              <td align="center">Trasparenza</td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("bigrammi").get("Trasparenza")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unibigrammi").get("Trasparenza")));%></td>
          </tr>
          <tr>
              <td align="center">Persuasione</td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("bigrammi").get("Persuasione")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unibigrammi").get("Persuasione")));%></td>
          </tr>
          <tr>
              <td align="center">Coinvolgimento</td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("bigrammi").get("Coinvolgimento")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unibigrammi").get("Coinvolgimento")));%></td>
          </tr>
          <tr>
              <td align="center">Fiducia</td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("bigrammi").get("Fiducia")));%></td>
              <td align="center"><%out.println(Math.dec(valutazAssolP.get("unibigrammi").get("Fiducia")));%></td>
          </tr>

      </table>

     <br>
	
	
<br><br>
<p align="center">------------------- 6.3.4 <b>ESPERIMENTO 2 ------------------------</b></p>

	
     <%
   	//-->preferenza tra FRAMEWORK e BASELINE;
   	HashMap<String, Double> preferenzeCSgen = null;
    preferenzeCSgen = 	Preferenze.centroideVSSingoleGenerale();		
     %>
      
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="360"><h5>Framework vs Baseline non distrib.</h5></td>
          </tr>
          <tr>
              <td align="center" width="120">Framework</td>
              <td align="center" width="120">Baseline non distrib.</td>
              <td align="center" width="120">Indifferente</td>
          </tr>
          <tr>
              <td align="center"><%out.println(Math.perc(preferenzeCSgen.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSgen.get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSgen.get("indifferente")));%></td>
          </tr>
      </table>

     <br><br>
		
		
	<%
     //2) preferenza tra FRAMEWORK e BASELINE  caso normale
   	HashMap<String, Double> preferenzeCSNormale = null;
   	preferenzeCSNormale = 	Preferenze.centroideVSSingoleNormale();		
     %>
      
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="360"><h5>Framework vs Baseline non distrib. - Matrici</h5></td>
          </tr>
          <tr>
              <td align="center" width="120">Framework</td>
              <td align="center" width="120">Baseline non distrib.</td>
              <td align="center" width="120">Indifferente</td>
          </tr>
          <tr>
              <td align="center"><%out.println(Math.perc(preferenzeCSNormale.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSNormale.get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSNormale.get("indifferente")));%></td>
          </tr>
      </table>

     <br>
     
     
     
     
     <%
   	//-->preferenza tra FRAMEWORK e BASELINE DISTRIBUZIONALE caso PMI
   	HashMap<String, Double> preferenzeCSPMI = null;
   	preferenzeCSPMI = 	Preferenze.centroideVSSingolePMI();		
     %>
      
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="360"><h5>Framework vs Baseline non distrib. - PMI</h5></td>
          </tr>
          <tr>
              <td align="center" width="120">Framework</td>
              <td align="center" width="120">Baseline non distrib.</td>
              <td align="center" width="120">Indifferente</td>
          </tr>
          <tr>
              <td align="center"><%out.println(Math.perc(preferenzeCSPMI.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSPMI.get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCSPMI.get("indifferente")));%></td>
          </tr>
      </table>

     <br><br><br>

		
		
							
  	 <%
     //3) preferenze tra centroide e frasi singole con configurazioni di lemmi
	 //-->preferenze tra FRAMEWORK e BASELINE DISTRIBUZIONALE con CONFIGURAZIONI LEMMI; 
	 HashMap<String, HashMap<String, Double>> preferenzeCS = null;
     preferenzeCS = Preferenze.centroideVSSingolePreferenze();		
     %>
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Framework vs Baseline non distrib.- Configurazioni</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Framework</td>
              <td align="center">Baseline non distrib.</td>
              <td align="center">Indifferente</td>
          </tr>

          <tr>
              <td align="center">Unigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unigrammi").get("indifferenti")));%></td>
          </tr>
          <tr>
              <td align="center">Bigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("bigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("bigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("bigrammi").get("indifferenti")));%></td>
          </tr>
          <tr>
              <td align="center">Uni-bigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unibigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unibigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS.get("unibigrammi").get("indifferenti")));%></td>
          </tr>

      </table>

     <br><br>
     <br><br>           
     <%            
     //////////////////////////CONFRONTI/////////////////
     //7) confronto valutazioni metriche centroide e frasi singole;
     //-->confronto metriche FRAMEWORK VS BASELINE DISTRIBUZIONALE
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrCS = null;
     confrMetrCS = Confronti.centroideVSSingoleMetriche();
     %>
      <table align="center" border="1">
          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline non distrib.- Metriche e configurazioni</h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
          </tr>

          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("baselineDistr").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("baselineDistr").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("bigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCS.get("unibigrammi").get("baselineDistr").get("Fiducia")));%></td>
          </tr>

      </table>
	<br> 
    <%            
     //////////////////////////CONFRONTI/////////////////
     //7) confronto valutazioni metriche centroide e frasi singole;
     //-->confronto metriche FRAMEWORK VS BASELINE DISTRIBUZIONALE, NORMALE
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrCSNorm = null;
     confrMetrCSNorm = Confronti.centroideVSSingoleMetricheNormale();
     %>
      <table align="center" border="1">
          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline non distrib.- Metriche e configurazioni - Matrice</h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
          </tr>

          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("baselineDistr").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("baselineDistr").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("bigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSNorm.get("unibigrammi").get("baselineDistr").get("Fiducia")));%></td>
          </tr>

      </table>

     <br>        
     
    <%            
     //////////////////////////CONFRONTI/////////////////
     //7) confronto valutazioni metriche centroide e frasi singole;
     //-->confronto metriche FRAMEWORK VS BASELINE DISTRIBUZIONALE
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrCSPMI = null;
     confrMetrCSPMI = Confronti.centroideVSSingoleMetrichePMI();
     %>
      <table align="center" border="1">
          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline non distrib.- Metriche e configurazioni - PMI</h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
              <td align="center">Framework</td>
              <td align="center">Baseline non contest.</td>
          </tr>

          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("baselineDistr").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("baselineDistr").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("baselineDistr").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("baselineDistr").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("baselineDistr").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("bigrammi").get("baselineDistr").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrCSPMI.get("unibigrammi").get("baselineDistr").get("Fiducia")));%></td>
          </tr>

      </table>

    <br>              
 
					
	<%
    ///////////////////////////METRICHE//////////////////
    //13) MEDIE metriche per CONTESTI - FRAMEWORK VS BASELINE DISTRIBUZIONALE
    HashMap<Integer, HashMap<String, HashMap<String, Double>>> medieCont = 	null;
    medieCont = 	MedieMetriche.medieMetrichePerContesti();
    %>
    <!--  
     <table align="center" border=1>
         <tr>
             <td align="center" colspan="9" width="200"><h5>METRICHE FRAMEWORK VS BASELINE DISTRIBUZIONALE per CONTESTO (NON FUNZ)</h5></td>
         </tr>

         <tr>
             <td align="center">
                 Metriche
             </td>

             <td colspan="2" align="center">
                 Trasparenza
             </td>

             <td colspan="2" align="center">
                 Coinvolgimento
             </td>

             <td colspan="2" align="center">
                 Persuasione
             </td>

             <td colspan="2" align="center">
                 Fiducia
             </td>
         </tr>

         <tr>
             <td align="center" width="100">
                 Contesti
             </td>

             <td align="center" width="100">
                 Framework
             </td>
             <td align="center" width="100">
                 Baseline Distrib
             </td>

             <td align="center" width="100">
                 Framework
             </td>
             <td align="center" width="100">
                 Baseline Distrib
             </td>

             <td align="center" width="100">
                 Framework
             </td>
             <td align="center" width="100">
                 Baseline Distrib
             </td>

             <td align="center" width="100">
                 Framework
             </td>
             <td align="center" width="100">
                 Baseline Distrib
             </td>
         </tr>

         <%

             try{
                 HashMap<Integer, String> contesti = new HashMap<Integer, String>();

                 contesti.put(1, "Alta Attenzione");
                 contesti.put(2, "Bassa Attenzione");
                 contesti.put(3, "Coppia");
                 contesti.put(4, "Amici");
                 contesti.put(5, "Bambini");
                 contesti.put(6, "Buon umore");
                 contesti.put(7, "Cattivo umore");

                 for (int cont=1; cont<=7; cont++){
                     out.println("<tr><td align=\"center\">" +
                             contesti.get(cont) +
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("centroide").get("trasparenza"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("singole").get("trasparenza"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("centroide").get("persuasione"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("singole").get("persuasione"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("centroide").get("coinvolgimento"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("singole").get("coinvolgimento"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("centroide").get("fiducia"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieCont.get(cont).get("singole").get("fiducia"))+
                             "</td> </tr>");
                 }
             } catch (Exception ecc){
                 ecc.printStackTrace();
             }
         %>

     </table>
	
    
     -->
                

     
     
     
     
     <%
     //8) preferenze tra sistema e baseline distribuz in base al numero di contesti;
     //--> SISTEMA VS BASELINE DISTRIBUZIONALE in base a NUMERO CONTESTI;
     HashMap<Integer, HashMap<String, Double>> confrNumContCS = null;	
     confrNumContCS = 	Confronti.centroideVSsingoleNumContesti();
     %>
<!--                 
      <table align="center" border=1>
          <tr>
              <td align="center" colspan="9" width="200"><h5>FRAMEWORK VS BASELINE DISTRIBUZIONALE - NUMERO CONTESTI</h5></td>
          </tr>

          <tr>
              <td align="center" width="120">Num. contesti</td>
              <td align="center" width="120">FRAMEWORK</td>
              <td align="center" width="120">BASELINE DISTRIBUZIONALE</td>
              <td align="center" width="120">Indifferente</td>
          </tr>

          <tr>
              <td align="center" width="120">1</td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(1).get("sistema")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(1).get("baselineDistr")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(1).get("Indifferente")));%></td>
          </tr>
          <tr>
              <td align="center" width="120">2</td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(2).get("sistema")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(2).get("baselineDistr")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(2).get("Indifferente")));%></td>
          </tr>
          <tr>
              <td align="center" width="120">3</td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(3).get("sistema")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(3).get("baselineDistr")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrNumContCS.get(3).get("Indifferente")));%></td>
          </tr>

      </table>

     <br><br>       
  -->                        

<br><br>                
<p align="center">----------------------- 6.3.5 <b>ESPERIMENTO 3 ----------------------------------</b></p>

	 
	 <%
     /////////////////////////PREFERENZE//////////////////
     //preferenza tra FRAMEOWRK e BASELINE PUCARIELLO Generale
     HashMap<String, Double> preferenzeSB = null;		
     preferenzeSB = Preferenze.sistemaVSBaseline();
     %>       		
            		
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="200"><h5>Framework vs Baseline review</h5></td>
          </tr>
          <tr>
          	  <td colspan="1" align="center" width="100">Framework</td>
              <td colspan="1" align="center" width="100">Baseline review</td>
              <td colspan="1" align="center" width="100">Indifferente</td>
          </tr>
          <tr>   
              <td align="center"><%out.println(Math.perc(preferenzeSB.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSB.get("baseline")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSB.get("indifferente")));%></td>
          </tr>
      </table>


     <br><br>   
	 
	 <%
     /////////////////////////PREFERENZE//////////////////
     //preferenza tra FRAMEOWRK e 4) BASELINE PUCARIELLO
     HashMap<String, Double> preferenzeSBNormale = null;		
     preferenzeSBNormale = Preferenze.sistemaVSBaselineNormale();
     %>       		
            		
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="200"><h5>Framework vs Baseline review - Matrici</h5></td>
          </tr>
          <tr>
          	  <td colspan="1" align="center" width="100">Framework</td>
              <td colspan="1" align="center" width="100">Baseline review</td>
              <td colspan="1" align="center" width="100">Indifferente</td>
          </tr>
          <tr>   
              <td align="center"><%out.println(Math.perc(preferenzeSBNormale.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBNormale.get("baseline")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBNormale.get("indifferente")));%></td>
          </tr>
      </table>


     <br>  
     
     <%
     /////////////////////////PREFERENZE//////////////////
     //preferenza tra FRAMEOWRK e 4) BASELINE PUCARIELLO
     HashMap<String, Double> preferenzeSBPMI = null;		
     preferenzeSBPMI = Preferenze.sistemaVSBaselinePMI();
     %>       		
            		
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="3" width="200"><h5>Framework vs Baseline review - PMI</h5></td>
          </tr>
          <tr>
          	  <td colspan="1" align="center" width="100">Framework</td>
              <td colspan="1" align="center" width="100">Baseline review</td>
              <td colspan="1" align="center" width="100">Indifferente</td>
          </tr>
          <tr>   
              <td align="center"><%out.println(Math.perc(preferenzeSBPMI.get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBPMI.get("baseline")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBPMI.get("indifferente")));%></td>
          </tr>
      </table>


     <br><br><br>  
	 
	  <%
     //3) preferenze tra centroide e frasi singole con configurazioni di lemmi
	 //-->preferenze tra FRAMEWORK e BASELINE DISTRIBUZIONALE con CONFIGURAZIONI LEMMI; 
	 HashMap<String, HashMap<String, Double>> preferenzeCS2 = null;
     preferenzeCS2 = Preferenze.centroideVSSingolePreferenze2();		
     %>
      <table align="center" border="1">
          <tr>
              <td align="center" align="center" colspan="9" width="200"><h5>Framework vs Baseline review- Configurazioni</h5></td>
          </tr>

          <tr>
              <td align="center"></td>
              <td align="center">Framework</td>
              <td align="center">Baseline non distrib.</td>
              <td align="center">Indifferente</td>
          </tr>

          <tr>
              <td align="center">Unigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unigrammi").get("indifferenti")));%></td>
          </tr>
          <tr>
              <td align="center">Bigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("bigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("bigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("bigrammi").get("indifferenti")));%></td>
          </tr>
          <tr>
              <td align="center">Uni-bigrammi</td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unibigrammi").get("sistema")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unibigrammi").get("baselineDistr")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeCS2.get("unibigrammi").get("indifferenti")));%></td>
          </tr>

      </table>

     <br><br>
	 
	 
	 
	 <%
     /////////////////////////PREFERENZE//////////////////
     //preferenza tra FRAMEOWRK e 4) BASELINE PUCARIELLO con TECNICHE
     HashMap<String, Double> preferenzeSBtecn = null;		
     preferenzeSBtecn = Preferenze.sistemaVSBaselineTecniche();
     %>       		
     <!-- 
      <table border="1" align="center">
          <tr>
              <td align="center" colspan="5" width="200"><h5>Preferenze SISTEMA - BASELINE PUCARIELLO con TECNICHE</h5></td>
          </tr>
          <tr>
              <td rowspan="2" align="center" width="100">Baseline Pucariello</td>
              <td colspan="2" align="center">Sistema</td>
              <td rowspan="2" align="center" width="100">Indifferente</td>
          </tr>
          
          <tr>
              <td align="center" width="100">Normale</td>
              <td align="center" width="100">PMI</td>
          </tr>
          
          <tr>
              <td align="center"><%out.println(Math.perc(preferenzeSBtecn.get("baseline")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBtecn.get("normale")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBtecn.get("pmi")));%></td>
              <td align="center"><%out.println(Math.perc(preferenzeSBtecn.get("indifferente")));%></td>
          </tr>
      </table>
	 --> 		
     <br><br> 
	 
	 
	 <%
     //confronto valutazioni metriche FRAMEWORK e BASELINE PUCARIELLO;
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrSB = null;	
     confrMetrSB = Confronti.sistemaVSBaselineMetriche();
     %>          

      <table align="center" border="1">

          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline review - Metriche e configurazioni </h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
          </tr>


          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("baseline").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("baseline").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("baseline").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("bigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSB.get("unibigrammi").get("baseline").get("Fiducia")));%></td>
          </tr>

      </table>

     <br><br>
	
	  <%
     //confronto valutazioni metriche FRAMEWORK e BASELINE PUCARIELLO;
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrSBNorm = null;	
     confrMetrSBNorm = Confronti.sistemaVSBaselineMetricheNormale();
     %>

      <table align="center" border="1">

          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline review - Metriche e configurazioni - Matrici </h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
          </tr>


          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("baseline").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("baseline").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("baseline").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("bigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBNorm.get("unibigrammi").get("baseline").get("Fiducia")));%></td>
          </tr>

      </table>

     <br><br>
     
     <%
     //confronto valutazioni metriche FRAMEWORK e BASELINE PUCARIELLO;
     HashMap<String, HashMap<String, HashMap<String, Double>>> confrMetrSBPMI = null;	
     confrMetrSBPMI = Confronti.sistemaVSBaselineMetrichePMI();
     %>          

      <table align="center" border="1">

          <tr>
              <td align="center" colspan="9" width="200"><h5>Framework vs Baseline review - Metriche e configurazioni - PMI </h5></td>
          </tr>

          <tr>
              <td align="center" width="120"></td>
              <td align="center" width="120" colspan="2">Unigrammi</td>
              <td align="center" width="120" colspan="2">Bigrammi</td>
              <td align="center" width="120" colspan="2">Uni-bigrammi</td>
          </tr>

          <tr>
              <td></td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
              <td align="center">Framework</td>
              <td align="center">Baseline review</td>
          </tr>


          <tr>
              <td align="center" width="120">Trasparenza</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("baseline").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("sistema").get("Trasparenza")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("baseline").get("Trasparenza")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Persuasione</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("baseline").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("sistema").get("Persuasione")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("baseline").get("Persuasione")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Coinvolgimento</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("baseline").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("sistema").get("Coinvolgimento")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("baseline").get("Coinvolgimento")));%></td>
          </tr>

          <tr>
              <td align="center" width="120">Fiducia</td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("bigrammi").get("baseline").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("sistema").get("Fiducia")));%></td>
              <td align="center" width="120"><%out.println(Math.perc(confrMetrSBPMI.get("unibigrammi").get("baseline").get("Fiducia")));%></td>
          </tr>

      </table>

     <br><br>
	
			
	 <%              
     ////////////////////////////SISTEMA///////////////////
     //15) SISTEMA VS BASELINE PUCARIELLO con CONTESTI
     HashMap<Integer, HashMap<String, Double>> SistBaselCont = null;
     SistBaselCont = 		Sistema.sistemaVsBaselineContesti();
     %>
     <!--  
      <table align="center" border=1>
          <thead>
          <tr>
              <th colspan="4">FRAMEWORK vs BASELINE PUCARIELLO con CONTESTI</th>
          </tr>
          <tr>
              <th rowspan="2">Num. contesti</th>
              <th rowspan="2">Baseline</th>
              <th colspan="2">Sistema</th>
          </tr>
          <tr>
              <th>Frasi singole</th>
              <th>Centroide</th>
          </tr>
          </thead>
          <tbody>
          <tr>
              <td>1</td>
              <td> <%out.println(Math.perc(SistBaselCont.get(1).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(1).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(1).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>2</td>
              <td> <%out.println(Math.perc(SistBaselCont.get(2).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(2).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(2).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>3</td>
              <td> <%out.println(Math.perc(SistBaselCont.get(3).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(3).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselCont.get(3).get("centroide")));%> </td>
          </tr>
          </tbody>

      </table>

     <br><br><br>
     -->           
     <%
     //16) FRAMEWORK vs BASELINE PUCARIELLO con CONTESTI SINGOLI (1,2,3,4,5,6,7)
     HashMap<Integer, HashMap<String, Double>> SistBaselContSing = 	null;
     SistBaselContSing = 	Sistema.sistemaVsBaselineSingoliContesti();
     %>
     <!--   
      <table align="center" border=1>
          <thead>
          <tr>
              <th colspan="4">FRAMEWORK vs BASELINE PUCARIELLO con CONTESTI SINGOLI</th>
          </tr>
          <tr>
              <th rowspan="2">Contesto</th>
              <th rowspan="2">BASELINE PUCARIELLO</th>
              <th colspan="2">FRAMEWORK</th>
          </tr>
          <tr>
              <th>Frasi singole</th>
              <th>Centroide</th>
          </tr>
          </thead>
          
          <tbody>
          <tr>
              <td>Alta Attenzione</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(1).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(1).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(1).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Bassa Attenzione</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(2).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(2).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(2).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Coppia</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(3).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(3).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(3).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Famiglia</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(4).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(4).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(4).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Amici</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(5).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(5).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(5).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Buon Umore</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(6).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(6).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(6).get("centroide")));%> </td>
          </tr>
          <tr>
              <td>Cattivo Umore</td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(7).get("baseline")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(7).get("singole")));%> </td>
              <td> <%out.println(Math.perc(SistBaselContSing.get(7).get("centroide")));%> </td>
          </tr>
          </tbody>

      </table>
	--> 
     <br>
     
      <%
     //17) FRAMEWORK vs BASELINE PUCARIELLO con FILM
     HashMap<Integer, HashMap<String, Double>> SistBaselFilm = null;		
     SistBaselFilm = 	Sistema.sistemaVsBaselineFilm();
     %>
     <!--   
      <table align="center" border=1>
          <thead>
          <tr>
              <th colspan="5">Baseline vs Sistema con Film</th>
          </tr>
          <tr>
              <th rowspan="2">Occorrenze</th>
              <th rowspan="2">Film</th>
              <th rowspan="2">BASELINE PUCARIELLO</th>
              <th colspan="2">FRAMEWORK</th>
          </tr>
          <tr>
              <th>Frasi singole</th>
              <th>Centroide</th>
          </tr>
          </thead>
          <tbody>
              <%/*
                  for (int film : contatoriFilm.keySet()){
                      if(SistBaselFilm.containsKey(film)) {
                          out.println("<tr>");
                          out.println("<td>"+ contatoriFilm.get(film)+"</td>");
                          out.println("<td>" + film + "</td>");
                          out.println("<td>" + Math.perc(SistBaselFilm.get(film).get("baseline")) + "</td>");
                          out.println("<td>" + Math.perc(SistBaselFilm.get(film).get("singole")) + "</td>");
                          out.println("<td>" + Math.perc(SistBaselFilm.get(film).get("centroide")) + "</td>");
                          out.println("</tr>");
                      }
                  }
              */
              %>

          </tbody>

      </table>
		  
	 -->  
     
    

<p align="center">6.3.6 <b>FILM SELEZIONATI</b></p> 
              
     <%             
     //contatori FILM suggeriti;
     HashMap<Integer, Integer> contatoriFilm = null;	
     contatoriFilm =  Contatori.contatoriLocaliSuggeriti();
     %> 
      <table align="center" border=1>
          <tr>
              <td align="center" colspan="3" width="400"><h5>Contatori FILM suggeriti</h5></td>
          </tr>

          <tr>
          	  <td align="center" width="200">Titolo Film </td>
              <td align="center" width="80">idFilm </td>
              <td align="center" width="80">Frequenza </td>
          </tr>
          <%
              for (int locale : contatoriFilm.keySet()){
                  out.println("<tr>" +
                		  		"<td align=\"center\" width=\"200\">" + Contatori.getTitoloLocale(locale) + "</td>"+
                         		"<td align=\"center\" width=\"80\">" + locale +   "</td>"+
                          		"<td align=\"center\" width=\"80\">" + contatoriFilm.get(locale) + "</td>"+
                         
                          		"</tr>");
              }
          %>
	 </table> 
	 
   

<p align="center">6.3.7 <b>MEDIE METRICHE PER CONTESTI</b></p>
      
    <%
    //MEDIA metriche per CONTESTI GENERALE
    HashMap<Integer, HashMap<String, Double>> medieContGen = null;	
    medieContGen = 	MedieMetriche.medieMetrichePerContestiGenerale();
    %>
    
     <table align="center" border=1>
         <tr>
             <td align="center" colspan="9" width="200"><h5>Medie metriche per contesto</h5></td>
         </tr>

         <tr>
             <td align="center">
                 Metriche
             </td>

             <td align="center">
                 Trasparenza
             </td>

             <td align="center">
                 Coinvolgimento
             </td>

             <td align="center">
                 Persuasione
             </td>

             <td align="center">
                 Fiducia
             </td>
         </tr>

         <%
            try{
                 HashMap<Integer, String> contesti = new HashMap<Integer, String>();

                 contesti.put(1, "High Attention");
                 contesti.put(2, "Low Attention");
                 contesti.put(3, "Partner");
                 contesti.put(4, "Babies");
                 contesti.put(5, "Friends");
                 contesti.put(6, "Good Mood");
                 contesti.put(7, "Bad Mood");

                 for (int cont=1; cont<=7; cont++){
                     out.println("<tr><td align=\"center\">" +
                             contesti.get(cont) +
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieContGen.get(cont).get("trasparenza"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieContGen.get(cont).get("persuasione"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieContGen.get(cont).get("coinvolgimento"))+
                             "</td> <td align=\"center\">" +
                             		Math.dec(medieContGen.get(cont).get("fiducia"))+
                             "</td> </tr>");
                 }
             } catch (Exception ecc){
                 ecc.printStackTrace();
             }
         %>
     </table> 
    <br>
    <br>
    <br>
</div>

</body>

</html>