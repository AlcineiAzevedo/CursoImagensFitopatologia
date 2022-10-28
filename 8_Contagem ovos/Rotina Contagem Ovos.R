#Apagar memoria do R
remove(list=ls())
#Indicar a pasta de trabalho
setwd("D:/Backup Pendrive/UFMG/Cursos/_Curso de analise de imagens (Haynna) - 2/3_Contagem ovos")

#ativar pacote
library(EBImage)

#Abrir imagem
im=readImage("Ovos1.jpg")
plot(im)

#Selecionando o melhor indice para a segmentacao da folha
plot_indexes(im)
#Selecionando a banda de azul
b=gray_scale(im,"b")

#O canal azul possibilita maior contraste
#O limiar pode ser um valor escolhido aleatoriamente (por exemplo: 0.6)
MatrizSegmentada=segmentation(b,treshold = 0.30,fillHull = T,selectHigher = F,plot=T)

#Colocando o background na cor preta
im2=extract_pixels(im,target =MatrizSegmentada,valueTarget =1,valueSelect = c(0,0,0),plot=T )


#Selecionando o melhor indice para a segmentacao dos ovos
plot_indexes(im2)

#Selecionando a banda de azul
b=gray_scale(im2,method = "b",plot=T)

#O canal Azul proporciona melhor segmentacao
#O limiar pode ser um valor escolhido aleatoriamente (por exemplo: 0.6)
MatrizSegmentada2=segmentation(b,treshold = 0.50,fillHull = T,selectHigher = T,plot = T)

Medidas=measure_image(MatrizSegmentada2)
Medidas$ObjectNumber

#Ver a mascara sobre os ovos na foto
im3=mask_pixels(im,MatrizSegmentada2==1,plot=T)


