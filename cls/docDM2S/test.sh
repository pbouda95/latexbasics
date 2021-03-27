#!/bin/zsh
# creation : BP, 12/06/2014

# on crée un repertoire de test
PATH_doc=`pwd`
date=`date +%F-%Hh%M`
PATH_test=$PATH_doc/test_$date
echo 'creation de '$PATH_test
mkdir $PATH_test
cp -p $PATH_doc/exemples/*.tex $PATH_test/
cp -p *.png docDM2S.cls $PATH_test/

# compilation
cd $PATH_test
echo $PATH_test > test.txt
for fic in `ls *.tex` 
do
  pdf=`basename $fic .tex`.pdf
  echo 'Compilation de ' $fic ' --> ' $pdf
  echo 'Compilation de ' $fic ' --> ' $pdf >>  test.txt
  pdflatex $fic  >>  test.txt
  pdflatex $fic  >>  test.txt
# on ouvre le nouveau (et l'ancien pour comparaison visuelle)
  okular $pdf & 
#   okular ../exemples/$pdf&
done
  
cd ..

