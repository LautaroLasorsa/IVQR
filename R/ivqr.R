#' IVQR: Instrumental Variable Quantile Regression
#'
#' Esta función implementa el modelo de regresión cuantil con variables instrumentales (IVQR) siguiendo el enfoque de Chernozhukov y Hansen.
#' @param y Vector de la variable dependiente.
#' @param e Vector de la variable endogena.
#' @param X Matriz de variables explicativas.
#' @param Z Matriz de variables instrumentales.
#' @param tau Cuantil a estimar (por defecto, la mediana).
#' @param method Método de optimización (por defecto "br" para Barrodale-Roberts).
#' @param grilla Grilla de valores para la busqueda del coeficiente de e (por defecto seq(-10,10,0.1)).
#' @return Una lista con los coeficientes, residuales y valores ajustados.
#' @export
ivqr <- function(y, e, X, Z, tau = 0.5, method = "br", grilla = seq(-10,10,0.1)) {
  # Cargar el paquete necesario
  if (!requireNamespace("quantreg", quietly = TRUE)) {
    stop("El paquete 'quantreg' es necesario para esta función.")
  }
  
  # Validaciones de dimensiones
  if (nrow(X) != length(y) || nrow(Z) != length(y)) {
    stop("Las dimensiones de X, Z y y deben coincidir.")
  }
  
  fit_optimo = NULL
  coeficiente_optimo = NULL

  for(coeficiente in grilla){
    y_hat = y - coeficiente * e
    fit <- quantreg::rq(y_hat ~ X + Z, tau = tau, method = method)
    
    if(is.null(fit_optimo) ||norm(as.matrix(coefficients(fit)[(ncol(X)+1):(ncol(X)+ncol(Z))])) < norm(as.matrix(coefficients(fit_optimo)[(ncol(X)+1):(ncol(X)+ncol(Z))]))){
      fit_optimo = fit
      coeficiente_optimo = coeficiente
    }
  }
  
  fit_optimo$coefficients['e'] = coeficiente_optimo
  
  return(list(coefficients = fit_optimo$coefficients, residuals = fit_optimo$residuals, fitted.values = fit_optimo$fitted.values))
}
