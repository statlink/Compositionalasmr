\name{cv.asmr}
\alias{cv.asmr}
\title{
K-fold cross-validation for the \eqn{\alpha}-smr
}

\description{
K-fold cross-validation for the \eqn{\alpha}-smr.
}

\usage{
cv.asmr(y, x, a = seq(0.1, 1, by = 0.1), maxit = 500, tol = 1e-6,
nfolds = 10, folds = NULL, ncores = 1, seed = NULL)
}

\arguments{
\item{y}{
A matrix with compositional data. zero values are allowed.
}
\item{x}{
A matrix with the continuous predictor variables or a data frame including categorical predictor variables.
}
\item{a}{
The value of the power transformation, it has to be between -1 and 1. If zero values are present it has to be greater than 0. If \eqn{\alpha=0} the isometric log-ratio transformation is applied.
}
\item{maxit}{
The maximum number of iterations the IRLS algorithm will perform.
}
\item{tol}{
The tolerance value to terminate the IRLS algorithm.
}
\item{nfolds}{
The number of folds to split the data.
}
\item{folds}{
If you have the list with the folds supply it here. You can also leave it NULL and it will create folds.
}
\item{ncores}{
The number of cores to use. IF you have a multicore computer it is advisable to use more than 1. It makes the procedure faster. It is advisable to use it if you have many observations and or many variables, otherwise it will slow down th process.
}
\item{seed}{
You can specify your own seed number here or leave it NULL.
}
}

\details{
Tuning the value of \eqn{\alpha} in the \eqn{\alpha}-smr takes place using
K-fold cross-validation.
}

\value{
A list including:
\item{runtime}{
The runtime required by the cross-validation.
}
\item{perf}{
A vector with the average Kullback-Leibler divergence, for every value of \eqn{\alpha}.
}
\item{opt}{
A vector with the minimum Kullback-Leibler divergence and the optimal value of \eqn{\alpha}.
}
}

\references{
Tsagris M. and Pantazis Y. (2026). The \eqn{\alpha}--regression for compositional data: a unified framework for standard, temporal and spatial regression models including compositional predictors.
https://arxiv.org/pdf/2510.12663

Tsagris M. (2015). Regression analysis with compositional data containing zero values.
Chilean Journal of Statistics, 6(2): 47-57.
https://arxiv.org/pdf/1508.01913v1.pdf

Tsagris M.T., Preston S. and Wood A.T.A. (2011). A data-based power transformation for compositional data.
In Proceedings of the 4th Compositional Data Analysis Workshop, Girona, Spain.
https://arxiv.org/pdf/1106.1451.pdf
}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{ \link{asmr}, \link{asmr.path}
}
}

\examples{
data(fadn)
y <- fadn[, 3:7]
x <- fadn[, 8]
mod <- cv.asmr(y, x, a = c(0.5, 1))
}

