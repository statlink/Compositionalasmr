asmr.path <- function(y, x, a = seq(-1, 1, by = 0.1), xnew = NULL, maxit = 100, tol = 1e-6, ncores = 1) {

  runtime <- proc.time()

  if ( min(y ) == 0)  a <- a[a > 0]
  la <- length(a)

  fit_alpha <- function(i) {
    ya <- Compositional::alfa(y, a[i])$aff
    mod <- Compositionalasmr::asmr(y, x, a = a[i], yb = ya, xnew = xnew, maxit = maxit, tol = tol)
    list(be = mod$be, est = mod$est)
  }

  if ( ncores > 1 ) {
    cl <- parallel::makeCluster(ncores)
    parallel::clusterExport( cl,varlist = c("y", "x", "a", "xnew", "maxit", "tol", "asmr", "fit_alpha"),
                             envir = environment() )
    parallel::clusterEvalQ(cl, {
      library(Compositional)
      library(minpack.lm)
      library(Rfast)
    })
    res <- parallel::parSapply(cl, 1:la, fit_alpha, simplify = FALSE, USE.NAMES = FALSE)
    parallel::stopCluster(cl)

  } else  res <- sapply(1:la, fit_alpha, simplify = FALSE, USE.NAMES = FALSE)

  runtime <- proc.time() - runtime
  res$runtime <- runtime

  res
}
