test_that("IVQR funciona correctamente", {
  set.seed(123)
  X <- cbind(rnorm(100), rnorm(100))
  Z <- cbind(rnorm(100))
  e = Z + rnorm(100)

  y <- 2*X[,1] + 3*X[,2] + 2*e + rnorm(100)



  resultado <- ivqr(y, e, X , Z, tau = 0.5)

  expect_true(is.list(resultado))
  expect_equal(length(resultado$coefficients), ncol(X) + ncol(Z) + 1)
  expect_true(norm(as.matrix(resultado$coefficients['e'])-2)<0.1)
})
