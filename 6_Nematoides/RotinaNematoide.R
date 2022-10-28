#Apagar a memoria do R
remove(list=ls())

#ativar o pacote ExpImage
library(ExpImage)

#Indcar a pasta onde estao as imagens
setwd_script()

#importando  a imagem
im=read_image("n1.jpg",plot=T)
#Visualizar o melhor indice
plot_indexes(im)

#Segmentando o objeto de referencia
rb=gray_scale(im,method = "rb",plot=T)
ref=segmentation(rb,threshold = 0.85,plot=T)

# Segmentando raizes mais nodulos
b=gray_scale(im,method = "b",plot=T)
raiz=segmentation(b,threshold = 0.6,selectHigher = F,
                  fillHull =FALSE,plot = TRUE )

nodulos0=erode_image(raiz,n=4,plot=TRUE)
nodulos=dilate_image(nodulos,n=4,plot=TRUE)


#Visualizando a eficiencia
mask=mask_pixels(im,TargetPixels = list(raiz,nodulos),
          col.TargetPixels =c("black","red") ,plot=T)
join_image(im,mask)


#Avaliando a porcentagem de nodulos em relacao ao total
100*sum(nodulos)/sum(raiz)

#Area da raiz+nodulo em pixel
sum(raiz)
#Area da raiz em cm² (obs: o obj de ref tem 9cm²)
9*sum(raiz)/sum(ref)



#Area do nodulo em pixel
sum(nodulos)
#Area da raiz em cm² (obs: o obj de ref tem 9cm²)
9*sum(nodulos)/sum(ref)


#Contagem dos nodulos
measure_image(nodulos,splitConnected = F)
