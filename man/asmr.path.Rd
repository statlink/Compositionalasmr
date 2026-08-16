\name{asmr.path}
\alias{asmr.path}
\title{
Regression with compositional data using the \eqn{\alpha}-transformation
}

\description{
Regression with compositional data using the \eqn{\alpha}-transformation.
}

\usage{
asmr.path(y, x, a = seq(-1, 1, by = 0.1), xnew = NULL, maxit = 100, 
tol = 1e-6, ncores = 1)
}

\arguments{
\item{y}{
A matrix with the compositional data.
}
\item{x}{
A matrix with the continuous predictor variables or a data frame including categorical predictor
variables.
}
\item{a}{
A vector with the \eqn{\alpha} values of the power transformation, it has to be between -1 and 1.
}
\item{xnew}{
If you have new data use it, otherwise leave it NULL.
}
\item{maxit}{
The maximum number of iterations the IRLS algorithm will perform.
}
\item{tol}{
The tolerance value to terminate the IRLS algorithm.
}
\item{ncores}{
The number of cores to use for parallel computations.
}
}

\details{
The \eqn{\alpha}-transformation is applied to the compositional data first and then
non-linear spatial median regression using the iteratively reqeighted least squares (IRLS)
algorithm is performed. This takes place for each value of \eqn{\alpha}.
}

\value{
For the alfa.reg() function a list including:
\item{runtime}{
The time required by the regression.
}
\item{res}{
A list with two components: "be", the estimated regression coefficients, and "est", 
the fitted values, both for each value of \eqn{\alpha}.
}
\item{covbe}{
The covariance matrix if covb was set to TRUE, otherwise NULL.
}
}

\references{
Tsagris M. and Pantazis Y. (2026). The \eqn{\alpha}--regression for compositional data: a unified framework for standard, temporal and spatial regression models including compositional predictors.
https://arxiv.org/pdf/2510.12663

Tsagris M. (2015). Regression analysis with compositional data containing zero values.
Chilean Journal of Statistics, 6(2): 47-57.
https://arxiv.org/pdf/1508.01913v1.pdf

Tsagris M.T., Preston S. and Wood A.T.A. (2011). A data-based power transformation for
compositional data.
In Proceedings of the 4th Compositional Data Analysis Workshop, Girona, Spain.
https://arxiv.org/pdf/1106.1451.pdf

Mardia K.V., Kent J.T., and Bibby J.M. (1979). Multivariate analysis. Academic press.

Aitchison J. (1986). The statistical analysis of compositional data. Chapman & Hall.
}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{\link{asmr}, \link{cv.asmr}
}
}

\examples{
data(fadn)
y <- fadn[, 3:7]
x <- fadn[, 8]
mod <- asmr.path(y, x, a = c(0.1, 0.2))
}

