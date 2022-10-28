#Apagar memoria do R
remove(list=ls())
#Indicar a pasta de trabalho
setwd("C:/Users/AlcineiAzevedo/Desktop/Alcinei/_R cran/_R cran/Parse/_Curso de analise de imagens (Haynna) - 2/5_Area Acerola Treshold")

#ativar pacote
library(ExpImage)
#Abrir imagem
im=read_image("imagem.jpg",plot=T)


#Selecionando o melhor indice para a segmentacao
plot_indexes(im)


#A banda de azul foi a que melhor discriminou
b=gray_scale(im,method = "b",plot=T)

#O limiar pode ser um valor escolhido aleatoriamente (por exemplo: 0.6)
MatrizSegmentada=segmentation(b,treshold = 0.6,fillHull = T,selectHigher = F,plot=T)

#O limiar tambem pode ser estabelecido pelo metodo de otsu
MatrizSegmentada2=segmentation(b,treshold = "otsu",fillHull = T,selectHigher = F,plot=T)

#Obter medidas de cada objeto
medidas=measure_image(MatrizSegmentada2)
#ver o numero de objetos e medias
medidas



#Obter medidas de cada objeto excluindo o ruido
medidas=measure_image(MatrizSegmentada2,noise = 1000)
#numero de objetos
medidas$ObjectNumber
Estimativas=medidas$measures

#Plotar resultados das areas em pixel e salvar em um arquivo chamado "teste.jpg"
plot_meansures(im,medidas$measures[,1],coordy=medidas$measures[,2],text=round(medidas$measures[,3],1),
               cex = 0.9,pathSave ="teste.jpg",col="red" ,plot = T)

#Plotando o perimetro nas fotos
plot_meansures(im,medidas$measures[,1],coordy=medidas$measures[,2],text=round(medidas$measures[,4],2),
               cex = 0.9,pathSave ="teste.jpg",col="blue" ,plot=T)



##############################################################################
######################################################################
#Convertendo a area dos objetos para cm2

#Conhecendo o identificador do objeto de referencia

plot_meansures(im,medidas$measures[,1],coordy=medidas$measures[,2],text=1:30,
               cex = 0.9,pathSave ="teste.jpg",col="blue",plot=T )

#como pode-se ver, o objeto de referencia e o de numero 30
# A area conhecida do objeto de referencia tem 8.5 x 5.5 cm. Isso nos leva a 46.75
medidas2=measure_image(MatrizSegmentada2,noise = 1000,id=30,length= 8.5,width =5.5)
medidas2
#Apresentando a area foliar em cm2 de sobre cada uma das folhas
plot_meansures(im,medidas2$measures[,1],coordy=medidas2$measures[,2],text=round(medidas2$measures[,3],2),cex = 0.9,col="blue")



#################################################################
################################################################
#Obs.: O uso do objeto de referencia e util para a conversao em cm2 em situacoes que nao se conhece a area fotografada.
#Se soubermos exatamente qual e o tamanho da area escaneada (fotografada) podemos dispensar o uso do objeto de referencia.

#Convertendo a area em pixel para cm2 considerando a dimensao superficie escaneada
# A dimensao da superficie escaneada tem 21*29.7 cm (dimensao de uma folha a4). Isso nos leva a  623.7 cm?

medidas3=measure_image(MatrizSegmentada2,noise = 1000,id="all",length= 21,width =29.7)
medidas3
#Apresentando a area foliar de sobre cada uma das folhas
plot_meansures(im,medidas3$measures[,1],coordy=medidas3$measures[,2],text=round(medidas3$measures[,3],2),cex = 0.9,col="blue",plot=T)

