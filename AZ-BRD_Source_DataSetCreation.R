#'---
#'title: "Compilation Report | Aktenzeichen der Bundesrepublik Deutschland (AZ-BRD)"
#'author: Seán Fobbe
#'papersize: a4
#'geometry: margin=3cm
#'fontsize: 11pt
#'output:
#'  pdf_document:
#'    toc: true
#'    toc_depth: 3
#'    number_sections: true
#'    pandoc_args: --listings
#'    includes:
#'      in_header: General_Source_TEX_Preamble_DE.tex
#'      before_body: [AZ-BRD_Source_TEX_Definitions.tex,AZ-BRD_Source_TEX_CompilationTitle.tex]
#'bibliography: packages.bib
#'nocite: '@*'
#' ---






#'\newpage
#+
#'# Einleitung
#'
#+
#'## Überblick
#' Dieses R-Skript ist die Basis für den Datensatz \textbf{\enquote{\datatitle\ (\datashort )}}.
#'
#' Alle mit diesem Skript erstellten Datensätze werden dauerhaft kostenlos und urheberrechtsfrei auf Zenodo, dem wissenschaftlichen Archiv des CERN, veröffentlicht. Jede Version ist mit ihrem eigenen, persistenten Digital Object Identifier (DOI) versehen. Die neueste Version des Datensatzes ist immer über den Link der Concept DOI erreichbar: \dataconcepturldoi

#+
#'## Funktionsweise

#' Primäre Endprodukte des Skripts sind:
#' 
#' \begin{enumerate}
#' \item Alle Registerzeichen im CSV-Format
#' \item Die Originalquellen
#' \item Die Lesefassungen der Originalquellen
#' \item Alle Analyse-Ergebnisse (Tabellen als CSV, Grafiken als PDF und PNG)
#' \item Der Source Code und alle weiteren Quelldaten
#' \end{enumerate}
#'
#' Zusätzlich werden für alle ZIP-Archive kryptographisch sichere Signaturen (SHA2-256 und SHA3-512) berechnet und in einer CSV-Datei hinterlegt. Die Analyse-Ergebnisse werden zum Ende hin nicht gelöscht, damit sie für die Codebook-Erstellung verwendet werden können. Weiterhin kann optional ein PDF-Bericht erstellt werden (siehe unter "Kompilierung").


#+
#'## Systemanforderungen
#' Das Skript in seiner veröffentlichten Form kann nur unter Linux ausgeführt werden, da es Linux-spezifische Optimierungen (z.B. Fork Cluster) und Shell-Kommandos (z.B. OpenSSL) nutzt. Das Skript wurde unter Fedora Linux entwickelt und getestet. Die zur Kompilierung benutzte Version entnehmen Sie bitte dem **sessionInfo()**-Ausdruck am Ende dieses Berichts.
#'
#' In der Standard-Einstellung wird das Skript vollautomatisch die maximale Anzahl an Rechenkernen/Threads auf dem System zu nutzen. Wenn die Anzahl Threads (Variable "fullCores") auf 1 gesetzt wird, ist die Parallelisierung deaktiviert.
#'
#' Auf der Festplatte sollten 100 MB Speicherplatz vorhanden sein.
#' 
#' Um die PDF-Berichte kompilieren zu können benötigen Sie das R package **rmarkdown**, eine vollständige Installation von \LaTeX\ und alle in der Präambel-TEX-Datei angegebenen \LaTeX\ Packages.




#+
#'## Kompilierung

#' Mit der Funktion **render()** von **rmarkdown** können der **vollständige Datensatz** und das **Codebook** kompiliert und die Skripte mitsamt ihrer Rechenergebnisse in ein gut lesbares PDF-Format überführt werden.
#'
#' Alle Kommentare sind im roxygen2-Stil gehalten. Die beiden Skripte können daher auch **ohne render()** regulär als R-Skripte ausgeführt werden. Es wird in diesem Fall kein PDF-Bericht erstellt und Diagramme werden nicht abgespeichert.

#+
#'### Datensatz 

#' 
#' Um den **vollständigen Datensatz** zu kompilieren und einen PDF-Bericht zu erstellen, kopieren Sie bitte alle im Source-Archiv bereitgestellten Dateien und den Ordner mit den Originalquellen in einen leeren Ordner und führen mit R diesen Befehl aus:

#+ eval = FALSE

rmarkdown::render(input = "AZ-BRD_Source_DataSetCreation.R",
                  output_file = "AZ-BRD_1-0-1_CompilationReport.pdf",
                  envir = new.env())


#'### Codebook
#' Um das **Codebook** zu kompilieren und einen PDF-Bericht zu erstellen, kopieren Sie bitte alle im Source-Archiv bereitgestellten Dateien in einen leeren Ordner und führen im Anschluss an die Kompilierung des Datensatzes (!) untenstehenden Befehl mit R aus.
#'
#' Bei der Prüfung der GPG-Signatur wird ein Fehler auftreten und im Codebook dokumentiert, weil die Daten nicht mit meiner Original-Signatur versehen sind. Dieser Fehler hat jedoch keine Auswirkungen auf die Funktionalität und hindert die Kompilierung nicht.

#+ eval = FALSE

rmarkdown::render(input = "AZ-BRD_Source_CodebookCreation.R",
                  output_file = "AZ-BRD_1-0-1_Codebook.pdf",
                  envir = new.env())




#'\newpage
#+
#'# Parameter

#+
#'## Name des Datensatzes
datasetname <- "AZ-BRD"


#'## Versionsnummer
version.period <- "1.0.1"



#'## DOI des Datensatz-Konzeptes
doi.concept <- "10.5281/zenodo.4559383" # checked


#'## DOI der konkreten Version
doi.version <- "10.5281/zenodo.4569564" # checked


#'## Verzeichnis für Analyse-Ergebnisse
#' Muss mit einem Schrägstrich enden!
outputdir <- paste0(getwd(), "/ANALYSE/") 




#'## Optionen: Knitr

#+
#'### Code anzeigen
echo  <- TRUE

#'### Warnungen anzeigen
warning <- TRUE

#'### Nachrichten anzeigen
message  <- TRUE

#'### Ausgabe-Format für Diagramme
dev <- c("pdf", "png")

#'### DPI für Raster-Grafiken
dpi <- 300

#'### Ausrichtung von Grafiken im Compilation Report
fig.align <- "center"





#'# Vorbereitung

#+
#'## Datum und Uhrzeit (Beginn)
begin.script <- Sys.time()
print(begin.script)


#'## Versionsnummer für Verwendung in Dateinamen formatieren
version.dash <- gsub("\\.",
                     "-",
                     version.period)


#'## Ordner für Analyse-Ergebnisse erstellen
dir.create(outputdir)


#+
#'## Packages Laden

library(knitr)        # Professionelles Reporting
library(kableExtra)   # Verbesserte Automatisierte Tabellen
library(magick)       # Fortgeschrittene Verarbeitung von Grafiken
library(ggplot2)      # Fortgeschrittene Datenvisualisierung
library(scales)       # Log-Skalen
library(data.table)   # Fortgeschrittene Datenverarbeitung
library(pdftools)     # Verarbeitung von PDF-Dateien
library(doParallel)   # Parallelisierung


#'## Zusätzliche Funktionen einlesen
#' **Hinweis:** Die hieraus verwendeten Funktionen werden jeweils vor der ersten Benutzung in vollem Umfang angezeigt um den Lesefluss zu verbessern.

source("General_Source_Functions.R")



#'## Knitr Optionen setzen
knitr::opts_chunk$set(echo = echo,
                      warning = warning,
                      message = message,
                      fig.path = outputdir,
                      dev = dev,
                      dpi = dpi,
                      fig.align = fig.align)



#'## Vollzitate statistischer Software
knitr::write_bib(c(.packages()),
                 "packages.bib")



#'# Registerzeichen verarbeiten


#+
#'## Handkodierte Informationen einlesen

regz.source <- fread("AZ-BRD_Source_Registerzeichen_Handkodiert.csv")


table.regz <- regz.source[order(stelle, zeichen_original)]




#'## Versionsnummer einfügen

table.regz$version <- rep(version.period,
                          table.regz[,.N])



#'## DOIs einfügen

table.regz$doi_concept <- rep(doi.concept,
                          table.regz[,.N])

table.regz$doi_version <- rep(doi.version,
                          table.regz[,.N])





#'## Registerzeichen speichern

fwrite(table.regz,
       paste(datasetname,
             version.dash,
             "DE_Registerzeichen_Datensatz.csv",
             sep = "_"),
       na = "NA")






#'# Originalquellen verarbeiten


#' **Hinweis:** Das Datum in den Dateinamen bezieht sich jeweils auf den Tag der Zeichnung durch den/die Präsident:in. Die Aktenordnung des BGH wird aber auch vom Generalbundesanwalt gegengezeichnet und korrekterweise wären beide Daten zu zitieren.


akto.bgh1 <- "./Quellen_Original/AktOBGH_Änderungen_1986-bis-1996.pdf"

pdf_subset(akto.bgh1,
           1:2,
           "AktOBGH_1996-02-27_Änderung.pdf")

pdf_subset(akto.bgh1,
           3:3,
           "AktOBGH_1991-10-25_Änderung.pdf")

pdf_subset(akto.bgh1,
           4:4,
           "AktOBGH_1991-03-07_Änderung.pdf")

pdf_subset(akto.bgh1,
           5:7,
           "AktOBGH_1988-06-28_Änderung.pdf")

pdf_subset(akto.bgh1,
           8:9,
           "AktOBGH_1986-05-23_Änderung.pdf")



akto.bgh2 <- "./Quellen_Original/AktOBGH_Änderungen_2005-bis-2012.pdf"

pdf_subset(akto.bgh2,
           1:1,
           "AktOBGH_2012-01-31_Änderung.pdf")


pdf_subset(akto.bgh2,
           2:3,
           "AktOBGH_2010-02-26_Änderung.pdf")

pdf_subset(akto.bgh2,
           4:5,
           "AktOBGH_2007-11-23_Änderung.pdf")


pdf_subset(akto.bgh2,
           6:10,
           "AktOBGH_2005-02-13_Änderung.pdf")




file.copy("./Quellen_Original/AktOBGH_1955-12-22_Neufassung.pdf",
          "./")


pdf_combine(c("./Quellen_Original/AktOBGH_1984-11-01_Neufassung_Teil1.pdf",
              "./Quellen_Original/AktOBGH_1984-11-01_Neufassung_Teil2.pdf"),
            "AktOBGH_1984-11-01_Neufassung.pdf")









#'# Frequenztabellen erstellen

#+
#'## Funktion anzeigen

#+ results = "asis"
print(f.fast.freqtable)



#'## Liste zu prüfender Variablen

varlist  <-  c("stelle",
               "position")


print(varlist)



#'## Frequenztabellen erstellen

prefix <- paste0(datasetname,
                 "_01_Frequenztabelle_var-")


#+ results = "asis"
f.fast.freqtable(table.regz,
                 varlist = varlist,
                 sumrow = TRUE,
                 output.list = FALSE,
                 output.kable = TRUE,
                 output.csv = TRUE,
                 outputdir = outputdir,
                 prefix = prefix)








#'# Frequenztabellen visualisieren

#'## Präfix erstellen

prefix <- paste0("ANALYSE/",
                 datasetname,
                 "_01_Frequenztabelle_var-")


#'## Tabellen einlesen

table.stelle <- fread(paste0(prefix,
                                 "stelle.csv"))

table.position <- fread(paste0(prefix,
                                "position.csv"))


#'\newpage
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





#'\newpage
#+
#'## Nach Position

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








#'# Erstellen der ZIP-Archive

#'## Verpacken der Originaldateien

source.original <- "Quellen_Original"

zip(paste(datasetname,
      version.dash,
      "DE_Quellen_Original.zip",
      sep = "_"),
    source.original)


unlink(source.original, recursive = TRUE)



#'## Verpacken der Lesefassungen

source.reading <- list.files(pattern = "AktOBGH")

zip(paste(datasetname,
      version.dash,
      "DE_Quellen_Lesefassungen.zip",
      sep = "_"),
    source.reading)


unlink(source.reading)



#'## Verpacken der Analyse-Dateien

zip(paste0(datasetname,
           "_",
           version.dash,
           "_DE_",
           basename(outputdir),
           ".zip"),
    basename(outputdir))



#'## Verpacken der Source-Dateien

source.code  <- c(list.files(pattern = "Source"),
                  "buttons")


source.code <- grep("spin",
                     source.code,
                     value = TRUE,
                     ignore.case = TRUE,
                     invert = TRUE)

zip(paste(datasetname,
          version.dash,
           "Source_Files.zip",
           sep = "_"),
    source.code)










#'# Kryptographische Hashes
#' Dieses Modul berechnet für jedes ZIP-Archiv zwei Arten von Hashes: SHA2-256 und SHA3-512. Mit diesen kann die Authentizität der Dateien geprüft werden und es wird dokumentiert, dass sie aus diesem Source Code hervorgegangen sind. Die SHA-2 und SHA-3 Algorithmen sind äußerst resistent gegenüber *collision* und *pre-imaging* Angriffen, sie gelten derzeit als kryptographisch sicher. Ein SHA3-Hash mit 512 bit Länge ist nach Stand von Wissenschaft und Technik auch gegenüber quantenkryptoanalytischen Verfahren unter Einsatz des *Grover-Algorithmus* hinreichend resistent.

#+
#'## Liste der ZIP-Archive erstellen
files.hash <- c(list.files(pattern= "\\.zip$",
                           ignore.case = TRUE),
                list.files(pattern= "Registerzeichen_Datensatz",
                           ignore.case = TRUE))


#'## Funktion anzeigen
#+ results = "asis"
print(f.dopar.multihashes)

#'## Hashes berechnen
multihashes <- f.dopar.multihashes(files.hash)


#'## In Data Table umwandeln
setDT(multihashes)



#'## Index hinzufügen
multihashes$index <- seq_len(multihashes[,.N])


#'## In Datei schreiben
fwrite(multihashes,
       paste(datasetname,
             version.dash,
             "KryptographischeHashes.csv",
             sep = "_"),
       na = "NA")


#'## Leerzeichen hinzufügen um Zeilenumbruch zu ermöglichen
multihashes$sha3.512 <- paste(substr(multihashes$sha3.512, 1, 64),
                              substr(multihashes$sha3.512, 65, 128))


#'\newpage
#'## In Bericht anzeigen

kable(multihashes[,.(index,filename)],
      format = "latex",
      align = c("p{1cm}",
                "p{13cm}"),
      booktabs = TRUE,
      longtable = TRUE)


kable(multihashes[,.(index,sha2.256)],
      format = "latex",
      align = c("c",
                "p{13cm}"),
      booktabs = TRUE,
      longtable = TRUE)


#'\newpage

kable(multihashes[,.(index,sha3.512)],
      format = "latex",
      align = c("c",
                "p{13cm}"),
      booktabs = TRUE,
      longtable = TRUE)





#'# Abschluss




#'## Datum und Uhrzeit (Ende)
end.script <- Sys.time()
print(end.script)

#'## Laufzeit des gesamten Skriptes
print(end.script - begin.script)


#'## Warnungen
warnings()



#'# Parameter für strenge Replikationen

system2("openssl", "version", stdout = TRUE)

sessionInfo()


#'# Literaturverzeichnis

