\name{collpcm.fit}
\alias{collpcm.fit}
\title{Fit a latent position cluster network model with model search}
\description{
  \code{\link{collpcm.fit}} is used to fit the latent position cluster model with uncertainty in the number of clusters incorporated. A posterior distribution for the number of clusters is estimated.
}
\usage{
collpcm.fit( Y , d = 2, G = NULL, Gmax = NULL, control = list(), Xref = NA )
}
\arguments{
 \item{Y}{A network object containing the network in question.}
 
 \item{d}{The dimension of the latent position to represent each node in the network (defaults to 2). }
 
 \item{G}{Give the initial number of groups for the algorithm.}
 
 \item{Gmax}{Give the maximum allowed number of groups if doing model search.}
 
 \item{control}{List giving the set up of the algorithm (see \code{\link{collpcm.control}})}
 
 \item{Xref}{Optional latent positions to be used as a reference configuration for the Procrustes rotations.}
     
}

\value{

\code{\link{collpcm.fit}} returns an object of class \code{collpcm} that is a list. 
  The list will have the following slots.
  
 \item{call}{The values of each of the arguments used in the model fitting MCMC run.}

 \item{sample}{A list containing the samples from the MCMC run.}
 
 \item{Gpost}{Estimated posterior distribution of the number of groups/clusters.} 

 \item{Xpostmean}{Estimated posterior mean from sampled latent positions.}
 
 \item{XpostMKL}{MKL posterior latent positions as described in Handcock, Raftery & Tantrum (2007).}
 
 \item{Gslot}{An indexing vector for the lists of posterior mean and MKL positions.}
 \item{acceptance.rates}{Acceptance rates for different moves of MCMC algorithm.}
 \item{adapted.sd.prop}{The standard deviations of the proposal distributions after the adaptation phase.}
 \item{timings}{A list of timings for each part of the algorithm.}
 
}
\seealso{collpcm.control}

\author{
Jason Wyse
}

\references{
 Ryan, C., Wyse, J. and Friel, N. (2016).
 \emph{Bayesian model selection for the latent position cluster model for Social Networks.} 
 Network Science (accepted).
 
 Handcock, M. S., Raftery, A. E. and Tantrum, J. (2007).
 \emph{Model-Based Clustering for Social Networks.} 
 Journal of the Royal Statistical Society, Series A, Vol. 170, 301-354 <doi: 10.1111/j.1467-985X.2007.00471.x>
}


\examples{

# load the Monks data
data(Monks)

# run the model printing run updates to screen
# this is an illustrative example (it should be run for much longer)
z <- collpcm.fit( Monks, G=3, d=2, 
control=list( verbose=TRUE, sample=2500, interval=1, burn=500 ) )

# plot of the collpcm object
plot( z )

}



\keyword{networks}

