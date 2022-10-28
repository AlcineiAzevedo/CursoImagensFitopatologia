
  
  # Abrindo as imagens no R 
  
  ## Ativa??o dos pacotes
 # Ap?s a instala??o dos pacotes ? necess?rio fazer sua ativa??o


library(ExpImage)


## Abrindo as imagens.
#Para abrir as imagens pode-se inicialmente indicar a pasta de trabalho onde a imagem se encontra com a fun??o `setwd`. E, posteriormente, abrir a imagem com a fun??o `read_image`.

#Neste caso, poderiam ser utilizados comandos como esses:
  
 #Apagar memoria do R
remove(list=ls())
#Indicar a pasta de trabalho`

setwd_script()
im=read_image("mamao.jpg",plot=TRUE)

?gray_scale
r=gray_scale(im,method = "r",plot=TRUE)
g=gray_scale(im,method = "g",plot=TRUE)
b=gray_scale(im,method = "b",plot=TRUE)

#Ap?s cria??o do objeto contendo a imagem (im) precisamos proceder alguma metodologia de segmenta??o. 

## Metodologias de segementa??o

#Varias metodologias de segmenta??o podem ser utilizadas. Uma op??o ? o m?todo do limiar. Para isso, ? necess?rios escolher um ?ndice ou banda que proporcionar? maior contraste entre as sementes (foreground) e o fundo (background).

#Selecionando o melhor indice para a segmentacao
plot_indexes(im)


#O Indice SI ? uma op??o ?tima para segmentar o fruto do fundo


#Selecionando o melhor indice para a segmentacao
m=gray_scale(im,"SI",plot=TRUE)

plot_image(m,col=3)


#Agora, ap?s selecionar o ?ndice podemos fazer a segmenta??o.
#A segmenta??o pode ser feita considerando-se um limiar. Ou seja, um valor a partir do qual os pixels ser?o consideradas como background ou foreground. O melhor valor de limiar pode ser obtido pela tentativa e erro:
 
hist(c(m)) 

Mamao=segmentation(m,treshold = 0.20,fillHull = T,selectHigher = T,plot=T)
Mamao=segmentation(m,treshold = 0.25,fillHull = T,selectHigher = T,plot=T)
Mamao=segmentation(m,treshold = 0.30,fillHull = T,selectHigher = T,plot=T)
Mamao=segmentation(m,treshold = 0.35,fillHull = T,selectHigher = T,plot=T)




#Mas neste caso o melhor ? considerar o limiar de 0.30

Mamao=segmentation(m,treshold = 0.30,fillHull = TRUE,selectHigher = TRUE,plot=T)



#Agora que j? separamos o que ? fruto do que ? o fundo, vamos separar a doen?a da parte sadia.
#Vamos ver qual ? o melhor indice para separar o que ? a doen?a.

#Selecionando o melhor indice para a segmentacao
plot_indexes(im)


#Como podemos ver, a banda de vermelho ? uma op??o interessante. Pois, as partes doentes est?o bem escuras.

#Agora, ap?s selecionar o ?ndice podemos fazer a segmenta??o.
#A segmenta??o pode ser feita considerando-se um limiar. Ou seja, um valor a partir do qual os pixels ser?o consideradas como background ou foreground. O melhor valor de limiar pode ser obtido pela tentativa e erro:
  
r=gray_scale(im,method ="r",plot=T )
?segmentation
Doenca=segmentation(r,treshold = 0.20,fillHull = F,selectHigher = F,plot=T)
Doenca=segmentation(r,treshold = 0.30,fillHull = F,selectHigher = F,plot=T)
Doenca=segmentation(r,treshold = 0.40,fillHull = F,selectHigher = F,plot=T)
Doenca=segmentation(r,treshold = 0.50,fillHull = F,selectHigher = F,plot=T)


#Como podemos ver, o valor de 0.4, d? um valor satisfat?rio.
#Vamos ver se houve sucesso com a segmenta??o:
  
  

Doenca=segmentation(r,treshold = 0.40,fillHull = F,selectHigher = F,plot=T)

mask_Doenca1=mask_pixels(im,TargetPixels =Doenca==1, Contour = TRUE,col="red",plot=T)
mask_Doenca2=mask_pixels(im,TargetPixels =Doenca==1, Contour = FALSE,col="red",plot=T)

imb=extract_pixels(im,target = Mamao==1,valueSelect = c(0,0,0),plot=T)
mask_Doenca3=mask_pixels(imb,TargetPixels =Mamao==1,TargetPixels2 =Doenca==1,
                         col.TargetPixels =c("green","red") ,Contour = FALSE,plot=T)

j=join_image(im,mask_Doenca1,mask_Doenca2,mask_Doenca3)





#Agora podemos calcular a area atacada:
  

100*sum(Doenca)/sum(Mamao)





