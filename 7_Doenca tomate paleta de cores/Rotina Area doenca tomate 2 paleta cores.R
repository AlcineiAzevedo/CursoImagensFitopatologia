#Apagar mem?ria do R
remove(list=ls())
#Indicar a pasta de trabalho
setwd("D:/Backup Pendrive/UFMG/Cursos/_Curso de analise de imagens (Haynna)/Curso dia 2/6_Doenca tomate paleta de cores")

#ativar pacote
library(EBImage)
library(ExpImage)
#Abrir imagem
im=readImage("FolhaTomate.jpg")
plot(im)
im=read_image("FolhaTomate.jpg",plot=T)

plot_indexes(im)

#Selecionando o melhor indice para a segmentacao da folha
r=gray_scale(im,method = "r",plot=T)
g=gray_scale(im,method = "g",plot=T)
b=gray_scale(im,method = "b",plot=T)

#O limiar pode ser um valor escolhido aleatoriamente
MatrizSegentada=segmentation(b,treshold = 0.65,fillHull = T,plot=T,
                             selectHigher =F )
display(MatrizSegentada)

#O limiar tambem pode ser estabelecido pelo metodo de otsu
MatrizSegentada2=segmentation(b,treshold = "otsu",fillHull = T,selectHigher = F)
display(MatrizSegentada2)

#Selecionar na imagem apenas os pixeis desejaveis (Folha)
im2=extract_pixels(im,target=MatrizSegentada2,valueTarget=T,
                   valueSelect=c(r=1,g=1,b=1),plot=T)

########################################################################################################
##########################################################################################################
#Selecionando o melhor indice para a segmentacao da doen?a
r=gray_scale(im2,method = "r",plot=T)
g=gray_scale(im2,method = "g",plot=T)
b=gray_scale(im2,method = "b",plot=T)

MatrizSegmentada3=segmentation(g,treshold = 0.2,selectHigher = F,
                               fillHull = T,plot=T)
display(MatrizSegmentada3)

#Como pode-se obsevar, a segmentacao por limiar nao e possivel. Entao vamos usar paletas de cores


folha=readImage("TomateFolha.jpg")
doenca=readImage("TomateDoenca.jpg")

plot(folha)
plot(doenca)

?segmentation_logit
DoencaSeg=segmentation_logit(im,foreground = doenca,background = folha,
                             sample = 2000,fillHull = TRUE,
                             TargetPixels =MatrizSegentada2==1 ,plot=T)

im3=mask_pixels(im2,TargetPixels=DoencaSeg==1)
plot(im3)

plot(combine(im,im3),all=T)


#Porcentagem da area lesionada.
display(DoencaSeg)
sum(DoencaSeg)

display(MatrizSegentada2)
sum(MatrizSegentada2)
100*(sum(DoencaSeg)/sum(MatrizSegentada2))

folha2=segmentation_logitGUI(im)
plot_image(folha2)
