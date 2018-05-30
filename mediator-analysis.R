# Mediator-Analysis ----

# Suppose you have a multilevel mediation model with response y, predictor x
# and mediator m as well as multiple observations per person. Than you could
# specify a multivariate multilevel model via

bfy <- bf(y ~ x + m + (1|ID|person))
bfm <- bf(m ~ x + (1|ID|person))

bform <- bfy + bfm + set_rescor(FALSE)
fit <- brm(bform, <your data>, ...)

# Direct effect: coef(x) from bfy
# Mediator effect: coef(m) from bfy
# Indirect effect: coef(x) from bfm * coef(m) from bfy
# proportion mediated: (coef(x) from bfm * coef(m) from bfy) / (coef(x) from bfm * coef(m) from bfy + coef(x) from bfy)

# The |ID| part just makes sure the random effects are correlated and
# set_rescor(FALSE) ensures that no residual correlation between y and z is
# estimated since we already have z as predictor for y.

# There's a function to automatically compute the mediation-results:
library(sjstats)
mediation(fit)


# related post: http://discourse.mc-stan.org/t/mediation-question-using-brms/4260
