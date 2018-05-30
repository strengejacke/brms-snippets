# Cross-lagged Panel model with Multi-Level design ----

# Let’s say, we have 3 time points and x and y were measured at each
# time point, while we have covariates that are constant accross all
# time points. From what I understood, the model would be written in
# brms like this:

f1a <- bf(x2 ~ x1 + y1 + covariate + (1 |id1|subject))
f1b <- bf(y2 ~ x1 + y1 + covariate + (1 |id1|subject))
f2a <- bf(x3 ~ x2 + y2 + covariate + (1 |id1|subject))
f2b <- bf(y3 ~ x2 + y2 + covariate + (1 |id1|subject))

model <- brm(f1a + f1b + f2a + f2b + set_rescor(TRUE), data = data)


# related post: http://discourse.mc-stan.org/t/cross-lagged-multilevel-panel-model/3992
