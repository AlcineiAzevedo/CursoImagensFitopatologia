#Apagar a memoria do R
remove(list=ls())

#ativar o pacote ExpImage
library(ExpImage)

#Indcar a pasta onde estao as imagens
setwd_script()

#importando  a imagem
im=read_image("im (4).png",plot=T)
#Visualizar o melhor indice
plot_indexes(im)
#Extraindo o indice SI
SI=gray_scale(im,method = "SI",plot=TRUE)
#Visualizando a imagem com uma paleta de cores]
plot_image(SI,col=3)
#Segmentando a folha
folha=segmentation(SI,treshold =0.35,fillHull = TRUE,
                   plot = TRUE )
folha2=erode_image(folha,n=2,plot=TRUE)
folha3=dilate_image(folha2,n=2,plot=TRUE)


#Segmentando a doenca
SCI=gray_scale(im,method = "SCI",plot = T)
#Visualizando a imagem com paleta de cores
plot_image(SCI,col=3)
Doenca=segmentation(SCI,treshold = 0.6,fillHull = TRUE,plot=TRUE)

#Visualizando a eficiencia das segmentacoes
mask1=mask_pixels(im,TargetPixels = Doenca,
                  col.TargetPixels = "red",plot=TRUE)
mask2=mask_pixels(im,TargetPixels = Doenca,Contour = TRUE,
                  col.TargetPixels = "blue",plot=TRUE)


mask3=mask_pixels(im,TargetPixels = list(folha3==0,folha3,Doenca),
                 col.TargetPixels = c("black","green","red"),plot=TRUE)
join_image(im,mask1)
join_image(im,mask1,mask2,mask3)


100*(sum(Doenca)/sum(folha3))

