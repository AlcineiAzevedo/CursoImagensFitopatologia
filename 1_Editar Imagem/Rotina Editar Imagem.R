#Apagar memoria do R
remove(list=ls())
#Indicar a pasta de trabalho
setwd("D:/Backup Pendrive/UFMG/Cursos/_Curso de analise de imagens (Haynna) - 2/2_Editar Imagem")

#ativar pacotes
library(ExpImage)

##Abrir imagem
im=read_image("Feijao.jpg", plot=T)
object.size(im)/1024/1024

##Diminuir a resolucao (tamanho da imagem)
?resize_image
im2=resize_image(im,w=650,plot=T)

##Cortar Imagem
im3=crop_image(im2,w =200:650,h=100:650,plot = T)
#im3=crop_image(im2)
##Aumentar brilho
im4=edit_image(im3,brightness = 0.2)

#Aumentar contraste
im5=edit_image(im4,contrast = 1.5)

#Aumentar gamma
im6=edit_image(im5,gamma  = 1.5)


#Alterando brilho, contraste e gamma
imb=edit_image(im3,brightness = 0.1,contrast = 1.7,gamma  = 1.2)
imb=edit_imageGUI(im3)


#Mostrando ambas as imagens simultaneamente.
im4=join_image(im3,imb)


#Interface grafica para editar as imagens
im5 = edit_imageGUI(im2)
plot_image(im5)

#Interface para cortar a imagem
im6=crop_image(im5)

#Rotacionar a imagem
im7=rotate_image(im6,angle = 15)
im8=rotate_image(im6,angle =25, BGcolor = c(1,1,1))

rotate_image(im6)
