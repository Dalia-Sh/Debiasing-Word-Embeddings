####  Setting directory #### 
setwd("/Users/daliashanshal/DS8008-project/Dalia")
getwd()

####  Reading professions embedding #### 
professions_emb <- read.csv("professions_embedding_df.csv")
#View(professions_emb)

#### Normalizing vector embeddings #### 
length_func <- function(x){(sqrt(sum(x^2)))}
professions_emb_norm = professions_emb
for (i in 1:nrow(professions_emb)){
  professions_emb_norm[i,-1] <- professions_emb[i,-1]/length_func(professions_emb[i,-1])
}

####  Testing to see that all rows are normalized #### 
test = 0
for (i in 1:nrow(professions_emb_norm)){
  test = test + (length_func(professions_emb_norm[i,-1]))
}
test # test=299, each row length is equal to 1.

#### Calculate vector projection onto she minus he vec (see youtube video) ####  
# Projecting vec2 onto vec1 function: 
projection_function <- function(vec1, vec2){
  num = sum(vec1*vec2)
  denom = length_func(vec1)^2
  projected_vec = (num/denom)*vec1
  return(length_func(projected_vec))
}
# Projecting occupations onto she_minus_he vec:
she_minus_he_vec = professions_emb_norm[which(professions_emb_norm$X0=="she"),-1]-professions_emb_norm[which(professions_emb_norm$X0=="he"),-1]
occup_magn_on_SheHeVec <- c()
for (i in 1:nrow(professions_emb_norm)){
  occup_magn_on_SheHeVec[i] <- projection_function(she_minus_he_vec, professions_emb_norm[i,-1])
}
profession_projections <- data.frame("occup"=professions_emb_norm[,1],occup_magn_on_SheHeVec)
Top12_sheBias <- as.character(head(profession_projections[order(profession_projections$occup_magn_on_SheHeVec, decreasing = T),1 ],12))
Top12_heBias <- as.character(head(profession_projections[order(profession_projections$occup_magn_on_SheHeVec, decreasing = F), 1],12))

## Plot Using Top24 our findings:
our_subsetFemale_sheHeVec <- subset(profession_projections, occup %in% c(Top12_sheBias))
our_subsetMale_sheHeVec <- subset(profession_projections, occup %in% c(Top12_heBias))
library(ggplot2)
ggplot(our_subsetMale_sheHeVec, aes(x= occup_magn_on_SheHeVec, y=rep(0,12),label=occup))+
  geom_point() +geom_text(aes(label=occup),angle=90,size=6)

## Plot Using Bolukb biased occup:
he_bias <- c("maestro", "skipper", "protege", "philosopher", "captain", 
             "architect", "financier", "warrior", "broadcaster", "magician", 
             "pilot", "boss")
she_bias <- c("homemaker", "nurse", "receptionist", "librarian", "socialite", 
              "hairdresser", "nanny", "bookkeeper", "stylist", "housekeeper", 
              "designer", "counselor")

bolukb_subset_sheHeVec <- subset(profession_projections, occup %in% c(he_bias,she_bias))
library(ggplot2)
ggplot(bolukb_subset_sheHeVec, aes(x= occup_magn_on_SheHeVec, y=rep(0,22),label=occup))+
  geom_point() +geom_text(aes(label=occup),angle=90,size=6)

## Projecting onto she and he separately and plotting: 
she_vec = professions_emb_norm[which(professions_emb_norm$X0=="she"),-1]
he_vec = professions_emb_norm[which(professions_emb_norm$X0=="he"),-1]
She_mag <- c()
for (i in 1:nrow(professions_emb_norm)){
  She_mag[i] <- projection_function(she_vec, professions_emb_norm[i,-1])
}
He_mag <- c()
for (i in 1:nrow(professions_emb_norm)){
  He_mag[i] <- projection_function(he_vec, professions_emb_norm[i,-1])
}
She_he_mag <- data.frame("occup"=professions_emb_norm[,1],"she"=She_mag, "he"=He_mag)
bolukb_biased_subset <- subset(She_he_mag, occup %in% c(he_bias,she_bias))
bolukb_biased_subset

library(ggplot2)
ggplot(bolukb_biased_subset, aes(x= he, y= she, label=occup))+
  geom_point() +geom_text(aes(label=occup),hjust=0, vjust=0)

our_subset_sheHeVec <- subset(She_he_mag, occup %in% c(Top12_sheBias,Top12_heBias))
ggplot(our_subset_sheHeVec, aes(x= he, y= she, label=occup))+
  geom_point() +geom_text(aes(label=occup),hjust=0, vjust=0)

# Calculate direct bias (using pca)

# EXTRA TESTING AND DRAFT: She and He with and without cosine similarity:
cosine_sim_func <- function(vec1,vec2){
  return(sum(vec1*vec2))
}
she_vec = professions_emb_norm[which(professions_emb_norm$X0=="she"),-1]
he_vec = professions_emb_norm[which(professions_emb_norm$X0=="he"),-1]
cos_with_She <- c()
for (i in 1:nrow(professions_emb_norm)){
  cos_with_She[i] <- cosine_sim_func(she_vec, professions_emb_norm[i,-1])
}
cos_with_He <- c()
for (i in 1:nrow(professions_emb_norm)){
  cos_with_He[i] <- cosine_sim_func(he_vec, professions_emb_norm[i,-1])
}
cosine_occupations <- data.frame("occup"=professions_emb_norm[,1],"she_sim"=cos_with_She, "he_sim"=cos_with_He)
head(cosine_occupations[order(cosine_occupations$she_sim, decreasing = T), ],15)

