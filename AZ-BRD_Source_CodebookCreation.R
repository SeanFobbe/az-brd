#'---
#'title: "Codebook | Aktenzeichen der Bundesrepublik Deutschland (AZ-BRD)"
#'author: Seán Fobbe
#'geometry: margin=3cm
#'papersize: a4
#'fontsize: 11pt
#'output:
#'  pdf_document:
#'    toc: true
#'    toc_depth: 3
#'    number_sections: true
#'    pandoc_args: --listings
#'    includes:
#'      in_header: General_Source_TEX_Preamble_DE.tex
#'      before_body: [AZ-BRD_Source_TEX_Definitions.tex,AZ-BRD_Source_TEX_CodebookTitle.tex]
#'bibliography: packages.bib
#'nocite: '@*'
#' ---

#'\newpage

#+ echo = FALSE 
knitr::opts_chunk$set(fig.align = "center",
                      echo = FALSE,
                      warning = FALSE,
                      message = FALSE)


############################
### Packages
############################

#+

library(knitr)        # Professionelles Reporting
library(kableExtra)   # Verbesserte Automatisierte Tabellen
library(magick)       # Fortgeschrittene Verarbeitung von Grafiken
library(parallel)     # Parallelisierung in Base R
library(ggplot2)      # Fortgeschrittene Datenvisualisierung
library(scales)       # Log-Skalen
library(data.table)   # Fortgeschrittene Datenverarbeitung




# Vollzitate statistischer Software
knitr::write_bib(c(.packages()),
                 "packages.bib")





############################
### Vorbereitung
############################

datasetname <- "AZ-BRD"
doi.concept <- "10.5281/zenodo.4559383" # checked
doi.version <- "10.5281/zenodo.4569564" # checked


version.period <- "1.0.1"


version.dash <- gsub("\\.",
                     "-",
                     version.period)


############################
### Tabellen einlesen
############################


### Datensatz einlesen


table.regz <- fread(paste(datasetname,
                          version.dash,
                          "DE_Registerzeichen_Datensatz.csv",
                          sep = "_"))



### Präfix erstellen

prefix <- paste0("ANALYSE/",
                 datasetname,
                 "_01_Frequenztabelle_var-")


### Tabellen einlesen

table.stelle <- fread(paste0(prefix,
                                 "stelle.csv"))[,-3]

table.position <- fread(paste0(prefix,
                                "position.csv"))[,-3]


############################
### Signaturen einlesen
############################

hashfile <- paste(datasetname, version, "KryptographischeHashes.csv", sep = "_")

signaturefile <- paste(datasetname, version, "FobbeSignaturGPG_Hashes.gpg", sep = "_")


############################
### Text beginn
############################




#'# Einführung

#' Die Aktenzeichen der Behörden und Gerichte der Bundesrepublik Deutschland sind für viele Bürger:innen ein Buch mit sieben Siegeln, aber auch für Jurist:innen und Politikwissenschaftler:innen nicht immer einfach zu durchschauen. Der Datensatz **\enquote{\datatitle\ (\datashort)}** zielt darauf ab alle Aktenzeichen der Bundesrepublik Deutschland systematisch, maschinenlesbar, menschenlesbar und wissenschaftlich fundiert für Öffentlichkeit und Forschung aufzubereiten.
#'
#' Die Erstveröffentlichung dieses Datensatzes stellt zunächst primär maschinenlesbare Informationen für alle Bundesgerichte bereit. Zukünftige Versionen werden auch die Gerichte der Länder und --- nach Möglichkeit --- die Verwaltungen des Bundes und der Länder miteinbeziehen. Originalfassungen der Aktenordnung sind in dieser Version nur für den Bundesgerichtshof (BGH) mit archiviert. Fernziel ist eine systematische Sammlung aller Aktenordnungen des Bundes und der Länder in ihrer jeweiligen Originalfassung und die maschinenlesbare Aufbereitung derselben.



#' 
#'Die quantitative Analyse von juristischen Daten ist in den deutschen Rechtswissenschaften ein noch junges und kaum bearbeitetes Feld.\footnote{Besonders positive Ausnahmen finden sich unter: \url{https://www.quantitative-rechtswissenschaft.de/}} Zu einem nicht unerheblichen Teil liegt dies auch daran, dass die Anzahl an frei nutzbaren Datensätzen außerordentlich gering ist.
#' 
#'Die meisten hochwertigen Datensätze lagern (fast) unerreichbar in kommerziellen Datenbanken und sind wissenschaftlich gar nicht oder nur gegen Entgelt zu nutzen. Frei verfügbare Datenbanken wie \emph{Opinio Iuris}\footnote{\url{https://opinioiuris.de/}} und \emph{openJur}\footnote{\url{https://openjur.de/}} verbieten ausdrücklich das maschinelle Auslesen der Rohdaten.\footnote{Openjur beabsichtigt eine API anzubieten, diese war \the\year\ aber immernoch nicht verfügbar. Openjur ist seit 2008 in Betrieb.} Wissenschaftliche Initiativen wie der Juristische Referenzkorpus (JuReKo) sind nach jahrelanger Arbeit hinter verschlossenen Türen verschwunden.
#' 
#'In einem funktionierenden Rechtsstaat muss die Ausübung staatlicher Gewalt durch Legislative, Exekutive und Judikative öffentlich, transparent und nachvollziehbar sein. Im 21. Jahrhundert bedeutet dies auch, dass sie systematischer Überprüfung mittels quantitativen Analysen zugänglich sein muss.
#'
#' Der Erstellung und Aufbereitung des Datensatzes liegen daher die Prinzipien der allgemeinen Verfügbarkeit durch Urheberrechtsfreiheit, strenge Transparenz und vollständige wissenschaftliche Reproduzierbarkeit zugrunde. Die FAIR-Prinzipien (Findable, Accessible, Interoperable and Reusable) für freie wissenschaftliche Daten inspirieren sowohl die Konstruktion, als auch die Art der Publikation.\footnote{Wilkinson, M., Dumontier, M., Aalbersberg, I. et al. The FAIR Guiding Principles for Scientific Data Management and Stewardship. Sci Data 3, 160018 (2016). \url{https://doi.org/10.1038/sdata.2016.18}}




#+
#'# Nutzung

#' Die Daten sind in  offenen, interoperablen und weit verbreiteten Formaten (CSV, PDF) veröffentlicht. Sie lassen sich grundsätzlich mit allen modernen Programmiersprachen (z.B. Python oder R), sowie mit grafischen Programmen nutzen.
#'
#' **Wichtig:** Nicht vorhandene Werte sind  mit "NA" codiert.

#+
#'## CSV-Dateien
#' Für maschinenlesbare Anwendungen ist es am einfachsten die **CSV-Dateien** einzulesen. CSV\footnote{Das CSV-Format ist in RFC 4180 definiert, siehe \url{https://tools.ietf.org/html/rfc4180}} ist ein einfaches und maschinell gut lesbares Tabellen-Format. In diesem Datensatz sind die Werte komma-separiert. Jede Spalte entspricht einer Variable, jede Zeile einer Entscheidung. Die Variablen sind unter Punkt \ref{variablen} genauer erläutert.
#'
#' Zum Einlesen empfehle ich für **R** das package **data.table** (via CRAN verfügbar). Dessen Funktion **fread()** ist etwa zehnmal so schnell wie die normale **read.csv()**-Funktion in Base-R. Sie erkennt auch den Datentyp von Variablen sicherer. Ein Vorschlag:

#+ eval = FALSE, echo = TRUE
library(data.table)
dt <- fread("filename.csv")

#+
#'## Lesefassung im Codebook
#' Alle in der maschinenlesbaren CSV-Variante enthaltenen Registerzeichen sind in diesem Codebook auch noch einmal in einer gut formatierten Lesefassung wiedergegeben, damit sie für die traditionelle qualitative Arbeit schnell und gut nutzbar sind.
#'
#'## Lesefassungen der Quellen
#'
#' Die Quellen sind --- soweit verfügbar --- auch als PDF-Dateien im Datensatz enthalten. Die Lesefassungen zeichnen sich vor allem dadurch aus, dass ein Originaldokument pro PDF-Datei enthalten ist und die Dateinamen strukturiert und detailliert aufbereitet sind.
#'
#'## Originalfassungen der Quellen
#'
#' Auch enthalten sind die Originalfassungen der Quellen. Diese sind jedoch teilweise über mehrere PDF-Dateien verteilt oder mehrere Dokumente sind in einer PDF-Datei gespeichert. Die zuvor erwähnten Lesefassungen sind um diese Probleme bereinigt.




#+
#'# Konstruktion


#+
#'## Beschreibung des Datensatzes

#'Der Datensatz **\enquote{\datatitle\ (\datashort)}** zielt darauf ab alle Aktenzeichen der Bundesrepublik Deutschland systematisch, maschinenlesbar, menschenlesbar und wissenschaftlich fundiert für Öffentlichkeit und Forschung aufzubereiten.
#'
#' Die Erstveröffentlichung dieses Datensatzes stellt zunächst primär maschinenlesbare Informationen für alle Bundesgerichte bereit. Zukünftige Versionen werden auch die Gerichte der Länder und --- nach Möglichkeit --- die Verwaltung des Bundes und der Länder miteinbeziehen. Originalfassungen der Aktenordnung sind in dieser Version nur für den Bundesgerichtshof (BGH) mit archiviert. Fernziel ist eine systematische Sammlung aller Aktenordnungen des Bundes und der Länder in ihrer jeweiligen Originalfassung und die maschinenlesbare Aufbereitung derselben.


#+
#'## Quellen

#'\begin{centering}
#'\begin{longtable}{P{5cm}p{9cm}}

#'\toprule

#' Quelle & Fundstelle \\

#'\midrule

#' AktOBGH & \url{https://fragdenstaat.de/anfrage/aktenordnung-bundesgerichtshof/}\\
#' BGH Webseite & \url{https://www.bundesgerichtshof.de/DE/Verfahrensarten/ErlaeuterungAktenzeichen/erlaeuterungAktenzeichen_node.html}\\
#' GVP BSG & \url{www.richter-im-internet.de}\\
#' Source Code & \url{\softwareversionurldoi}\\

#'\bottomrule

#'\end{longtable}
#'\end{centering}

#'### Datenquellen

#' Die Struktur der Aktenzeichen und Bedeutung weiterer Registerzeichen wurde vom Autor manuell durch Abgleich und Synthese einer Vielzahl öffentlich zugänglicher Quellen zusammengestellt. Amtliche Quellen waren nur für den Bundesgerichtshof und das Bundessozialgericht verfügbar. Für das Bundessozialgericht war die Aktenordnung nicht online auffindbar, hier wurde auf den Anhang der Geschäftsverteilungspläne von 2000 bis 2020 zurückgegriffen.
#'
#' Die weitere Stärkung der Quellenlage ist ein zentrales Ziel im Forschungsprogramm dieses Datensatzes.
#'
#' 
#' Die Scans der Aktenordnung des Bundesgerichtshofs (AktOBGH) stammen aus einer von Herrn Mark O. am 30. Juli 2013 gestellten Anfrage nach dem Informationsfreiheitsgesetz (IFG) und wurden auf www.fragdenstaat.de im Laufe des Jahres 2013 veröffentlicht.\footnote{\url{https://fragdenstaat.de/anfrage/aktenordnung-bundesgerichtshof/}}
#'


#+
#'### Source Code und Codebook

 
#' Der gesamte Source Code --- sowohl für die Erstellung des Datensatzes, als auch für dieses Codebook --- ist öffentlich einsehbar und dauerhaft erreichbar im wissenschaftlichen Archiv des CERN hinterlegt.
#'
#' Mit jeder Kompilierung des vollständigen Datensatzes wird auch ein umfangreicher **Compilation Report** in einem attraktiv designten PDF-Format erstellt (ähnlich diesem Codebook). Der Compilation Report enthält den vollständigen und kommentierten Source Code, dokumentiert relevante Rechenergebnisse, gibt sekundengenaue Zeitstempel an und ist mit einem klickbaren Inhaltsverzeichnis versehen. Er ist zusammen mit dem Source Code hinterlegt. Wenn Sie sich für Details der Herstellung interessieren, lesen Sie diesen bitte zuerst.


#+
#'## Grenzen des Datensatzes
#'Nutzer sollten folgende wichtige Grenzen beachten:
#' 
#'\begin{enumerate}
#'\item Die maschinenlesbaren Varianten des Datensatzes beruht aktuell auf einer Vielzahl nicht-amtlicher Quellen, weil die amtliche Datenlage sehr schlecht ist (\emph{publication bias}).
#'\item Nur für den Bundesgerichtshof sind amtliche Quellen in diesem Datensatz hinterlegt (\emph{availability bias})

#'\end{enumerate}


#+
#'## Urheberrechtsfreiheit von Rohdaten und Datensatz 

#'An den Scans der Aktenordnung des Bundesgerichtshofs besteht gem. § 5 Abs. 1 UrhG kein Urheberrecht, da sie amtliche Erlasse oder Bekanntmachungen darstellen.
#'
#'An den Registerzeichen besteht gem. § 5 Abs. 1 UrhG kein Urheberrecht, da sie in urheberrechtsfreien amtliche Erlassen oder Bekanntmachungen enthalten sind.
#'
#' Alle eigenen Einzelbeiträge (z.B. durch Zusammenstellung und Anpassung der Metadaten), sowie den gesamten Datensatz stelle ich gemäß einer \emph{CC0 1.0 Universal Public Domain Lizenz} vollständig urheberrechtsfrei.


#+
#'# Struktur bundesdeutscher Aktenzeichen

#' Folgend sind die üblichen Schemata für Aktenzeichen der Justiz und Verwaltung der Bundesrepublik Deutschland dargestellt. Von beiden Schemata kann es jedoch teils erhebliche Abweichungen geben. Diese werden in diesem Codebook separat für jede öffentliche Stelle dokumentiert.
#'
#' Die Registerzeichen der Gerichte haben für quantitative Analysen eine ganz besondere Bedeutung, weil sie bei der Analyse von Entscheidungstexten und -metadaten erlauben den Untersuchungsgegenstand nach Verfahrensarten zu filtern und exaktere Analysen durchzuführen.



#+
#'## Verwaltung

#' Aktenzeichen der deutschen Verwaltung sind in der Regel wie folgt aufgebaut:
#'
#'  \bigskip
#'
#' \begin{center}
#' 
#' [Aktenplankennzeichen]/[Ordnungsnummer]
#'
#'  \bigskip
#' 
#' \textbf{Beispiel:} 23452/33
#'
#'  \end{center}



#+
#'## Justiz

#+
#'### Regelstruktur
#' 
#' Aktenzeichen der deutschen Justiz (Gerichte, Staatsanwaltschaften) sind in der Regel wie folgt aufgebaut:
#'
#' \bigskip
#'
#' \begin{center}
#'
#' [Abteilung] [Hauptzeichen] [Eingangsnummer]/[Eingangsjahr] [Zusatz]
#'
#' \bigskip
#'
#' \textbf{Beispiel:} 1 StR 287/05
#'
#' \end{center}
#'
#' \bigskip

#+
#'### BVerwG --- Bundesverwaltungsgericht
#' Neuere Aktenzeichen-Strukturen  des Bundesverwaltungsgerichts (BVerwG) verwenden einen Punkt statt einem Schrägstrich (\enquote{Solidus}). 


#+
#'### BSG --- Bundessozialgericht
#' Aktenzeichen des Bundessozialgerichts (BSG) verwenden im Grunde die gleiche Aktenzeichen-Struktur wie andere Bundesgerichte, stellen den Aktenzeichen aber ein \enquote{B} voran. Das Hauptzeichen wird vom Bundessozialgericht als \enquote{Sachgebiet} bezeichnet und der Zusatz als \enquote{Register}.
#'
#' **Beispiel:** Das Aktenzeichen B 11 AL 15/17 R steht für eine Entscheidung des 11. Senats des Bundessozialgerichts betreffend die Arbeitslosenversicherung und übrige Aufgaben der Bundesagentur für Arbeit, eingegangen im Jahr 2017 mit der Eingangsnummer 15, welche im Revisionsregister eingetragen ist.






#+
#'# Abteilungen


#+
#'## BAG --- Bundesarbeitsgericht
#'  Die Angabe der Abteilung in Aktenzeichen des Bundesarbeitsgerichts (BAG) bezieht sich immer auf den jeweiligen Senat des Gerichts, in arabischen Ziffern.
#'
#'   **Beispiel:** Das Aktenzeichen 2 AZR 570/19 steht für eine durch den 2. Senat entschiedene Revision, die im Jahr 2019 eingegangen ist und die Eingangsnummer 570 trägt.
#'
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 10 Senate und ein Großer Senat.\footnote{Geschäftsverteilungsplan des Bundesarbeitsgerichts für das Geschäftsjahr 2020. \url{https://doi.org/10.17176/20200220-091926-0}}
#' 

#+
#'## BFH --- Bundesfinanzhof
#'
#'  Die Angabe der Abteilung in Aktenzeichen des Bundesfinanzhofs (BFH) bezieht sich immer auf den jeweiligen Senat des Gerichts, in römischen Ziffern.
#'
#'   **Beispiel:** Das Aktenzeichen IX R 32/19 steht für eine durch den 9. Senat entschiedene Revision, die im Jahr 2019 eingegangen ist und die Eingangsnummer 32 trägt.
#'
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 11 Senate und ein Großer Senat.\footnote{Geschäftsverteilungsplan des Bundesfinanzhofs für das Geschäftsjahr 2020. \url{https://doi.org/10.17176/20200220-092424-0}}


#+
#'## BGH --- Bundesgerichtshof
#' Die **Zivilsenate** des Bundesgerichtshofs (BGH) sind immer mit *römischen Ziffern* (z.b. steht \enquote{IX} für den 9. Zivilsenat) und die **Strafsenate** immer mit *arabischen Ziffern* (z.B. steht \enquote{3} für den 3. Strafsenat) gekennzeichnet. Andere Senate des Bundesgerichtshofs sind nicht mit Abteilungsnummern gekennzeichnet, diese entfallen restlos. Die Abteilungen ergeben sich in diesen Fällen implizit aus den Registerzeichen.
#'
#'
#' **Beispiel:** 6 StR 421/20  steht für eine durch den 6. Strafsenat entschiedene Revision, die im Jahr 2020 eingegangen ist und die Eingangsnummer 421 trägt.
#'
#'
#' **Beispiel:** AnwZ (Brfg) 27/20 steht für eine Entscheidung über \enquote{Berufungen und Anträge auf Zulassung der Berufung gegen Entscheidungen eines Anwaltsgerichtshofes}, das Jahr 2020 und die Eingangsnummer 27. Das es sich hierbei um den Senat für Anwaltssachen handelt ergibt sich aus dem Registerzeichen, da nur einem Senat diese Verfahren zugewiesen sind.
#'
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 13 Zivilsenate, 5 Strafsenate, ein Großer Senat für Zivilsachen, ein Großer Senat für Strafsachen, die Vereinigten Großen Senate, ein Kartellsenat, das Dienstgericht des Bundes, ein Senat für Notarsachen, ein Senat für Anwaltssachen, ein Senat für Patentanwaltssachen, ein Senat für Landwirtschaftssachen, ein Senat für Wirtschaftsprüfersachen und ein Senat für Steuerberater- und Steuerbevollmächtigtensachen.\footnote{Geschäftsverteilungsplan des Bundesgerichtshofs für das Geschäftsjahr 2020. \url{https://doi.org/10.17176/20200220-092251-0}}



#+
#'## BPatG --- Bundespatentgericht
#'
#' Die Angabe der Abteilung in Aktenzeichen des Bundespatentgerichts (BPatG) bezieht sich immer auf den jeweiligen Senat des Gerichts, in arabischen Ziffern. Die Senate des Bundespatentgerichts sind (nicht im Abteilungszeichen erkenntlich) verschiedenen Senatsgruppen zugeordnet: Nichtigkeitssenat, Juristischer Beschwerdesenat, Juristischer Beschwerdesenat und Nichtigkeitssenat, Technischer Beschwerdesenat, Marken-Beschwerdesenat, Marken- und Design-Beschwerdesenat, Gebrauchsmuster-Beschwerdesenat oder Sortenschutz-Beschwerdesenat.
#'
#' **Beispiel:** Das Aktenzeichen 17 W (pat) 17/20 steht für eine durch den 17. Senat entschiedene Beschwerde in in Patentsachen, Gebrauchsmustersachen, Sortenschutzsachen oder  Markensachen, die im Jahr 2020 eingegangen ist und die Eingangsnummer 17 trägt.
#'
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 6 Nichtigkeitssenate, 1 Juristischer Beschwerdesenat und Nichtigkeitssenat, 10 Technische Beschwerdesenate, 4 Marken-Beschwerdesenate, 1 Marken- und Design-Beschwerdesenat, 1 Gebrauchsmuster-Beschwerdesenat, 1 Beschwerdesenat für Sortenschutzsachen und ein Großer Senat.\footnote{Geschäftsverteilungsplan des Bundespatentgerichts für das Geschäftsjahr 2020 \url{https://doi.org/10.17176/20200220-093125-0}} Nicht alle Senatsnummern sind dauerhaft vergeben, manchmal können sich nach einer Neuorganisation Lücken in der Zählung ergeben.
#'

 	



#+
#'## BSG --- Bundessozialgericht
#'
#'  Die Angabe der Abteilung in Aktenzeichen des Bundessozialgerichts (BSG) bezieht sich immer auf den jeweiligen Senat des Gerichts, in arabischen Ziffern. Das \enquote{B} am Beginn eines jeden Aktenzeichens steht für \enquote{Bundessozialgericht}.
#'
#' **Beispiel:** Das Aktenzeichen B 11 AL 15/17 R steht für eine Entscheidung des 11. Senats des Bundessozialgerichts betreffend die Arbeitslosenversicherung und übrige Aufgaben der Bundesagentur für Arbeit, eingegangen im Jahr 2017 mit der Eingangsnummer 15, welche im Revisionsregister eingetragen ist.
#' 
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 14 Senate und ein Großer Senat.\footnote{Geschäftsverteilungsplan des Bundessozialgerichts für das Geschäftsjahr 2020. \url{https://doi.org/10.17176/20200220-092552-0}}



#+
#'## BVerfG --- Bundesverfassungsgericht
#' Das Bundesverfassungsgericht dokumentiert in seinen Aktenzeichen zwei Abteilungen: den 1. Senat und den 2. Senat, jeweils durch eine einzelne arabische Ziffer (\enquote{1} oder \enquote{2}).
#' 
#' Kammerentscheidungen tragen die Abteilungsziffer des Senats dem die Kammer zugeordnet ist.
#'
#' Entscheidungen über Verzögerungsrügen werden ohne Abteilungsnummer dokumentiert, hier impliziert das Registerzeichen, dass es sich nur um eine Entscheidung der Beschwerdekammer nach § 97c BVerfGG handeln kann.
#'
#'  **Beispiel:** 2 BvR 916/11 steht für eine dem 2. Senat zugeordnete Entscheidung über eine Verfassungsbeschwerde, die im Jahr 2011 am Bundesverfassungsgericht einging und die Eingangsnummer 916 trägt.
#'
#' Das Aktenzeichen gibt keine Auskunft darüber, ob es sich um eine Kammer- oder Senatsentscheidung handelt, diese Information ist aber in der ECLI kodiert. Der **Corpus der Entscheidungen des Bundesverfassungsgerichts (CE-BVerfG)**\footnote{\url{https://doi.org/10.5281/zenodo.3902658}} enthält für diesen Zweck eine entsprechende Variable.



#+
#'## BVerwG --- Bundesverwaltungsgericht
#'
#' 
#'  Die Angabe der Abteilung in Aktenzeichen des Bundesverwaltungsgerichts (BVerwG) bezieht sich (fast) immer auf den jeweiligen Revisionssenat des Gerichts, in arabischen Ziffern. Die Ziffern 1 und 2 werden sowohl für den 1. und 2. Revisionssenat, als auch für den 1. und 2. Wehrdienstsenat vergeben. Eine Unterscheidung zwischen den Senaten lässt sich nur durch das Registerzeichen treffen.
#'
#' **Beispiel:** Das Aktenzeichen BVerwG 8 C 22.19 steht für eine Entscheidung des 8. Revisionsenats des Bundesverwaltungsgerichts, eingegangen im Jahr 2019 mit der Eingangsnummer 22.
#' 
#' Im Geschäftsverteilungsplan für das Jahr 2020 waren vorgesehen: 10 Revisionssenate, ein Fachsenat nach § 189 VwGO, zwei Wehrdienstsenate und ein Großer Senat.\footnote{Geschäftsverteilungsplan des Bundesverwaltungsgerichts für das Geschäftsjahr 2020. \url{https://doi.org/10.17176/20200220-092715-0}}


	


#+
#'# Registerzeichen: Datenstruktur der CSV-Datei

str(table.regz)


#+
#'# Registerzeichen: Variablen der CSV-Datei

#'\label{variablen}

#+
#'## Hinweise

#'\begin{itemize}
#'\item Fehlende Werte sind immer mit \enquote{NA} codiert
#'\item Strings können grundsätzlich alle in UTF-8 definierten Zeichen (insbesondere Buchstaben, Zahlen und Sonderzeichen) enthalten.
#'\end{itemize}

#+
#'## Erläuterungen zu den einzelnen Variablen

#'\ra{1.3}
#' 
#'\begin{centering}
#'\begin{longtable}{P{3.5cm}P{3cm}p{8cm}}
#' 
#'\toprule
#' 
#'Variable & Typ & Erläuterung\\
#'
#' 
#'\midrule
#'
#'\endhead
#' 
#'stelle & Alphabetisch & Die öffentliche Stelle, die das Zeichen verwendet.\\
#'zeichen\_code  & String & Das Registerzeichen in einer um bestimmte Sonderzeichen (in der Regel runde Klammern) bereinigten Form, die sich auch für Dateinamen unter Windows eignet.\\
#'zeichen\_original & String & Das originale Registerzeichen, so wie es von der öffentlichen Stelle verwendet wird.\\
#'position & Alphabetisch & Die Position des Registerzeichens. Mögliche Werte sind \enquote{hauptzeichen} oder \enquote{zusatz}.\\
#'bedeutung & String & Die Bedeutung des Registerzeichens. \\
#'normen & String & Die Normen der Verfahrensart, auf die das Registerzeichen hinweist. Absätze sind in römischen Ziffern kodiert. \enquote{S.} steht für \enquote{Satz}.\\
#'verwendung\_ende & String & Der Zeitpunkt ab dem das Registerzeichen nicht mehr verwendet wurde. Idealerweise als Datum (YYYY-MM-DD), notfalls das Jahr (YYYY). Der Wert ist \enquote{NA} wenn keine Angabe vorliegt.\\
#' version & Datum & Die Versionsnummer des Datensatzes. Es wird eine semantische Versionierung in der Form MAJOR.MINOR.PATCH verwendet. Vertiefend zu semantischer Versionierung: \url{https://semver.org/}.\\
#' doi\_concept & String & Der Digital Object Identifier (DOI) des Gesamtkonzeptes des Datensatzes. Dieser ist langzeit-stabil (persistent). Über diese DOI kann via www.doi.org immer die \textbf{aktuellste Version} des Datensatzes abgerufen werden. Prinzip F1 der FAIR-Data Prinzipien (\enquote{data are assigned globally unique and persistent identifiers}) empfiehlt die Dokumentation jeder Messung mit einem persistenten Identifikator. Selbst wenn die CSV-Dateien ohne Kontext weitergegeben werden kann ihre Herkunft so immer zweifelsfrei und maschinenlesbar bestimmt werden.\\
#' doi\_version & String & Der Digital Object Identifier (DOI) der \textbf{konkreten Version} des Datensatzes. Dieser ist langzeit-stabil (persistent). Über diese DOI kann via www.doi.org immer diese konkrete Version des Datensatzes abgerufen werden. Prinzip F1 der FAIR-Data Prinzipien (\enquote{data are assigned globally unique and persistent identifiers}) empfiehlt die Dokumentation jeder Messung mit einem persistenten Identifikator. Selbst wenn die CSV-Dateien ohne Kontext weitergegeben werden kann ihre Herkunft so immer zweifelsfrei und maschinenlesbar bestimmt werden.\\
#' 
#'\bottomrule
#' 
#'\end{longtable}
#'\end{centering}





#'\newpage
#+
#'# Registerzeichen: Hauptzeichen
#' 
#'\label{register-haupt}
#' 

#'\ra{1.2}

align <- c("P{2cm}",
           "p{9cm}",
           "p{3cm}")

colnames <- c("Zeichen",
              "Beschreibung",
              "Normen")

variables <- c(3, 5:6)

options(knitr.kable.NA = "")

#'## BAG --- Bundesarbeitsgericht


table.show <- table.regz[stelle == "BAG" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")


#'\newpage
#'## BFH --- Bundesfinanzhof

table.show <- table.regz[stelle == "BFH" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")



#'\newpage
#'## BGH --- Bundesgerichtshof

table.show <- table.regz[stelle == "BGH" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")




#'\newpage
#'## BPatG --- Bundespatentgericht

table.show <- table.regz[stelle == "BPatG" & position == "hauptzeichen",..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")


#'\newpage
#'## BSG --- Bundessozialgericht (Sachgebiete)

table.show <- table.regz[stelle == "BSG" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")




#'\newpage
#'## BVerfG --- Bundesverfassungsgericht

table.show <- table.regz[stelle == "BVerfG" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")





#'\newpage
#'## BVerwG --- Bundesverwaltungsgericht

table.show <- table.regz[stelle == "BVerwG" & position == "hauptzeichen", ..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")






#'\newpage
#'## GBA --- Generalbundesanwalt

table.show <- table.regz[stelle == "GBA" & position == "hauptzeichen",..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")





#'\newpage
#+

#'# Registerzeichen: Zusätze
#' 
#'\label{register-zusatz}
#' 

#'\ra{1.2}


#'## BSG --- Bundessozialgericht

table.show <- table.regz[stelle == "BSG" & position == "zusatz",..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")


#'## BVerwG --- Bundesverwaltungsgericht

table.show <- table.regz[stelle == "BVerwG" & position == "zusatz",..variables]


kable(table.show,
      format = "latex",
      align = align,
      booktabs = TRUE,
      longtable = TRUE,
      col.names = colnames) %>% kable_styling(latex_options = "repeat_header")




#'\newpage
#+







    
#' \newpage
#' \ra{1.4}
#+
#'# Inhalt des Datensatzes


#'## Nach Öffentlicher Stelle

freqtable <- table.stelle[-.N]


#+ REGZ-DG_02_Barplot_Stelle, fig.height = 5, fig.width = 8
ggplot(data = freqtable) +
    geom_bar(aes(x = stelle,
                 y = N),
             stat = "identity",
             fill = "#7e0731",
             color = "black",
             width = 0.5) +
    theme_bw() +
    labs(
        title = paste(datasetname,
                      "| Version",
                      version.period,
                      "| Registerzeichen je Öffentliche Stelle"),
        caption = paste("DOI:",
                        doi.version),
        x = "Öffentliche Stelle",
        y = "Registerzeichen"
    )+
    theme(
        text = element_text(size = 14),
        plot.title = element_text(size = 14,
                                  face = "bold"),
        legend.position = "none",
        plot.margin = margin(10, 20, 10, 10)
    )





#'\vspace{1cm}

kable(table.stelle,
      format = "latex",
      align = 'P{3cm}',
      booktabs = TRUE,
      longtable = TRUE,
      col.names = c("Stelle",
                    "Zeichen",
                    "% Gesamt",
                    "% Kumulativ")) %>% kable_styling(latex_options = "repeat_header")




#+
#'## Nach Position


#'\vspace{0.5cm}
freqtable <- table.position[-.N]


#+ REGZ-DG_03_Barplot_Position, fig.height = 5, fig.width = 8
ggplot(data = freqtable) +
    geom_bar(aes(x = position,
                 y = N),
             stat = "identity",
             fill = "#7e0731",
             color = "black",
             width = 0.5) +
    theme_bw() +
    labs(
        title = paste(datasetname,
                      "| Version",
                      version.period,
                      "| Registerzeichen je Position"),
        caption = paste("DOI:",
                        doi.version),
        x = "Position",
        y = "Registerzeichen"
    )+
    theme(
        text = element_text(size = 14),
        plot.title = element_text(size = 14,
                                  face = "bold"),
        legend.position = "none",
        plot.margin = margin(10, 20, 10, 10)
    )



#'\vspace{1cm}

kable(table.position,
      format = "latex",
      align = 'P{3cm}',
      booktabs = TRUE,
      longtable = TRUE,
      col.names = c("Position",
                    "Zeichen",
                    "% Gesamt",
                    "% Kumulativ")) %>% kable_styling(latex_options = "repeat_header")








#'\newpage
#+
#'# Signaturprüfung

#+
#'## Allgemeines
#' Die Integrität und Echtheit der einzelnen Elemente des Datensatzes sind durch eine Zwei-Phasen-Signatur sichergestellt.
#'
#' In **Phase I** werden während der Kompilierung für jedes ZIP-Archiv und die Registerzeichen Hash-Werte in zwei verschiedenen Verfahren (SHA2-256 und SHA3-512) berechnet und in einer CSV-Datei dokumentiert.
#'
#' In **Phase II** werden diese CSV-Datei, Codebook und Compilation Report mit meinem persönlichen geheimen GPG-Schlüssel signiert.
#'
#' Dieses Verfahren stellt sicher, dass die Kompilierung von jedermann durchgeführt werden kann, insbesondere im Rahmen von Replikationen, die persönliche Gewähr für Ergebnisse aber dennoch vorhanden bleibt.
#'
#' Dieses Codebook ist vollautomatisch erstellt und prüft die kryptographisch sicheren SHA3-512 Signaturen (\enquote{hashes}) aller ZIP-Archive, sowie die GPG-Signatur der CSV-Datei, welche die SHA3-512 Signaturen enthält. SHA3-512 Signaturen werden durch einen system call zur OpenSSL library auf Linux-Systemen berechnet. Eine erfolgreiche Prüfung meldet \enquote{Signatur verifiziert!}. Eine gescheiterte Prüfung meldet \enquote{FEHLER!}

#+
#'## Persönliche GPG-Signatur
#' Die während der Kompilierung des Datensatzes erstellte CSV-Datei mit den Hash-Prüfsummen ist mit meiner persönlichen GPG-Signatur versehen. Der mit dieser Version korrespondierende Public Key ist sowohl mit dem Datensatz als auch mit dem Source Code hinterlegt. Er hat folgende Kenndaten:
#' 
#' **Name:** Sean Fobbe (fobbe-data@posteo.de)
#' 
#' **Fingerabdruck:** FE6F B888 F0E5 656C 1D25  3B9A 50C4 1384 F44A 4E42

#+
#'## Import: Public Key
#+ echo = TRUE
system2("gpg2", "--import GPG-Public-Key_Fobbe-Data.asc",
        stdout = TRUE,
        stderr = TRUE)




#'\newpage
#+
#'## Prüfung: GPG-Signatur der Hash-Datei

#+ echo = TRUE

# CSV-Datei mit Hashes
print(hashfile)
# GPG-Signatur
print(signaturefile)

# GPG-Signatur prüfen
testresult <- system2("gpg2",
                      paste("--verify", signaturefile, hashfile),
                      stdout = TRUE,
                      stderr = TRUE)

# Anführungsstriche entfernen um Anzeigefehler zu vermeiden
testresult <- gsub('"', '', testresult)

#+ echo = TRUE
kable(testresult, format = "latex", booktabs = TRUE,
      longtable = TRUE, col.names = c("Ergebnis"))


#'\newpage
#+
#'## Prüfung: SHA3-512 Hashes der ZIP-Archive
#+ echo = TRUE

# Prüf-Funktion definieren
sha3test <- function(filename, sig){
    sig.new <- system2("openssl",
                       paste("sha3-512", filename),
                       stdout = TRUE)
    sig.new <- gsub("^.*\\= ", "", sig.new)
    if (sig == sig.new){
        return("Signatur verifiziert!")
    }else{
        return("FEHLER!")
    }
}


# Ursprüngliche Signaturen importieren
table.hashes <- fread(hashfile)
filename <- table.hashes$filename
sha3.512 <- table.hashes$sha3.512

# Signaturprüfung durchführen 
sha3.512.result <- mcmapply(sha3test, filename, sha3.512, USE.NAMES = FALSE)

# Ergebnis anzeigen
testresult <- data.table(filename, sha3.512.result)

#+ echo = TRUE
kable(testresult, format = "latex", booktabs = TRUE,
      longtable = TRUE, col.names = c("Datei", "Ergebnis"))







#+
#'# Changelog
#'
#'\ra{1.3}
#'
#' 
#'\begin{centering}
#'\begin{longtable}{p{2.5cm}p{11.5cm}}
#'\toprule
#'Version &  Details\\
#'\midrule
#'
#'\version  &
#'
#' \begin{itemize}
#' \item Kleinere terminologische Änderungen.
#' \item Frequenztabellen jetzt mit Summen.
#' \item Variable \enquote{behoerde} in \enquote{stelle} umbenannt.
#' \end{itemize}\\
#'
#' 
#'1.0.0  &
#'
#' \begin{itemize}
#' \item Erstveröffentlichung
#' \end{itemize}\\
#' 
#'\bottomrule
#'\end{longtable}
#'\end{centering}













#'\newpage
#+
#'# Parameter für strenge Replikationen

system2("openssl",  "version", stdout = TRUE)

sessionInfo()

#'# Literaturverzeichnis
