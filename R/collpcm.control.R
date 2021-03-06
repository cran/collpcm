collpcm.control <- function( x = list() , n, d )
{
   
	members <- c( "G", "Gmax", "Gprior", "xi", "psi", "gamma",
					  "delta", "alpha", "kappa", "betainit", "Xinit", 
					  "sample", "burn", "interval", "model.search", "pilot",
					  "sd.beta.prop", "sd.X.prop", "gamma.update", 
					  "store.sparse", "adapt", "adapt.interval",
					  "MKL", "verbose" )
						
	missing <- setdiff(members,names(x))
	
	for(i in missing)
	{
	
		# ~~~ Hyperparameters ~~~ #
		#if( i == "Gmin" )
		#	x$Gmin <- 1
		if( i == "G" )
			x$G <- sample( 2:5, size=1 )
		if( i == "Gmax" )
			x$Gmax <- floor(n/2)
		if( i == "Gprior" )
			x$Gprior <- dpois( 0:x$Gmax, lambda=1., log=TRUE )
		if( i == "xi" )
			x$xi <- 0
		if( i == "psi" )
			x$psi <- sqrt(2.)
		if( i == "gamma" )	
			x$gamma <- 0.103
		if( i == "delta" )
			x$delta <- 2
		if( i == "alpha" )
			x$alpha <- 3
		if( i == "kappa" )
			x$kappa <- .1
		
		# ~~~ Parameters initialization ~~~ #
		if(i == "betainit")
			x$betainit <- rnorm( 0, sd=.01 )
		#if(i == "theta")
		#	x$theta <- .001
		if(i == "Xinit")
			x$Xinit <- rnorm(d*n,0,1)
			
		# ~~~ MCMC length and type ~~~ #
		if(i == "sample")
			x$sample <- 5000
		if(i == "burn")
			x$burn <- 5000
		if(i == "interval")
			x$interval <- 10
		if(i == "model.search")
			x$model.search <- TRUE
		if( i== "pilot" )
			x$pilot <- 0
		
		# ~~~ Proposal sd's for MCMC ~~~ #
		if( i == "sd.beta.prop" )
			x$sd.beta.prop <- sqrt(0.5)
		if( i == "sd.X.prop" )
			x$sd.X.prop <- 1
		#if( i == "sd.theta.prop" )
		#	x$sd.theta.prop <- sqrt(0.1)
		
		# ~~~ Updates and storage ~~~  #
		if( i == "gamma.update" )
			x$gamma.update <- TRUE
		if( i == "store.sparse" )
			x$store.sparse <- FALSE
		if( i == "adapt" )
			x$adapt <- TRUE
		if( i == "adapt.interval" )
			x$adapt.interval <- 200
		if( i == "MKL" )
			x$MKL <- TRUE
		#if( i == "bradley.terry" )
		#	x$bradley.terry <- FALSE
		
		# ~~~ Progression on screen ~~~ #
		if( i == "verbose" )
			x$verbose <- FALSE
			
	}
	
	return( x )

}
