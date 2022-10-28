#Apagar a memoria do R
remove(list=ls())

#ativar o pacote ExpImage
library(ExpImage)

#Indcar a pasta onde estao as imagens
setwd_script()

#importando  a imagem
im=read_image("17b.jpg",plot=T)
#Visualizar o melhor indice
plot_indexes(im)
#Extraindo o indice SI
SI=gray_scale(im,method = "SI",plot=TRUE)
#Visualizando a imagem com uma paleta de cores]
plot_image(SI,col=3)
#Segmentando a folha
folha=segmentation(SI,treshold =0.1,fillHull = TRUE,
                   plot = TRUE )

#Segmentando a doenca
VARI=gray_scale(im,method = "VARI",plot = T)
#Visualizando a imagem com paleta de cores
plot_image(VARI,col=3)
Doenca=segmentation(VARI,treshold = 0.4,selectHigher = FALSE,
                    fillHull = TRUE,plot=TRUE)

#Visualizando a eficiencia das segmentacoes
mask1=mask_pixels(im,TargetPixels = Doenca,
                  col.TargetPixels = "red",plot=TRUE)
mask2=mask_pixels(im,TargetPixels = Doenca,Contour = TRUE,
                  col.TargetPixels = "blue",plot=TRUE)


mask3=mask_pixels(im,TargetPixels = list(folha==0,folha,Doenca),
                 col.TargetPixels = c("black","green","red"),plot=TRUE)
join_image(im,mask1)
join_image(im,mask1,mask2,mask3)


100*(sum(Doenca)/sum(folha))

