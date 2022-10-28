#Apagar a memoria do R
remove(list=ls())

#ativar o pacote ExpImage
library(ExpImage)

#Indcar a pasta onde estao as imagens
setwd_script()

#importando  a imagem
im1=read_image("cloreto ferrico 1 maior.jpg",plot=T)
#Obtendo o resolucao da imagem
resolucao=pick_resolution(im1,centimeters = 50)
resolucao

#Estimando a espesura
espesura=pick_length(im1,dpi = resolucao$dpi)
espesura
mean(espesura$coordinates[,7])



#importando  a imagem
im2=read_image("cloreto ferrico 2 menor.jpg",plot=T)
#Obtendo o resolucao da imagem
resolucao=pick_resolution(im2,centimeters = 50)
resolucao

#Estimando a espesura
espesura=pick_length(im2,dpi = resolucao$dpi)
espesura
mean(espesura$coordinates[,7])
