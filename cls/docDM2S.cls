%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Official DM2S \latex Template
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier  : docDM2S.cls
%% Auteur   : Philippe Fillion
%% Auteur   : Fabrice Gaudier
%% Création : 20/02/2003
%% Revision : 1.13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10/2019 Correct Bug for titlesec 2.10.1, see bugtracker.
%% 07/2018
%%    - ajout de l'option ``endfloat'' pour qu'il n y ait pas de conflit avec LastPage
%%    - ajout de controle sur le mot clef diffusion : erreur si pas dans la liste des disponibles
%%    - externalisation de la hierarchie et mise a jour de celle ci
%%    - ajout de l'option ``nodiff'' pour pouvoir mettre la liste de diffusion dans l'ordre voulu (personnalisation a l'extreme)
%% 03/01/2018 v1.13 by Jean-Baptiste Blanchard, Daniele Tomatis
%%    - fix sommaire anglais/francais
%%    - possibilit\'e d'avoir jusqu'\`a 4 reviewers
%%    - ajout option ansi si les fichiers sont pas UTF-8 mais en iso-8859-1
%%    - update hierarchie et structure du d\'epartement
%%    - mise a jour du format avec code barre
%%    - correction version anglaise
%%    - uniformisation du cartouche sup`'erieur pour toutes les pages
%%      (premi\`ere, page \`a tableau et corps du texte)
%% 12/02/2013 : Police par défaut Helvetica/Arial
%% 15/01/2013 v3.0 : Application des nouvelles procedures DEN + Audit DEN juillet 2012 + Ajout notion Note Technique (NT)
%% 05/12/2011 : remplacement du SFME par STMF
%% 15/06/2010 v2.0 Mise \`a jour de la nouvelle maquette
%%                   - 2 vérificateurs possibles (Li Leimoa)
%%                   - option "english" ajouté
%%                   - +++
%% 09/09/2005 v1.2 Mise \`a jour avec entre autre,
%%                        - style de compilation article(défaut)|report|book,
%%                        - inclusion de DANS,
%%                        - passage \`a 8 auteurs maxi
%%                        - style PU (Publication) presque opérationnel ( a part la derni\`ere page)
%% 20/02/2003 v1.1 Création de la class docDM2S.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Identification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ClassVersion{D}
\def\filedate{2019/06/01}
\def\docdate {2019/06/01}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{docDM2S}[\filedate\space v\ClassVersion\space Document DM2S categorie \ClassVersion]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Mode de compilation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@sPDF
\ifx\pdfoutput\undefined
  \dm@sPDFfalse                        %% mode : LaTeX
\else
  \ifnum \pdfoutput=0                     %% mode : LaTeX
    \dm@sPDFfalse
  \else
    \pdfoutput=1                     %% mode : PDFLaTeX
    \dm@sPDFtrue
  \fi
\fi 



%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables Globales
%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@ScoreAQ
\dm@s@ScoreAQ = \z@
\newcount\dm@s@MaxScoreAQ
\dm@s@MaxScoreAQ  = 8



%%%%%%%%%%%%%%%%%%%%%%
%% Relecteur/Verificateur
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@numberVerificateur
\dm@s@numberVerificateur = \z@

\def\dm@s@SetVerificateur@#1#2{%
  \ifcase\dm@s@numberVerificateur
  \or \or
  \def\dm@s@verificateurAName{#1}
  \def\dm@s@verificateurAFunction{#2}
  \def\dm@s@verificateurALabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire}
  \or
  \def\dm@s@verificateurBName{#1}
  \def\dm@s@verificateurBFunction{#2}
  \def\dm@s@verificateurBLabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire}
  \or
  \def\dm@s@verificateurCName{#1}
  \def\dm@s@verificateurCFunction{#2}
  \def\dm@s@verificateurCLabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire}
  \or
  \def\dm@s@verificateurDName{#1}
  \def\dm@s@verificateurDFunction{#2}
  \def\dm@s@verificateurDLabotory{\dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire}
  \fi
}


\def\dm@s@AddVerificateur#1#2{%
  \ifnum\dm@s@numberVerificateur = 0
    \global\advance\dm@s@ScoreAQ\@ne
  \fi
  \ifnum\dm@s@numberVerificateur <5 %
    \global\advance\dm@s@numberVerificateur\@ne
    \dm@s@SetVerificateur@{#1}{#2}
  \else
    \PackageError{Classe docDM2S}{ 4 'Verificateur' maximum}%
  \fi
}

%% API Utilisateur

 \def\setverificateur#1#2{%
  \dm@s@AddVerificateur{#1}{#2}}
\def\addverificateur#1#2{%
  \dm@s@AddVerificateur{#1}{#2}}

\def\setrelecteur#1{%
  \setverificateur{#1}{}}

%%%%%%%%%%%%%%%%%%%%%%
%% Autre Visa
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@NbVisa
\dm@s@NbVisa = \z@

\def\setvisa#1#2{%
  \ifnum\dm@s@NbVisa < 2 %
    \global\advance\dm@s@NbVisa\@ne
    \def\dm@s@visaName{#1}
    \def\dm@s@visaFunction{#2}
  \else
    \PackageError{Classe docDM2S}{ 1 'Autre Visa' maximum}%
  \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Option du document %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Barcode
\newif\ifdm@sCodeBarre
\dm@sCodeBarrefalse
%% List of figures
\newif\ifdm@s@haveListOfFigures
\dm@s@haveListOfFigurestrue
%% List of tables
\newif\ifdm@s@haveListOfTables
\dm@s@haveListOfTablestrue
%% Timbre (Restreinte, Confidentiel
\newif\ifdm@s@haveTimbre
\dm@s@haveTimbretrue
%% le document est-il date 
\newif\ifdm@s@haveNotDated
\dm@s@haveNotDatedtrue
%% Diffusion externe au DM2S
\newif\ifdm@s@haveReferenceExterne
\dm@s@haveReferenceExternefalse
%% Contient un resume
\newif\ifdm@s@haveResume
\dm@s@haveResumefalse
%% Contient un numero chrono
\newif\ifdm@s@haveNumeroChrono
\dm@s@haveNumeroChronofalse
\def\dm@s@defaultNumeroChrono{XX-YYY}
%% Contient un resume DO 
\newif\ifdm@s@haveResumeDO
\dm@s@haveResumeDOfalse
%% Contient un resume anglais
\newif\ifdm@s@haveResumeAnglais
\dm@s@haveResumeAnglaisfalse
\def\dm@s@diffusionFlag{}
%% Niveau de Diffusion : Normale (default : true)
\newif\ifdm@s@DiffusionNormale
\dm@s@DiffusionNormaletrue
%% Niveau de Diffusion : Restreinte (default : false) 
\newif\ifdm@s@DiffusionRestreinte
\dm@s@DiffusionRestreintefalse
%% Niveau de Diffusion : CCEA (default : false) 
\newif\ifdm@s@DiffusionCCEA
\dm@s@DiffusionCCEAfalse
%% Niveau de Diffusion : CD (default : false) 
\newif\ifdm@s@DiffusionCD
\dm@s@DiffusionCDfalse
%% Niveau de Diffusion : SD (default : false) 
\newif\ifdm@s@DiffusionSD
\dm@s@DiffusionSDfalse
%% Contient les références de l'action (Partenaire/Accord/type)
\newif\ifdm@s@havereferenceaction
\dm@s@havereferenceactionfalse
%% Contient les informations  jalon
\newif\ifdm@s@haveJalon
\dm@s@haveJalonfalse
%% Contient le delai contractuel de Confidentialité
\newif\ifdm@s@haveDelaiConfidentialite
\dm@s@haveDelaiConfidentialitefalse

%% Contient un numero de Cahier de Laboratoire
\newif\ifdm@s@haveCahierLaboratoire
\dm@s@haveCahierLaboratoirefalse

\newif\ifdm@s@isSpecialFrance
\dm@s@isSpecialFrancefalse
\DeclareOption{france}{%
  \dm@s@isSpecialFrancetrue
}

%%
%% OLD
%%
\newif\ifdm@s@havenumeropublication
\dm@s@havenumeropublicationfalse
\newif\ifdm@s@h@veind@ce
\dm@s@h@veind@cefalse
\newif\ifdm@s@haveMotsClefs
\dm@s@haveMotsClefsfalse
\newif\ifdm@s@havedob
\dm@s@havedobfalse
\newif\ifdm@s@haveprojet
\dm@s@haveprojetfalse
\newif\ifdm@s@haveeotp
\dm@s@haveeotpfalse

\input{hierarchie}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Nature du document          %%
%%  rt : Rapport Technique     %%
%%  st : Spéfication technique %%
%%  nt : Note technique        %%
%%  pu : Publication           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@setTypeDocument#1#2{%
  \def\dm@s@typeDocument{#1}%
  \def\dm@s@abrTypeDocument{#2}}

\newif\ifdm@s@isNote
\dm@s@isNotefalse
\newif\ifdm@s@isRapport
\dm@s@isRapportfalse
\newif\ifdm@s@isSpecification
\dm@s@isSpecificationfalse
\newif\ifdm@s@isPublication
\dm@s@isPublicationfalse
\newif\ifdm@s@isDocbook
\dm@s@isDocbookfalse

\DeclareOption{nt}{
  \dm@s@setTypeDocument{Note Technique}{NT}
  \dm@s@isNotetrue}

\DeclareOption{rt}{
  \dm@s@setTypeDocument{Rapport Technique}{RT}
  \dm@s@isRapporttrue}

\DeclareOption{st}{
  \dm@s@setTypeDocument{Sp\'ecification}{ST}
  \dm@s@isSpecificationtrue}

\DeclareOption{pu}{
  \dm@s@setTypeDocument{PUBLICATION}{PU}
  \dm@s@isPublicationtrue}

\DeclareOption{docbook}{
  \dm@s@isDocbooktrue
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% mode de compilation            %%
%%   article ( valeur par défaut) %%
%%   report                       %%
%%   book                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isArticle
\dm@s@isArticletrue
\newif\ifdm@s@isReport
\dm@s@isReportfalse
\newif\ifdm@s@isBook
\dm@s@isBookfalse

\DeclareOption{article}{
  \dm@s@isArticletrue}

\DeclareOption{report}{
  \dm@s@isReporttrue
  \dm@s@isArticlefalse}

\DeclareOption{book}{
  \dm@s@isBooktrue
  \dm@s@isArticlefalse}


\newif\ifdm@s@useEndFloat
\dm@s@useEndFloatfalse
\DeclareOption{endfloat}{
  \dm@s@useEndFloattrue
}

\newif\ifdm@s@useDefaultDiffusion
\dm@s@useDefaultDiffusiontrue
\DeclareOption{nodiff}{
  \dm@s@useDefaultDiffusionfalse
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Etat "Projet" du doc    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isDraft
\dm@s@isDraftfalse

\ifdm@sPDF
  \PassOptionsToPackage{pdftex}{graphicx}
\else
  \PassOptionsToPackage{dvips}{graphicx}
\fi

\DeclareOption{projet}{
  \dm@s@isDrafttrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gestion des options graphiques %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% option draft : passe l'option draft \`a graphicx 
%%  - les graphiques sont remplacés par des rectangles
%%      avec le nom du fichier
\DeclareOption{draft}{%
  \setlength{\overfullrule}{5mm}
  \ifdm@sPDF
    \PassOptionsToPackage{draft}{graphicx}
  \else
    \PassOptionsToPackage{draft}{graphicx}
  \fi}

%% option final : passe l'option final \`a graphicx 
\DeclareOption{final}{%
  \ifdm@sPDF
    \PassOptionsToPackage{final}{graphicx}
  \else
    \PassOptionsToPackage{final}{graphicx}
  \fi}

\newif\ifdm@s@burlot
\dm@s@burlotfalse
\DeclareOption{burlot}{
  \dm@s@burlottrue}

\newif\ifdm@s@frbib
\dm@s@frbibfalse
\DeclareOption{frbib}{
  \dm@s@frbibtrue
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% langue English          %%
%%     (french par defaut) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isEnglish
\dm@s@isEnglishfalse

\DeclareOption{english}{
  \dm@s@isEnglishtrue}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% langue Ansi          %%
%%     (utf8 par defaut) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@isAnsi
\dm@s@isAnsifalse

\DeclareOption{ansi}{
  \dm@s@isAnsitrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options inactive     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \PackageWarning{12pt}{Option '\CurrentOption' inconnue}
%% \DeclareOption{12pt}{\OptionNotUsed}
%% \PackageWarning{docDM2S}{'\CurrentOption' inactive. Les cadres sont faits pour du 11pt}}
\newif\ifdm@s@isLongTable
\dm@s@isLongTablefalse

\DeclareOption{longtable}{
  \dm@s@isLongTabletrue
}

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options par défaut        %%
%%   11pt, a4paper, twoside  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifdm@s@isArticle
  \LoadClass[11pt,a4paper,twoside]{article}
\fi
\ifdm@s@isReport
  \LoadClass[11pt,a4paper,twoside]{report}
\fi
\ifdm@s@isBook
  \LoadClass[11pt,a4paper,twoside]{book}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Déclarations préliminaires %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifdm@s@isEnglish
\RequirePackage[english]{babel}        %% met les différentes étiquettes  en anglais
\else
\RequirePackage[francais]{babel}        %% met les différentes étiquettes  en français
\ifdm@s@frbib
\RequirePackage[fixlanguage]{babelbib}
\selectbiblanguage{french}
\fi
\fi

\ifdm@s@isAnsi
\RequirePackage[ansinew]{inputenc}
\else
\RequirePackage[utf8x]{inputenc}
\fi

% Daniele: the previous commands do not seem loading all characters with accents used in the example tex file. The following avoids a warning.
\ifdm@s@isEnglish
% pass
\else
\RequirePackage[T1]{fontenc}
\fi

\ifdm@s@isDocbook
\RequirePackage[innerbars,traceon]{changebar} %%% mod by JBB
\else
\RequirePackage[scaled=.9]{helvet}
\RequirePackage{titlesec}
\@ifpackagelater{titlesec}{2016/03/21}{%
  % Package titlesec is on version 2.10.2 or higher, nothing to do %
}{%
  % Check if package titlesec is on version 2.10.1 %
  \@ifpackagelater{titlesec}{2016/03/15}{%
    % Package titlesec on version 2.10.1, patch accordingly %
    \RequirePackage{etoolbox}%
    \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
    \patchcmd{\ttlh@hang}{\noindent}{}{}{}%
  }{%
    % Package titlsecon is on version 2.10.0 or lower, nothing to do %
  }%
}
\fi

\RequirePackage{ucs}
\RequirePackage{graphicx}
\RequirePackage{pifont}             %% caract\`ere spécial pour préciser le mode de diffusion
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage{calc}
\RequirePackage{array}
\ifdm@s@useEndFloat
  \usepackage{endfloat}
\fi
\RequirePackage{lastpage}           %% le nombre total de page
\RequirePackage{fancyhdr}
\RequirePackage{mathptmx}
\RequirePackage{courier}
\renewcommand*\familydefault{\sfdefault}
\RequirePackage{ifthen}
\RequirePackage{colortbl}
\ifdm@s@isLongTable
  \RequirePackage{longtable}
  \setlength{\LTleft}{0pt}
\fi
%% Pour la gestion des liens hypertext dans pdf
\ifdm@sPDF
  \RequirePackage[pdftex,breaklinks=true,colorlinks=true,linkcolor=blue,citecolor=blue,urlcolor=blue]{hyperref}
\fi

\AtEndOfClass{\InputIfFileExists{docDM2S.cfg}{\typeout{classe docDM2S : utilise fichier de configuration locale}}{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                               % 
% Begin of Document Compilation %
%                               % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\AtBeginDocument{
  %% ============================
  %% Changer le nom  et centrer : 
  %%    Tables des mati\`eres -> Sommaire
  %%    Tables des figures  -> Liste des figures
  %%    Liste des Tableaux  -> Liste des Tableaux
  %% ============================
  \ifdm@s@isEnglish
    \renewcommand\contentsname{\hfill Table of contents\hfill }
    \renewcommand\listfigurename{\hfill List of FIGURES\hfill }
    \renewcommand\listtablename{\hfill List of TABLES\hfill }
  \else
    \renewcommand\contentsname{\hfill Sommaire\hfill }
    \renewcommand\listfigurename{\hfill Liste des FIGURES\hfill }
    \renewcommand\listtablename{\hfill Liste des TABLEAUX\hfill }
  \fi
  %% ============================
  %% Si pas de valeur 'Indice' alors on met l'indice A
  %% ============================
  \ifnum\dm@s@lastIndice = 0
    \setindiceA{\dm@s@dateCompilation}{\dm@s@defaultNatureIndiceA}
  \fi
  %% ============================
  %% Si pas de valeur 'date alors on met la valeur par defaut
  %% ============================
  \ifdm@s@haveNotDated
    \setdate{\dm@s@dateIndice}
  \fi
  %% ============================
  %% param\`etres graphiques PS/PDF
  %% ============================
  \ifdm@sPDF
    \DeclareGraphicsExtensions{.png,.jpg,.pdf}
    \newcommand\dmurl[1]{\url{#1}}
  \else
    \DeclareGraphicsExtensions{.eps,.ps}
    \newcommand\dmurl[1]{{\small\texttt{#1}}}
  \fi
  %% ============================
  %% Ent\^ete
  %% ============================
  \dm@s@aqmisenpagecategorieB
  \dm@s@clearEmptyDoublePage
  %% ============================
  %% Cas d'une publication
  %% ============================
  \ifdm@s@isPublication
  \else
    %% ============================
    %% Table des mati\`eres
  %% ============================
  \ifdm@s@burlot
  \phantomsection
  \ifdm@s@isEnglish
  \addcontentsline{toc}{section}{Content}
  \else
  \addcontentsline{toc}{section}{Sommaire}
  \fi
  \fi
  \tableofcontents
  \clearpage
    %\vspace{\stretch{5}}   %% | to save space with closer blocks
    %% \dm@s@clearEmptyDoublePage
    %% ============================
    %% Liste des tableaux
    %% ============================
    \ifdm@s@haveListOfTables
      \listoftables
      \clearpage
      %\vspace{\stretch{5}}   %% | to save space with closer blocks
      %% \dm@s@clearEmptyDoublePage
    \fi
    %% ============================
    %% Table des figures
    %% ============================
    \ifdm@s@haveListOfFigures
      \listoffigures
      \clearpage
      %\vspace{\stretch{5}}   %% | to save space with closer blocks
      %%% \dm@s@clearEmptyDoublePage
    \fi
    %%% \dm@s@clearEmptyDoublePage
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%  End of Document Compilation  %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  \AtEndDocument{
    %%%%%%%%%%%%%%%%%%%%%% 
    %% Score AQ
    %%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%    \PackageWarning{Classe docDM2S}{Score AQ \the\dm@s@ScoreAQ/\the\dm@s@MaxScoreAQ}
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%            Options            %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Redéfinition de la mise en page
%%
%%
  \setlength{\oddsidemargin}{-10.4mm}   %%{-0.5in}
  \setlength{\evensidemargin}{-10.4mm}  %%{-0.5in}
  \setlength{\marginparwidth}{0mm}
  \setlength{\topmargin}{-0.80in}
  \setlength{\headheight}{25mm}
  %\setlength{\headheight}{20mm} %%% mod by JBB
  \setlength{\headsep}{10pt}
  \setlength{\textwidth}{180mm}
  \setlength{\textheight}{220mm}
  \setlength{\voffset}{20mm}
  \setlength{\footskip}{15mm}
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%   raccourcis personnelles     %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancyplain}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\renewcommand{\subsectionmark}[1]{\markright{#1}}
                                % champs \`a définir :
                                % ----------------------
\def\dm@s@dateCompilation{\number\day/\number\month/\number\year}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Interface utilisateur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\setCodeBarre#1{
  \def\dm@s@fileCodeBarre{#1}
  \dm@sCodeBarretrue
}
\def\setcodebarre#1{
  \setCodeBarre{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% commandes obligatoires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titre
%%%%%%%%%%%%%%%%%%%%
\def\settitre#1{%
  \global\advance\dm@s@ScoreAQ\@ne
  \gdef\dm@s@titre{#1}}
%%%%%%%%%%%%%%%%%%%%%%
%% Auteurs
%%%%%%%%%%%%%%%%%%%%%%
\def\dm@s@defaultFonctionAuteur{Ing\'enieur-chercheur}
\newcount\dm@s@numberAuteur
\dm@s@numberAuteur = \z@

\newif\ifdm@s@auteurASignature
\dm@s@auteurASignaturetrue
\newif\ifdm@s@auteurBSignature
\dm@s@auteurBSignaturetrue
\newif\ifdm@s@auteurCSignature
\dm@s@auteurCSignaturetrue
\newif\ifdm@s@auteurDSignature
\dm@s@auteurDSignaturetrue
\newif\ifdm@s@auteurESignature
\dm@s@auteurESignaturetrue
\newif\ifdm@s@auteurFSignature
\dm@s@auteurFSignaturetrue
\newif\ifdm@s@auteurGSignature
\dm@s@auteurGSignaturetrue
\newif\ifdm@s@auteurHSignature
\dm@s@auteurHSignaturetrue

\def\dm@s@setAuteur#1#2{%
  \ifcase\dm@s@numberAuteur\or
  \def\dm@s@auteurAName{#1} \def\dm@s@auteurAFunction{#2} \dm@s@auteurASignaturetrue \or
  \def\dm@s@auteurBName{#1} \def\dm@s@auteurBFunction{#2} \dm@s@auteurBSignaturetrue \or
  \def\dm@s@auteurCName{#1} \def\dm@s@auteurCFunction{#2} \dm@s@auteurCSignaturetrue \or
  \def\dm@s@auteurDName{#1} \def\dm@s@auteurDFunction{#2} \dm@s@auteurDSignaturetrue \or
  \def\dm@s@auteurEName{#1} \def\dm@s@auteurEFunction{#2} \dm@s@auteurESignaturetrue \or
  \def\dm@s@auteurFName{#1} \def\dm@s@auteurFFunction{#2} \dm@s@auteurFSignaturetrue \or
  \def\dm@s@auteurGName{#1} \def\dm@s@auteurGFunction{#2} \dm@s@auteurGSignaturetrue \or
  \def\dm@s@auteurHName{#1} \def\dm@s@auteurHFunction{#2} \dm@s@auteurHSignaturetrue \fi
}

\def\dm@s@ajoutAuteur#1#2{%
  \ifnum\dm@s@numberAuteur < 8 %
    \global\advance\dm@s@numberAuteur\@ne
    \dm@s@setAuteur{#1}{#2}
  \else
    \PackageWarning{Classe docDM2S}{8 auteurs maxi}%
  \fi
}

\def\setauteur#1{%
  \dm@s@ajoutAuteur{#1}{\dm@s@defaultFonctionAuteur}
}

\def\setauteurfonction#1#2{%
  \dm@s@ajoutAuteur{#1}{#2}
}
% \def\setauteurunite#1#2{%
%   \dm@s@ajoutAuteur{#1}{\dm@s@defaultFonctionAuteur}
%   \def\dm@s@auteurAUnite
% }

\def\addauteur#1{%
  \dm@s@ajoutAuteur{#1}{\dm@s@defaultFonctionAuteur}
}
\def\addauteurfonction#1#2{%
  \dm@s@ajoutAuteur{#1}{#2}
}


\def\dm@s@setAuteurSansSignature#1{%
  \ifcase\dm@s@numberAuteur\or
  \def\dm@s@auteurAName{#1} \dm@s@auteurASignaturefalse \or
  \def\dm@s@auteurBName{#1} \dm@s@auteurBSignaturefalse \or
  \def\dm@s@auteurCName{#1} \dm@s@auteurCSignaturefalse \or
  \def\dm@s@auteurDName{#1} \dm@s@auteurDSignaturefalse \or
  \def\dm@s@auteurEName{#1} \dm@s@auteurESignaturefalse \or
  \def\dm@s@auteurFName{#1} \dm@s@auteurFSignaturefalse \or
  \def\dm@s@auteurGName{#1} \dm@s@auteurGSignaturefalse \or
  \def\dm@s@auteurHName{#1} \dm@s@auteurHSignaturefalse \fi
}


\def\dm@s@ajoutAuteurSansSignature#1{%
  \ifnum\dm@s@numberAuteur < 8 %
    \global\advance\dm@s@numberAuteur\@ne
    \dm@s@setAuteurSansSignature{#1}
  \else
    \PackageWarning{Classe docDM2S}{8 auteurs maxi}%
  \fi
}
\def\setauteursanssignature#1{
  \dm@s@ajoutAuteurSansSignature{#1}
}
\def\addauteursanssignature#1{
  \dm@s@ajoutAuteurSansSignature{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commandes facultatives             %%
%%   au sens de la compilation LaTeX  %%
%%   mais obligatoire pour l'AQ       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%   Numero chrono
%%%%%%%%%%%%%%%%%%%%%%   
\def\setnumero#1{
  \global\advance\dm@s@ScoreAQ\@ne
  \dm@s@haveNumeroChronotrue
  \def\dm@s@numeroChrono{#1}}

%%%%%%%%%%%%%%%%%%%%%% 
%% Numero de publication (PU)
%%%%%%%%%%%%%%%%%%%%%% 
\def\setnumeropublication#1{
  \ifdm@s@isPublication
    \dm@s@havenumeropublicationtrue
    \def\dm@s@numeropublication{#1}
  \else
    \ClassWarning{docDM2S}{** le numero de publication est valable que pour une PUBLICATION **.}
  \fi}

%%%%%%%%%%%%%%%%%%%%%%
%% Gestion des indices
%%%%%%%%%%%%%%%%%%%%%%
\newcount\dm@s@lastIndice
\dm@s@lastIndice  = \z@

\def\dm@s@indice{--}
\def\dm@s@dateIndice{--/--/--}

\def\dm@s@setIndice#1#2{
  \def\dm@s@indice{#1}
  \def\dm@s@dateIndice{#2}}



\def\d@teind@ce@{--/--/--}
\def\d@teind@ce@@{--/--/--}
\def\d@teind@ce@@@{--/--/--}
\def\d@teind@ce@@@@{--/--/--}
\def\d@teind@ce@@@@@{--/--/--}
\def\l@gind@ce@{ ---   non d\'efini ----}
\def\l@gind@ce@@{ ---   non d\'efini ----}
\def\l@gind@ce@@@{ ---   non d\'efini ----}
\def\l@gind@ce@@@@{ ---   non d\'efini ----}
\def\l@gind@ce@@@@@{ ---   non d\'efini ----}

\def\dm@s@defaultNatureIndiceA{Document initial}
\def\dm@s@PagesModifieesB{Tout le document}
\def\dm@s@PagesModifieesC{Tout le document}
\def\dm@s@PagesModifieesD{Tout le document}
\def\dm@s@PagesModifieesE{Tout le document}


%% Indice A
\def\setindiceA#1#2{%
  \ifnum\dm@s@lastIndice<1
    \dm@s@lastIndice = 1
    \dm@s@setIndice{A}{#1}
  \else
    \PackageError{Classe docDM2S}{Indice A deja defini avec pour date("\d@teind@ce@") et nature ("\l@gind@ce@") }%
  \fi
  \def\d@teind@ce@{#1}
  \def\l@gind@ce@{#2}}

\def\setindiceAdate#1{%
  \setindiceA{#1}{\dm@s@defaultNatureIndiceA}}

\def\setindiceAnature#1{%
  \setindiceA{\dm@s@dateCompilation}{#1}}

\def\setindiceAlog#1{%
  \PackageWarning{Classe docDM2S}{Deprecated method "setindiceAlog" : use "setindiceAnature" method}
  \setindiceAnature{#1}}


%% Indice B
\def\setindiceB#1#2{%
  \ifnum\dm@s@lastIndice<2
    \dm@s@lastIndice = 2
    \dm@s@setIndice{B}{#1}
  \else
    \PackageError{Classe docDM2S}{Indice B deja defini avec pour date("\d@teind@ce@@") et nature ("\l@gind@ce@@") }%
  \fi
  \def\d@teind@ce@@{#1}
  \def\l@gind@ce@@{#2}}

\def\setindiceBall#1#2#3{%
  \setindiceB{#1}{#2}%
  \def\dm@s@PagesModifieesB{#3}}

\def\setindiceBnature#1{%
  \setindiceB{\dm@s@dateCompilation}{#1}}

\def\setindiceBlog#1{%
  \PackageWarning{Classe docDM2S}{Deprecated method "setindiceBlog" : use "setindiceBnature" method}
  \setindiceBnature{#1}}

%% Indice C
\def\setindiceC#1#2{%
  \ifnum\dm@s@lastIndice<3
    \dm@s@lastIndice = 3
    \dm@s@setIndice{C}{#1}
  \else
    \PackageError{Classe docDM2S}{Indice C deja defini avec pour date("\d@teind@ce@@@") et nature ("\l@gind@ce@@@") }%
  \fi
  \def\d@teind@ce@@@{#1}
  \def\l@gind@ce@@@{#2}}

\def\setindiceCall#1#2#3{%
  \setindiceC{#1}{#2}%
  \def\dm@s@PagesModifieesC{#3}}

\def\setindiceCnature#1{%
  \setindiceC{\dm@s@dateCompilation}{#1}}

\def\setindiceClog#1{%
  \PackageWarning{Classe docDM2S}{Deprecated method "setindiceClog" : use "setindiceCnature" method}
  \setindiceCnature{#1}}

%% Indice C
\def\setindiceD#1#2{%
  \ifnum\dm@s@lastIndice<4
    \dm@s@lastIndice = 4
    \dm@s@setIndice{D}{#1}
  \else
    \PackageError{Classe docDM2S}{Indice D deja defini avec pour date("\d@teind@ce@@@@") et nature ("\l@gind@ce@@@@") }%
  \fi
  \def\d@teind@ce@@@@{#1}
  \def\l@gind@ce@@@@{#2}}

\def\setindiceDall#1#2#3{%
  \setindiceD{#1}{#2}%
  \def\dm@s@PagesModifieesD{#3}}

\def\setindiceDnature#1{%
  \setindiceD{\dm@s@dateCompilation}{#1}}

\def\setindiceDlog#1{%
  \PackageWarning{Classe docDM2S}{Deprecated method "setindiceDlog" : use "setindiceDnature" method}
  \setindiceDnature{#1}}

%% Indice E
\def\setindiceE#1#2{%
  \ifnum\dm@s@lastIndice<5
    \dm@s@lastIndice = 5
    \dm@s@setIndice{E}{#1}
  \else
    \PackageError{Classe docDM2S}{Indice E deja defini avec pour date("\d@teind@ce@@@@@") et nature ("\l@gind@ce@@@@@") }%
  \fi
  \def\d@teind@ce@@@@@{#1}
  \def\l@gind@ce@@@@@{#2}}

\def\setindiceEall#1#2#3{%
  \setindiceE{#1}{#2}%
  \def\dm@s@PagesModifieesE{#3}}

\def\setindiceEnature#1{%
  \setindiceE{\dm@s@dateCompilation}{#1}}

\def\setindiceElog#1{%
  \PackageWarning{Classe docDM2S}{Deprecated method "setindiceElog" : use "setindiceEnature" method}
  \setindiceEnature{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% References
%%   Reference A: interne DM2S
%%   Reference B: pour une autre r\'ef\'erence externe au DM2S (ANDRA, Neptune, ...)
%%%%%%%%%%%%%%%%%%%%%% 
\def\dm@s@ReferenceAName{}
% \def\dm@s@referenceANumber{\dm@s@abrService/\dm@s@abrLaboratoire/\dm@s@abrTypeDocument/\dm@s@numeroChrono/\dm@s@indice}
\def\dm@s@referenceANumber{\dm@s@abrService/\dm@s@abrLaboratoire/\dm@s@abrTypeDocument/\ifdm@s@haveNumeroChrono\dm@s@numeroChrono\else\textcolor{red}{\dm@s@defaultNumeroChrono}\fi/\dm@s@indice}

\def\setreferenceB#1#2{%
  \dm@s@haveReferenceExternetrue
  \def\dm@s@referenceBName{#1}%
  \def\dm@s@referenceBNumber{#2}%
}
%%%%%%%%%%%%%%%%%%%%%%
%% Resume
%%%%%%%%%%%%%%%%%%%%%%
\newlength\dm@s@hauteurResume
\newcommand\setresume[2][12]{%
  \def\dm@s@Resume{#2}
  \setlength\dm@s@hauteurResume{#1 cm}
  \ifdm@s@isSpecification
    \dm@s@haveResumefalse
    \ClassWarning{docDM2S}{** le resume est prohibe pour une SPECIFICATION **.}%
  \else
    \dm@s@haveResumetrue
  \fi
}

\def\setresumeDO#1{%
  \ifdm@s@DiffusionNormale
    \ClassWarning{docDM2S}{** pas de resumeDO pour une diffusion normale **.}%
  \else
    \dm@s@haveResumeDOtrue
    \def\dm@s@resumeDO{#1}
  \fi}

\def\setresumeanglais#1{%
  \dm@s@haveResumeAnglaistrue
  \def\dm@s@resumeAnglais{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionInterne
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@havediffusioninterne
\dm@s@havediffusioninternefalse
\def\setdiffusioninterne#1{%
  \dm@s@havediffusioninternetrue
  \def\dm@s@DiffusionInterne{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionExterne
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@havediffusionexterne
\dm@s@havediffusionexternefalse
\def\setdiffusionexterne#1{%
  \dm@s@havediffusionexternetrue
  \def\dm@s@DiffusionExterne{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% DiffussionResume
%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdm@s@haveDiffusionResume
\dm@s@haveDiffusionResumefalse
\def\setdiffusionresume#1{%
  \dm@s@haveDiffusionResumetrue
  \def\dm@s@DiffusionResume{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Most cles
%%%%%%%%%%%%%%%%%%%%%%
\def\setmotscles#1{%
  \dm@s@haveMotsClefstrue
  \def\dm@s@MotsClefs{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Parteanires/clients
%% References Acoord/contrat
%% Type Action
%%%%%%%%%%%%%%%%%%%%%%
\def\setreferencesaction#1#2#3{%
  \dm@s@havereferenceactiontrue
  \def\dm@s@partenaires{#1}
  \def\dm@s@referenceAccord{#2}
  \def\dm@s@typeAction{#3}}

%%%%%%%%%%%%%%%%%%%%%%
%% DOB/Programme
%%%%%%%%%%%%%%%%%%%%%%
\def\setaffaire#1#2{%
  \dm@s@havedobtrue
  \gdef\dm@s@DOB{#1}
  \gdef\dm@s@ProgrammeName{#2}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Nom du projet
%%%%%%%%%%%%%%%%%%%%%%
\def\setprojet#1{%
  \dm@s@haveprojettrue
  \gdef\dm@s@ProjetName{#1}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Num\'ero EOTP
%%%%%%%%%%%%%%%%%%%%%%
\def\seteotp#1{%
  \dm@s@haveeotptrue
  \gdef\dm@s@EOTP{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% References internes CEA                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newif\ifdm@s@havereferenceinterne
\dm@s@havereferenceinternefalse
\def\setreferencesinterne#1#2#3#4{%
  \dm@s@havereferenceinternetrue
  \gdef\dm@s@DOB{#1}
  \gdef\dm@s@ProgrammeName{#2}
  \gdef\dm@s@ProjetName{#3}
  \gdef\dm@s@EOTP{#4}
}


%%%%%%%%%%%%%%%%%%%%%%
%% JALON
%%%%%%%%%%%%%%%%%%%%%%
\def\setjalon#1#2{%
  \dm@s@haveJalontrue
  \def\dm@s@jalonName{#1}
  \def\dm@s@jalonTitle{#2}
}

%%%%%%%%%%%%%%%%%%%%%% 
%% Delai de Confidentialit\'e
%%%%%%%%%%%%%%%%%%%%%% 
\def\setdelaiconfidentialite#1{%
  \dm@s@haveDelaiConfidentialitetrue
  \def\dm@s@delaiConfidentialite{#1}
}

%%%%%%%%%%%%%%%%%%%%%% 
%% Cahier de Laboratoire
%%%%%%%%%%%%%%%%%%%%%% 
\def\setcahierlaboratoire#1{%
  \dm@s@haveCahierLaboratoiretrue
  \def\dm@s@cahierLaboratoire{#1}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Date officielle
%%%%%%%%%%%%%%%%%%%%%%
\def\setdate#1{%
  \dm@s@haveNotDatedfalse
  \def\dm@s@dateOfficielle{#1}}

%%%%%%%%%%%%%%%%%%%%%%
%% Niveau de diffusion
%%%%%%%%%%%%%%%%%%%%%%

\def\dm@s@putDingDiffusion#1{#1 \hspace{15mm} {\large{\ding{56}}} \hspace{15mm}\fi}

\newif\ifdm@s@isDiffusionNotFound
\dm@s@isDiffusionNotFoundtrue

\def\setdiffusion#1{
  \ifthenelse{\equal{#1}{ordinaire}}{\dm@s@DiffusionNormaletrue%
    \dm@s@isDiffusionNotFoundfalse}{\dm@s@DiffusionNormalefalse}
  \ifthenelse{\equal{#1}{restreinte}}{\dm@s@DiffusionRestreintetrue%%
    \dm@s@isDiffusionNotFoundfalse
    \def\dm@s@diffusionFlag{/DR}
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
    \fi}{\dm@s@DiffusionRestreintefalse}
  \ifthenelse{\equal{#1}{CEA}}{\dm@s@DiffusionCCEAtrue%%
    \dm@s@isDiffusionNotFoundfalse
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
    \fi}{\dm@s@DiffusionCCEAfalse}
  \ifthenelse{\equal{#1}{CD}}{\dm@s@DiffusionCDtrue%%
    \dm@s@isDiffusionNotFoundfalse
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
    \fi}{\dm@s@DiffusionCDfalse}
  \ifthenelse{\equal{#1}{SD}}{\dm@s@DiffusionSDtrue%%
    \dm@s@isDiffusionNotFoundfalse
    \ifdm@s@haveResumeDO
    \else
    \setresumeDO{\textcolor{red}{\footnotesize R\'esum\'e DO \`a r\'ediger via la commande \textbackslash setresumeDO\{\}}}
    \fi}{\dm@s@DiffusionSDfalse}

  % \AND \not{\equal{#1}{restreinte}} \AND \not{\equal{#1}{CEA}} \AND \not{\equal{#1}{CD}} \AND \not{\equal{#1}{SD}}
  \ifdm@s@isDiffusionNotFound{%
    \PackageError{Classe docDM2S}{setdiffusion: seul ordinaire, restreinte, CEA, CD et SD sont valables... Vous avez mis #1}{}
  }%
  \fi
}

\ifdm@s@DiffusionRestreinte
  \dm@s@DiffusionNormalefalse
\else
  \dm@s@DiffusionNormaletrue
\fi

%%%%%%%%%%%%%%%%%%%%%%
%% Action off 
%%    List figures
%%    List tables
%%    Timbre
%%%%%%%%%%%%%%%%%%%%%%
\def\nolistoffigures{%
  \dm@s@haveListOfFiguresfalse}
\def\nolistoftables{%
  \dm@s@haveListOfTablesfalse}
\def\notimbre{%
  \dm@s@haveTimbrefalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Valeurs par d\'efaut
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% OBLIGATOIRE
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifdm@s@isSpecification
  \else
    \setresume{\textcolor{red}{\Large R\'esum\'e \`a r\'ediger via la commande \textbackslash setresume\{\}.}}
  \fi
  \ifdm@s@isPublication
    \setresumeanglais{\textcolor{red}{\Large R\'esum\'e ANGLAIS \`a r\'ediger via la commande \textbackslash setresumeanglais\{\}.}}
  \fi
  \setmotscles{\textcolor{red}{\Large Mots cl\'es \`a d\'efinir via la commande \textbackslash setmotscles\{\} (5 mots maximum).}}
  \setverificateur{\textcolor{red}{\small \textbackslash setverificateur\{1\}\{2\} --Arg1--}}{\textcolor{red}{\footnotesize --Arg2--}}
  %% \setdiffusion{ordinaire}
  \setreferencesinterne{\textcolor{red}{\footnotesize \textbackslash setreferencesinterne\{1\}\{2\}\{3\}\{4\}}}{\textcolor{red}{\footnotesize --Arg2--}}{\textcolor{red}{\footnotesize --Arg3--}}{\textcolor{red}{\footnotesize --Arg4--:X-XXXX-YY-ZZ-UU-VZ}}


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% FACAULTATIF
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   \setreferencesaction{\textcolor{green}{\footnotesize \textbackslash setreferencesaction\{1\}\{2\}\{3\}--Arg1--}}{\textcolor{green}{\footnotesize --Arg2-- Demander au chef de projet}}{\textcolor{green}{\footnotesize --Arg3-- Demander au chef de projet}}
%     \setjalon{\textcolor{green}{{\footnotesize \textbackslash setjalon\{1\}\{2\}--Arg1--}}}{\textcolor{green}{\footnotesize --Arg2--}}
%     \setdelaiconfidentialite{\textcolor{green}{{\footnotesize \textbackslash setdelaiconfidentialite\{DELAI\}}}}
%     \setcahierlaboratoire{\textcolor{green}{{\footnotesize \textbackslash setcahierlaboratoire\{NUMERO\}}}}
%    \setvisa{\textcolor{green}{\textbackslash setvisa\{\}\{\}---Arg~1---}}{\textcolor{green}{---Arg~2---}}

 %% 
 %%  
 %%  ____________________________________________________________________________ 
 %% |                                                                            | 
 %% |                  Red\'efinition de la mise en page                         | 
 %% |____________________________________________________________________________| 
 %%
 %%  version sous Assurance Qualit\'e
 %%
 \def\dm@s@aqmisenpagecategorieB{%
%    \setlength{\unitlength}{1mm}


%  \setlength{\textwidth}{180mm}

%    \setlength{\textheight}{207mm}
%    
%    \setlength{\oddsidemargin}{-10.4mm}
%    \setlength{\evensidemargin}{-10.4mm}
%    \setlength{\headsep}{0mm}
%    \setlength{\headheight}{40mm}
   
   %% 
   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                       Ent\^ete et pieds de pages                           |
   %% |____________________________________________________________________________|
   %%
   %%% Grosse Mod by JBB : remove \hspace{6mm} in front of all \raisebox \hspace{-1mm}
   \chead{}
   \rhead{}
   \lhead{\dm@s@cadreHautPage}
   \ifdm@s@isDraft
     \chead{\hspace{-9mm}\raisebox{30mm}[0pt]{\Large{\textcolor{red}{PROJET}}}}
     \ifdm@s@haveTimbre
       \ifdm@s@DiffusionRestreinte
       \chead{\hspace{-9mm}\raisebox{18.2mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{DIFFUSION RESTREINTE}}}}}\\
         \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{12.5mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\ \fi
         \hspace{-9mm}\raisebox{11mm}[0pt]{\textcolor{red}{\textbf{PROJET}}} \\
         \hspace{-9mm}\raisebox{13mm}[0pt]{\textcolor{red}{\textbf{\small Ne pas diffuser sans autorisation de l'\'emetteur}}}}
       \fi
       \ifdm@s@DiffusionCCEA
       \chead{\hspace{-9mm}\raisebox{22.5mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL CEA}}}}}\\
         \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{16mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\ \fi
         \hspace{-9mm}\raisebox{13.5mm}[0pt]{\textcolor{red}{\textbf{PROJET}}}}
       \fi
       \ifdm@s@DiffusionCD
       \chead{\hspace{-9mm}\raisebox{22.5mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL DEFENSE}}}}}\\
         \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{16mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\ \fi
         \hspace{-9mm}\raisebox{13.5mm}[0pt]{\textcolor{red}{\textbf{PROJET}}}}
       \fi
       \ifdm@s@DiffusionSD
       \chead{\hspace{-9mm}\raisebox{22.5mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{SECRET DEFENSE}}}}}\\
         \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{16mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\ \fi
         \hspace{-9mm}\raisebox{13.5mm}[0pt]{\textcolor{red}{\textbf{PROJET}}}}
       \fi
       %% \ifdm@s@isSpecialFrance \chead{\hspace{-9mm}\raisebox{16mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\
       %%   \hspace{-9mm}\raisebox{13mm}[0pt]{\textcolor{red}{\textbf{PROJET}}}}
       %% \fi
     \fi
   \else
     \ifdm@s@haveTimbre
       \ifdm@s@DiffusionRestreinte
       \chead{\hspace{-9mm}\raisebox{22.5mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{DIFFUSION RESTREINTE}}}}}\\
          \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{16mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}\\ \fi
         \hspace{-9mm}\raisebox{14mm}[0pt]{\textcolor{red}{\textbf{\small Ne pas diffuser sans autorisation de l'\'emetteur}}}}
       \fi
       \ifdm@s@DiffusionCCEA
       \chead{\hspace{-9mm}\raisebox{26mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL CEA}}}}}\\
        \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{19mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}} \fi}
       
       \fi
       \ifdm@s@DiffusionCD
       \chead{\hspace{-9mm}\raisebox{26mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL DEFENSE}}}}}\\
        \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{19mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}} \fi}
       \fi
       \ifdm@s@DiffusionSD
       \chead{\hspace{-9mm}\raisebox{26mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{SECRET DEFENSE}}}}}\\
        \ifdm@s@isSpecialFrance \hspace{-9mm}\raisebox{19mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}} \fi}
       \fi
       %% \ifdm@s@isSpecialFrance
       %% \chead{\hspace{-9mm}\raisebox{20mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}}}
       %% \fi
     \fi
   \fi


   \lfoot{}
   \rfoot{}
   \cfoot{\dm@s@footerNote}
   \ifdm@s@haveTimbre{%
     \ifdm@s@DiffusionCD
     \cfoot{%%
       \raisebox{7mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL DEFENSE}}}}} \\
       \dm@s@footerNote}
     \fi
     \ifdm@s@DiffusionSD
     \cfoot{%%
       \raisebox{7mm}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{SECRET DEFENSE}}}}} \\
       \dm@s@footerNote}
     \fi
   }%
   \fi
   \renewcommand{\headrulewidth}{0.0pt}
   \renewcommand{\footrulewidth}{0.2pt}

   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                                PAGE 1 : PAGE DE GARDE                      |
   %% |____________________________________________________________________________|
   %%
   \newpage
   \thispagestyle{empty}

   \setlength{\parindent}{0mm}   
   \setlength{\extrarowheight}{1.6mm}    %%% 2.5mm | 1.6mm
   %% \ifdm@s@DiffusionNormale
   %% \renewcommand{\arraystretch}{1.2}
   %% \fi
   \newlength{\raiselocal}
   \setlength{\raiselocal}{-2.3ex}
   \ifdm@s@isSpecialFrance \setlength{\raiselocal}{-0.65ex} \fi
   
   \raisebox{29mm}[0pt]{%%
     \begin{tabular}{|@{}p{47mm}@{}|@{}>{\centering}m{76.5mm}@{}|@{}m{56mm}@{}|} %%% Mod by JBB, 50 / 75 / 55
       \hline
       & 
       \ifdm@s@haveTimbre
       \ifdm@s@DiffusionRestreinte
       \raisebox{\raiselocal}{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{DIFFUSION RESTREINTE}}}}}
       \fi
       \ifdm@s@DiffusionCCEA
       \raisebox{\raiselocal}{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL CEA}}}}}
       \fi
       \ifdm@s@DiffusionCD
       \raisebox{\raiselocal}{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL DEFENSE}}}}}
       \fi
       \ifdm@s@DiffusionSD
       \raisebox{\raiselocal}{\fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{SECRET DEFENSE}}}}}
       \fi
       \ifdm@s@DiffusionNormale
       \raisebox{\raiselocal}{\fboxrule2pt \fboxsep2.7mm \fcolorbox{white}{white}{\Large{\textcolor{white}{\textbf{}}}}}
       \fi
       \fi
       & \\  
       &
       \ifdm@s@haveTimbre
       \ifdm@s@isSpecialFrance \raisebox{-1.15ex}[0pt]{\fboxrule2pt \fboxsep2.7mm \fcolorbox{blue}{white}{\Large{\textcolor{blue}{\textbf{SPECIAL FRANCE}}}}} \fi
       \fi
       &
       \ifdm@sCodeBarre
       \hspace*{3mm}\raisebox{-5.5mm}[-1pt][-1pt]{\includegraphics[width=48.5mm]{\dm@s@fileCodeBarre}}
       \fi
       \\
       & 
       \ifdm@s@haveTimbre
       \ifdm@s@DiffusionRestreinte
       \raisebox{0ex}{\textcolor{red}{\textbf{\small Ne pas diffuser sans autorisation de l'\'emetteur}}}
       \fi
       \fi
       & \\
       \raisebox{-1mm}[0pt]{\hspace{5.5mm}\includegraphics[width=37mm,height=30mm]{CEA_FR_logotype}} & %%% 9 => 7 Mod by JBB
       \hrule \begin{minipage}[c][10mm][c]{80mm} \hspace{\stretch{1}} \dm@s@typeDocument\ \dm@s@abrDirection \hspace{\stretch{1}} \end{minipage} & 
       \hrule \begin{minipage}[c][10mm][c]{40mm} \hspace{\stretch{1}} Page~\thepage/\pageref{LastPage} \hspace{\stretch{1}} \end{minipage}  \\
       \hline
     \end{tabular}}
   \vspace{\stretch{10}}
   \begin{center}
     \raisebox{30mm}[0pt]{\large \bf \dm@s@direction}\\
     \vspace{\stretch{1}}
     \raisebox{30mm}[0pt]{\large \bf \dm@s@sousdirection}\\
     \vspace{\stretch{1}}
     \raisebox{30mm}[0pt]{\large \bf \dm@s@departement}\\
     \vspace{\stretch{1}}
     \raisebox{30mm}[0pt]{\large \bf \dm@s@service}\\
     
     \vspace{\stretch{3}}
     
     \begin{minipage}[c][12mm][c]{180mm}
       \begin{center}
         \Large \bf {\dm@s@titre}
       \end{center}
     \end{minipage}
     
     \vspace{\stretch{3}}
     
     {\large \bf { \dm@s@auteurAName \\
         \ifnum\dm@s@numberAuteur>1
           \dm@s@auteurBName \\
         \fi
         \ifnum\dm@s@numberAuteur>2
           \dm@s@auteurCName \\
         \fi
         \ifnum\dm@s@numberAuteur>3
           \dm@s@auteurDName \\
         \fi
         \ifnum\dm@s@numberAuteur>4
           \dm@s@auteurEName \\
         \fi
         \ifnum\dm@s@numberAuteur>5
           \dm@s@auteurFName \\
         \fi
         \ifnum\dm@s@numberAuteur>6
           \dm@s@auteurGName \\
         \fi
         \ifnum\dm@s@numberAuteur>7
           \dm@s@auteurHName \\
         \fi
       }
     }
     
     \vspace{\stretch{4}}
     
     %% Reference A : CEA/DEN/DM2S
     \ifdm@s@isdmssdir
       {\large \bf \dm@s@ReferenceAName\ \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@referenceANumber} \\
     \else
       {\large \bf \dm@s@ReferenceAName\ \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@referenceANumber \dm@s@diffusionFlag} \\
     \fi
     %% Reference B si existe
     \ifdm@s@haveReferenceExterne
       \vspace{\stretch{2}}
       {\large \bf \dm@s@referenceBName : \dm@s@referenceBNumber}\\
     \fi
     \vspace{\stretch{4}}
     \ifdm@s@isDraft
       \Large{\textcolor{red}{PROJET}}\\
     \else
       \Large{\phantom{PROJET}}
     \fi
     \ifdm@s@havereferenceaction
       \vspace{\stretch{4}}
       {\large \bf Document \'emis dans le cadre de l'accord} \\
       {\dm@s@referenceAccord}
     \fi
     \vspace{\stretch{4}}
     \ifdm@s@DiffusionCD
       \fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{CONFIDENTIEL DEFENSE}}}}
     \fi
     \ifdm@s@DiffusionSD
       \fboxrule2pt \fboxsep2.7mm \fcolorbox{red}{white}{\Large{\textcolor{red}{\textbf{SECRET DEFENSE}}}}
     \fi
   \end{center}
   
   \vspace{\stretch{5}}
   \renewcommand{\arraystretch}{0.5}
   \begin{tabular}{@{}p{150mm}m{1mm}m{16mm}}
     Commissariat \`a l'\'energie atomique et aux \'energies alternatives & & \\
     Centre de \dm@s@laboratoireCentre\ - \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/\dm@s@abrService/\dm@s@abrLaboratoire\ - BAT \dm@s@laboratoireBatiment\ - PC \dm@s@laboratoirePC\  & & \\
     91191 Gif sur Yvette Cedex - FRANCE & & \\
     T\'el. : 33 - 1 69 08 \dm@s@laboratoireTel\  \hspace{2mm} Fax : 33 - 1 69 08 \dm@s@laboratoireFax\  \hspace{2mm} Secr\'etariat : \dm@s@laboratoireMail\/@cea.fr & & \\
     Etablissement public \`a caract\`ere industriel et commercial & & \\
     RCS PARIS B 775 685 019 &
%      \ifdm@sPDF
%      \raisebox{-1ex}[0pt]{\includegraphics[width=16mm,height=20mm]{logo_DM2S}}
%      \else
%      \raisebox{-1ex}[0pt]{\includegraphics[width=16mm,height=20mm]{logo_DM2S}}
%      \fi
     & 
     \ifdm@sPDF
     \raisebox{-1ex}[0pt]{\includegraphics[width=16mm,height=20mm]{logo_DM2S}}
     \else
     \raisebox{-1ex}[0pt]{\includegraphics[width=16mm,height=20mm]{logo_DM2S}}
     \fi
     \\
   \end{tabular}
   \vspace{1ex}
   \hrule
   \vspace{1ex}
   \par{\small R\'ef du formulaire : F1-DM2S/DIR/PR/003 classe \LaTeX\ {\sc docDM2S} version \ClassVersion}
   \begin{center}
     {\small \dm@s@footerNote}
   \end{center}
   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 2 : Fiche Documentaire                      |
   %% |____________________________________________________________________________|
   %%
   \setlength{\extrarowheight}{0mm}
   \newpage
   \renewcommand{\arraystretch}{1.0}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Confidentialit\'e                      %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabular}{|@{}p{35.85mm}@{}|@{}p{35.85mm}@{}|@{}p{35.85mm}@{}|@{}p{35.85mm}@{}|@{}p{35.85mm}@{}|}
     \hline
     \multicolumn{5}{|c|}{ {\sc Niveau de confidentialite}} \\
      \hline
      \hspace{15mm} DO \hspace{15mm} & \hspace{15mm} DR \hspace{15mm} & \hspace{15mm} CCEA \hspace{15mm} & \hspace{15mm} CD \hspace{15mm} & \hspace{15mm} SD \hspace{15mm} \\
      \hline
      \dm@s@putDingDiffusion{\ifdm@s@DiffusionNormale} & \dm@s@putDingDiffusion{\ifdm@s@DiffusionRestreinte} & \dm@s@putDingDiffusion{\ifdm@s@DiffusionCCEA}  & \dm@s@putDingDiffusion{\ifdm@s@DiffusionCD}  & \dm@s@putDingDiffusion{\ifdm@s@DiffusionSD} \\
     \hline
   \end{tabular}

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Partenaire/Action                      %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabular}{|p{55.7mm}|p{55.7mm}|p{55.5mm}|}
     \hline
     {\sc Partenaires/Clients} & {\sc Accord} & {\sc Type d'action} \\
     \hline
     \ifdm@s@havereferenceaction
       \dm@s@partenaires & \dm@s@referenceAccord & \dm@s@typeAction \\
     \else
       & & \\
     \fi
     \hline
   \end{tabular}

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% References internes CEA                %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabular}{|p{40.7mm}|p{40.6mm}|p{40.6mm}|p{40.6mm}|}
     \hline
     \multicolumn{4}{|c|}{ {\sc R\'ef\'erences internes CEA}} \\
     \hline
     {\sc {\small Direction d'objectifs}} & {\sc Domaine} & {\sc Projet} & {\sc EOTP} \\
     \hline
     \dm@s@DOB & \dm@s@ProgrammeName & \dm@s@ProjetName & \dm@s@EOTP \\
     \hline
     {\sc Jalon} & {\sc Intitul\'e du jalon} & {\sc D\'elai contractuel de confidentialite} &  {\sc Cahiers de laboratoire} \\
     \hline
     \ifdm@s@haveJalon \dm@s@jalonName \fi & \ifdm@s@haveJalon \dm@s@jalonTitle \fi & \ifdm@s@haveDelaiConfidentialite \dm@s@delaiConfidentialite \fi & \ifdm@s@haveCahierLaboratoire \dm@s@cahierLaboratoire \fi \\
     \hline
   \end{tabular}

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Suivi des versions                     %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \begin{tabular}{|p{10mm}|p{20mm}|p{87.6mm}|p{45mm}|}
     \hline
     \multicolumn{4}{|c|}{ {\sc Suivi des versions}} \\
     \hline
     {\small {\sc Indice}} & {\small {\sc Date}}  & {\small {\sc Nature de l'\'evolution}} & {\small {\sc Pages et chapitres modifi\'es}} \\
     % &&&\\
     \hline
     A                   & \d@teind@ce@ &  \l@gind@ce@   &  \\
     \ifnum\dm@s@lastIndice>1
     \hline
     B                   & \d@teind@ce@@ & \l@gind@ce@@  & \dm@s@PagesModifieesB \\
     \fi
     \ifnum\dm@s@lastIndice>2
     \hline
     C                   & \d@teind@ce@@@ & \l@gind@ce@@@ &  \dm@s@PagesModifieesC \\
     \fi
     \ifnum\dm@s@lastIndice>3
     \hline
     D                   & \d@teind@ce@@@@ & \l@gind@ce@@@@ &  \dm@s@PagesModifieesD \\
     \fi
     \ifnum\dm@s@lastIndice>4
     \hline
     E                   & \d@teind@ce@@@@@ & \l@gind@ce@@@@@ &  \dm@s@PagesModifieesE \\
     \fi
     \hline
   \end{tabular}

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %% Signatures                             %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   \vspace{5mm}
   \ifnum\dm@s@numberAuteur<5
   \setlength{\extrarowheight}{5mm}
   \else
   \setlength{\extrarowheight}{3mm}
   \fi
   \begin{tabular}{|p{24mm}|p{43mm}|p{43mm}|p{30mm}|p{18.2mm}|}
     \hline
     & {\small {\sc Nom}} & {\small {\sc Fonction}}  & {\small {\sc Visa}} & {\small {\sc Date}} \\
     \hline
     {\small {\sc R\'edacteur}} & \dm@s@auteurAName & {\small {\sc \dm@s@auteurAFunction}} & & \\
     \hline
     \ifnum\dm@s@numberAuteur>1
     \ifdm@s@auteurBSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurBName & {\small {\sc \dm@s@auteurBFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>2
     \ifdm@s@auteurCSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurCName & {\small {\sc \dm@s@auteurCFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>3
     \ifdm@s@auteurDSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurDName & {\small {\sc \dm@s@auteurDFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>4
     \ifdm@s@auteurESignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurEName & {\small {\sc \dm@s@auteurEFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>5
     \ifdm@s@auteurFSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurFName & {\small {\sc \dm@s@auteurFFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>6
     \ifdm@s@auteurGSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurGName & {\small {\sc \dm@s@auteurGFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberAuteur>7
     \ifdm@s@auteurHSignature
     {\small {\sc R\'edacteur}} & \dm@s@auteurHName & {\small {\sc \dm@s@auteurHFunction}} & & \\
     \hline
     \fi
     \fi
     \ifnum\dm@s@numberVerificateur>1
     {\small {\sc V\'erificateur}} & \dm@s@verificateurAName & {\small {\sc \dm@s@verificateurAFunction}} & & \\
     \hline
     \fi
     \ifnum\dm@s@numberVerificateur>2
     {\small {\sc V\'erificateur}} & \dm@s@verificateurBName & {\small {\sc \dm@s@verificateurBFunction}} & & \\
     \hline 
     \fi
     \ifnum\dm@s@numberVerificateur>3
     {\small {\sc V\'erificateur}} & \dm@s@verificateurCName & {\small {\sc \dm@s@verificateurCFunction}} & & \\
     \hline 
     \fi
     \ifnum\dm@s@numberVerificateur>4
     {\small {\sc V\'erificateur}} & \dm@s@verificateurDName & {\small {\sc \dm@s@verificateurDFunction}} & & \\
     \hline 
     \fi
     {\small {\sc Autre visa}} & \ifnum\dm@s@NbVisa = 1 \dm@s@visaName \fi & \ifnum\dm@s@NbVisa = 1  {\small {\sc \dm@s@visaFunction}} \fi & & \\
     \hline 
     {\small {\sc Approbateur}} & \dm@s@approbateurName & {\small {\sc \dm@s@approbateurFunction}}& & \\
     \hline 
     {\small {\sc Emetteur}} & \dm@s@emetteurName & {\small {\sc \dm@s@emetteurFunction}}& & \\
     \hline
   \end{tabular}

   \setlength{\extrarowheight}{0mm}

   %%  ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 3 : RESUME                                  |
   %% |____________________________________________________________________________|
   %%
   \newpage
   %%
   %% Divise la hauteur du r\'esum\'e dans le cas d'une publication
   %%
   %%% \ClassWarning{docDM2S}{*** la hauteur du resume \the\dm@s@hauteurResume ***.}%
   \ifdm@s@isPublication
     \divide\dm@s@hauteurResume2\relax
   \fi
   %%% \ClassWarning{docDM2S}{*** la hauteur du resume \the\dm@s@hauteurResume ***.}%
   %%

   \vspace{\stretch{1}}
   
   \ifdm@s@isEnglish
     \textbf{\textsc{Keywords}}
   \else
     \textbf{\textsc{Mots Clefs}}
   \fi
   
   \vspace{5pt}
   \fbox{\parbox[t][2em][t]{0.95\textwidth}{\dm@s@MotsClefs}}

   \vspace{\stretch{4}}

   \ifdm@s@haveResume
   \textbf{\textsc{R{\'E}SUM{\'E}/CONCLUSIONS} {\small de m\^eme niveau de confidentialit\'e que le document}}

   \vspace{5pt}
   \fbox{\parbox[t][\dm@s@hauteurResume][t]{0.95\textwidth}{\dm@s@Resume}}
   \fi

   \vspace{\stretch{4}}

   \ifdm@s@haveResumeDO
   \newpage %%\dm@s@clearEmptyDoublePage
   \textbf{\textsc{R{\'E}SUM{\'E}/CONCLUSIONS} {\small r\'edig\'e pour \^etre de niveau DO si le document est de niveau DR, CCEA, CD ou SD}}

   \vspace{5pt}
   \fbox{\parbox[t][\dm@s@hauteurResume][t]{0.95\textwidth}{\dm@s@resumeDO}}
   \fi
   
   \setlength{\parindent}{5mm}
   
   %% ____________________________________________________________________________
   %% |                                                                            |
   %% |                           PAGE 4 : DIFFUSION INITIALE                      |
   %% |____________________________________________________________________________|
   %%
   \newpage
   \setlength{\parindent}{0pt}
   \begin{center}
     \textbf{{\sc {\Large Diffusion initiale}}} \\
     {\small (Diffusion par email si document en DO)}
   \end{center}
   \vspace{\stretch{1}}


   \ifdm@s@DiffusionNormale{%
     {\bf \underline{Diffusion interne CEA}} \\
   }\else{%
     {\bf \underline{Diffusion interne CEA -- par mail cript\'e}} \\
   }\fi%

   \ifdm@s@isLongTable
     \begin{longtable}{ll}
   \else
     \begin{tabular}[!H]{ll}
   \fi
     \ifdm@s@useDefaultDiffusion
       \ifnum\dm@s@numberVerificateur>1
         \dm@s@verificateurAName & \dm@s@verificateurALabotory \\
       \fi
       \ifnum\dm@s@numberVerificateur>2
         \dm@s@verificateurBName & \dm@s@verificateurBLabotory \\ 
       \fi
       \ifnum\dm@s@numberVerificateur>3
         \dm@s@verificateurCName & \dm@s@verificateurCLabotory \\ 
       \fi
       \ifnum\dm@s@numberVerificateur>4
         \dm@s@verificateurDName & \dm@s@verificateurDLabotory \\ 
       \fi

       \dm@s@CdD, Chef du \dm@s@abrDepartement & \dm@s@abrDirection/\dm@s@abrSousDirection/\dm@s@abrDepartement/DIR \\
       \fi

     \ifdm@s@havediffusioninterne
       \dm@s@DiffusionInterne
     \fi
   \ifdm@s@isLongTable
     \end{longtable}
   \else
     \end{tabular}
   \fi

     
   \vspace{\stretch{5}}
   
   \ifdm@s@DiffusionNormale
     {\bf \underline{Diffusion externe CEA}} \\
   \else
     {\bf \underline{Diffusion externe CEA -- par conteneur Zed}} \\
   \fi
     
   \ifdm@s@havediffusionexterne
     \ifdm@s@isLongTable
       \begin{longtable}{ll}
     \else
       \begin{tabular}[!H]{ll}
     \fi
       \dm@s@DiffusionExterne
     \ifdm@s@isLongTable
       \end{longtable}
     \else
       \end{tabular}
     \fi
   \else
     ``sans objet''
   \fi
   \vspace{\stretch{5}}

   {\bf \underline{Diffusion r\'esum\'e}} \\
   \ifdm@s@haveDiffusionResume
     \ifdm@s@isLongTable
       \begin{longtable}{ll}
     \else
       \begin{tabular}[!H]{ll}
     \fi     
       \dm@s@DiffusionResume
     \ifdm@s@isLongTable
       \end{longtable}
     \else
       \end{tabular}
     \fi     
   \else
     ``sans objet''
   \fi
   \vspace{\stretch{5}}
   
   \ifdm@s@DiffusionNormale
   \else
      {\bf \underline{Diffusion autre que par mail}} \\
      Si niveau de confidentialit\'e sup\'erieur \`a la diffusion ordinaire (DO), voir guide DEN (OOSYQN000GU104).
   \fi
 }
 %% ____________________________________________________________________________
 %% |                                                                            |
 %% |             CADRE en haut des pages                                        |
 %% |____________________________________________________________________________|
 %% 
 \def\dm@s@cadreHautPage{%%
   \renewcommand{\arraystretch}{1.75}
%%   \setlength{\tabcolsep}{3pt}
   \raisebox{20mm}[0pt]{%%
      \begin{tabular}{|@{}p{47mm}@{}|@{}>{\centering}m{76.5mm}@{}|p{31mm}|@{\hspace{3pt}}p{17.5mm}|}  %% Mod by JBB,  
       \hline
       & & {\footnotesize \dm@s@typeDocument\ \dm@s@abrDirection\ }  & {\small Page~\thepage/\pageref{LastPage}} \\     
       \cline{3-4}
       & & \multicolumn{2}{l|}{
%          {\small \underline{R\'ef} : \dm@s@abrService/\dm@s@abrLaboratoire/\dm@s@abrTypeDocument/\dm@s@numeroChrono}} \\
         {\small \underline{R\'ef} : \dm@s@abrService/\dm@s@abrLaboratoire/\dm@s@abrTypeDocument/\ifdm@s@haveNumeroChrono\dm@s@numeroChrono\else\textcolor{red}{\dm@s@defaultNumeroChrono}\fi}} \\
       \cline{3-4}
       & & {\small \underline{Date} : \dm@s@dateOfficielle }  & {\small \underline{Indice}~:~\textbf{\dm@s@indice}}\\
       \cline{2-4}
       \raisebox{-1mm}[0pt]{\hspace{5.5mm}\includegraphics[width=37mm,height=30mm]{CEA_FR_logotype}} & %%% Mod by JBB, 9 => 7
       \multicolumn{3}{l|}{%%
         \begin{minipage}[c][10mm][c]{126mm}
           \textbf{\dm@s@titre}
         \end{minipage} } \\
       \hline
     \end{tabular}}}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% macro : dm@s@clearEmptyDoublePage      %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% 
 \def\dm@s@clearEmptyDoublePage{%
   \newpage{\pagestyle{empty}\cleardoublepage}}
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %% macro : dm@s@footerNote                %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 \def\dm@s@footerNote{\textcolor{red}{\scriptsize 
     \ifdm@s@havereferenceaction
     Document \'emis par le {\sc CEA} dans le cadre de l'accord \dm@s@referenceAccord\ - Reproduction et diffusion soumises aux termes de l'accord
     \else
     Document propri\'et\'e du {\sc CEA} - Reproduction et diffusion externes au CEA soumises \`a l'autorisation de l'\'emetteur
     \fi}}
 %% ----------------------
 \sloppy
 
 \setcounter{secnumdepth}{3}
 \setcounter{tocdepth}{3}
 %%%%%% fin de docDM2S.cls
