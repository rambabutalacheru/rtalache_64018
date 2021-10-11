---
output:
  word_document: default
  html_document: default
  pdf_document: default
---
```{r}
library(lpSolveAPI)
b <- make.lp(0,9,verbose = "neutral")
b

```


Adding Constraints and solving the problem

```{r}
add.constraint(b, c(1,1,1,0,0,0,0,0,0), "<=", 750 )
add.constraint(b, c(0,0,0,1,1,1,0,0,0), "<=", 900)
add.constraint(b, c(0,0,0,0,0,0,1,1,1), "<=", 450)
add.constraint(b, c(20,15,12,0,0,0,0,0,0), "<=", 13000)
add.constraint(b, c(0,0,0,20,15,12,0,0,0), "<=", 12000)
add.constraint(b, c(0,0,0,0,0,0,20,15,12), "<=", 5000)
add.constraint(b, c(1,1,1,0,0,0,0,0,0), "<=", 900)
add.constraint(b, c(0,0,0,1,1,1,0,0,0), "<=", 1200)
add.constraint(b, c(0,0,0,0,0,0,1,1,1), "<=", 750)
add.constraint(b, c(6, 6, 6, -5, -5, -5, 0, 0, 0), "=", 0)
add.constraint(b, c( 3, 3, 3, 0, 0, 0, -5, -5, -5), "=", 0)

set.objfn(b, c(420,360,300,420,360,300,420,360,300))
lp.control(b, sense='max')

```

```{r}
b.col <- c("P 1","P 2","P 3","p 4","p 5","p 6","p 7","p 8","p 9") 
b.row <- c("Y1l","Y1m","Y1s","Y2l", "Y2m","Y2s","Y3l","Y3m","Y3s","%C1","%C2") 
dimnames(b) <- list(b.row,b.col)

b

solve(b)

get.objective(b)

get.variables(b)

```



Question 2:

Reduced Costs

```{r}
get.sensitivity.obj(b)
```


Shadow Prices

```{r}
get.sensitivity.rhs(b)
```

Dual solution

```{r}
get.dual.solution(b)
```



Question 3:

```{r}
Sensivity<-data.frame(get.sensitivity.rhs(b)$duals[1:21],get.sensitivity.rhs(b)$dualsfrom[1:21],get.sensitivity.rhs(b)$dualstill[1:21])
names(Sensivity)<-c("Price","low","High")
Sensivity
```




Question 4:



```{r}
objfun = c(420,420,420,360,360,360,300,300,300)
lp.control(b, sense = 'max')

lpDual <- make.lp(0,12)
set.objfn(lpDual, c(750,900,450,13000,12000,5000,900,1200,750,0,0,0))

lp.control(lpDual,sense='min',simplextype="dual")
add.constraint(lpDual ,c(1,0,0,20,0,0,1,0,0,900,0,450), ">=", 420)
add.constraint(lpDual ,c(0,1,0,0,20,0,1,0,0,-750,450,0), ">=", 420)
add.constraint(lpDual ,c(0,0,1,0,0,20,1,0,0,0,-900,-750), ">=", 420)

add.constraint(lpDual ,c(1,0,0,15,0,0,0,1,0,900,0,450), ">=", 360)
add.constraint(lpDual ,c(0,1,0,0,15,0,0,1,0,-750,450,0), ">=", 360)
add.constraint(lpDual ,c(0,0,1,0,0,15,0,1,0,0,-900,-750), ">=", 360)

add.constraint(lpDual ,c(1,0,0,12,0,0,0,0,1,900,0,450), ">=", 300)
add.constraint(lpDual ,c(0,1,0,0,12,0,0,0,1,-750,450,0), ">=", 300)
add.constraint(lpDual ,c(0,0,1,0,0,12,0,0,1,0,-900,-750), ">=", 300)


solve(lpDual)                     
get.objective(lpDual)           
get.variables(lpDual)
get.constraints(lpDual) 
```

