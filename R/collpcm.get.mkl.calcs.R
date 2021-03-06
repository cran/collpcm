#### The following functions are taken from latentnet package only modified for 
####  our specific set up and variable naming conventions (for clarity)
#### files in latentnet ergmm.probs.R, ergmm.statseval.R, ergmm.families.R, ergmm.latent.effects.R
# see...

#Based on 'statnet' project software (http://statnet.org).
#  For license and citation information see http://statnet.org

#Krivitsky P and Handcock M (2015). latentnet: Latent Position and Cluster Models 
# for Statistical Networks. The Statnet Project (http://	www.statnet.org). R package version 2.7.1, http://CRAN.R-project.org/package=latentnet. 

collpcm.get.dllike.dX <- function( X, dllike.deta )
{
  n<-dim(X)[1]
  d<-dim(X)[2]
  X.invdist<- as.matrix(dist(X))
  X.invdist[X.invdist==0]<-Inf
  X.invdist<-1/X.invdist
  dllike.dX<-matrix(0,n,d)
  for(k in 1:d){
    X.normdiff.k<-sapply(1:n,function(j)
                         sapply(1:n,function(i)
                                X[i,k]-X[j,k]))*X.invdist
    dllike.dX[,k]<-dllike.dX[,k]+
      -sapply(1:n,function(i) crossprod(X.normdiff.k[i,],dllike.deta[i,]+dllike.deta[,i]))
  }
  return( dllike.dX )
}


collpcm.get.eta<-function( nw, pars )
{
  n <- nw$call$Y$gal$n #settings$nnodes 
  d <- nw$call$d
  dir <- nw$call$Y$gal$directed  #settings$directed
  par2 <- list()
  par2[["beta"]] <- pars[1]
  par2[["X"]] <-  matrix( pars[2:(n*d + 1)], nrow=n, ncol=d )
  eta <- par2$beta - as.matrix( dist(par2$X) )
  return(eta)
}

collpcm.get.llike<-function( pars, nw )
{
  
  Ym <- nw$EofY
  n <- nw$call$Y$gal$n #settings$nnodes
  eta <- collpcm.get.eta( nw, pars )
  llike <- sum( Ym * eta - log1p( exp(eta) ) )
  
  return( llike )
}

collpcm.get.grad.llike <- function( pars, nw )
{

  n <- nw$call$Y$gal$n #settings$nnodes
  d <- nw$call$d
  eta <- collpcm.get.eta( nw, pars )
  Ym <- nw$EofY

  dllike.deta <- Ym - 1/( 1 + exp(-eta) )
  
  grad <- numeric( n*d + 1 )
  
  grad[1] <- sum( dllike.deta ) 
  
  XX <- matrix( pars[2:(n*d + 1)], nrow=n, ncol=d )
  
  grad[ 2:(n*d + 1) ] <- as.vector( collpcm.get.dllike.dX( XX, dllike.deta ) )
  
  return( grad )
}

