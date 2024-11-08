[![My Skills](https://skillicons.dev/icons?i=r&theme=light)](https://skillicons.dev)

# IVQR: Instrumental Variable Quantile Regression

Este paquete implementa el modelo de regresión cuantil con variables instrumentales (IVQR) siguiendo el enfoque de Chernozhukov y Hansen.

## Instalación

Puedes instalar el paquete directamente desde GitHub con el siguiente comando en R:

```r
# Instala devtools si aún no está instalado
install.packages("devtools")

# Instala IVQR desde GitHub
devtools::install_github("https://github.com/LautaroLasorsa/IVQR")
```

## Uso

El paquete incluye la función

```r
ivrq(y, e, X, Z, tau = 0.5, method = "br", grilla = seq(-10,10,0.1))
```

Esta función buscara estimar el modelo $ y = \beta * e + \gamma * X + u $, donde $ e = \pi * Z + v $, con $\pi$ el coeficiente de la variable instrumental $Z$. Para esto generará los modelos $y - \beta * e = \gamma * X + \pi * Z + u$ y utilizará el valor de $\beta$ que minimice $||\pi||$.

La grilla de valores es el espacio de busqueda de los valores de $\beta$. 

