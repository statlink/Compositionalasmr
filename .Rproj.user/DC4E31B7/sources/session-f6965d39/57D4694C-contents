asmr <- function(y, x, a, yb = NULL, xnew = NULL, maxit = 100, tol = 1e-06 ) {

  reg <- function(para, ya, ax, a, ha, d, D) {
    be <- matrix(para, ncol = d)
    zz <- cbind(1, exp(ax %*% be))             
    ta <- rowSums(zz)
    za <- zz / ta                              
    ma <- (D / a * za - 1/a) %*% ha            
    as.vector(ya - ma)                         
  }

  jac <- function(para, ya, ax, a, ha, d, D) {
    n <- dim(ax)[1]  ;   p <- dim(ax)[2]
    be <- matrix(para, ncol = d)
    zz <- cbind(1, exp(ax %*% be))
    za <- zz / rowSums(zz)
    zh <- za %*% ha
    J <- matrix(0, nrow = n * d, ncol = d * p)
    Da <- D / a
    for ( j in 1:d ) {
      for ( k in 1:d ) {
        w <- Da * za[, k + 1] * (ha[k + 1, j] - zh[, j])
        J[ resid_idx[[ j ]], beta_idx[[ k ]] ] <-  -w * ax
      }
    }
    J
  }

  fn_w <- function(p) {
    r <- reg(p, ya, ax, a, ha, d, D)
    as.vector( r * rep(sqrt_w, times = d) )   
  }

  jac_w <- function(p) {
    J <- jac(p, ya, ax, a, ha, d, D)
    for ( j in 1:d ) {                        
      rows <- ( (j - 1) * n + 1 ):(j * n)
      J[rows, ] <- J[rows, ] * sqrt_w         
    }
    return(J)
  }

  runtime <- proc.time()

  if ( is.null(yb) ) {
    ya <- Compositional::alfa(y, a)$aff
  } else  ya <- yb
  x <- model.matrix(ya ~., data.frame(x) )
  ax <- a * x                                  
  D <- dim(y)[2]  ;  d <- D - 1                                   
  ha <- t( Compositional::helm(D) )              
  n <- dim(x)[1]  ;  p <- dim(x)[2]                                 

  beta_idx <- lapply(1:d, function(k) ( (k - 1) * p + 1):(k * p) )
  resid_idx <- lapply(1:d, function(j) ( (j - 1) * n + 1):(j * n) )

  init_lin <- Rfast::spatmed.reg(ya, x[, -1], tol = tol)$be
  beta <- as.vector(init_lin)
  eps <- 1e-8
  r <- reg(beta, ya, ax, a, ha, d, D)
  r_mat <- matrix(r, nrow = n, ncol = d)      
  res_norm <- sqrt( Rfast::rowsums(r_mat^2) ) 
  norm1 <- sum(res_norm)
  
  for ( it in 1:maxit ) {
          
    w <- 1 / (res_norm + eps)
    sqrt_w <- sqrt(w)
    mod <- tryCatch(
      minpack.lm::nls.lm( par = beta, fn = fn_w, jac = jac_w ),
      error = function(e) {
        warning(paste("nls.lm failed at IRLS iteration", it, ":", e$message))
        return(NULL)
      }
    )

    if ( is.null(mod) )  break
    beta <- mod$par
    r <- reg(beta, ya, ax, a, ha, d, D)
    r_mat <- matrix(r, nrow = n, ncol = d)      
    res_norm <- sqrt( Rfast::rowsums(r_mat^2) ) 
    norm2 <- sum(res_norm)
    
    if ( norm1 - norm2 < tol ) {
      break
    }
    norm1 <- norm2

  }

  be <- matrix(beta, ncol = d)
  if ( is.null(colnames(y)) ) {
    colnames(be) <- paste("Y", 1:d, sep = "")
  } else  colnames(be) <- colnames(y)[-1]
  est <- NULL
  if ( !is.null(xnew) ) {
    xnew <- model.matrix(~., data.frame(xnew) )
    est <- cbind( 1, exp(xnew %*% be) )
    est <- est/Rfast::rowsums(est)
  }
  if ( is.null(colnames(y)) ) {
    colnames(be) <- paste("Y", 1:d, sep = "")
  } else  colnames(be) <- colnames(y)[-1]
  rownames(be)  <- colnames(x)

  runtime <- proc.time() - runtime

  list(runtime = runtime, iters = it, norm = sum(res_norm), be = be, est = est)
}