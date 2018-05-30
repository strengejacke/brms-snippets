# Prior-Definition in brms ----


# Let's assume an average effect of -5 for "physrees" and .3 for "drugs", and
# the SD is 10. Then the prior for "physres" and "drugs" are defined like this:

bprior <-
  prior(normal(-5, 10), class = "b", coef = "phsyres") +
  prior(normal(.3 , 10), class = "b", coef = "drugs")

# To prevent a too strong shrinkage of uncertainty, the scale of the prior
# distribution should be large enough. If no assumptions about the scale of
# the effect are made, a recommended way (for normally distributed priors) is
# to use a scale of 2.5 and adjust it by dividing the scale by the standard
# deviation of the related predictor and multiply it with the standard
# deviation of the outcome (see https://cran.r-project.org/web/packages/rstanarm/vignettes/priors.html):
#
# scale is 2.5 * sd(y) / sd(x)
#
# More priors kann be added with "+".


# An alternative way to specify priors is the usage of "standvars()"

prior_means <- c(0, prior_age, 0, prior_dem_hi, prior_sex, 0, prior_physres, 0, 0, prior_drugs)
stanvars <- stanvar(prior_means)
bprior <- prior(normal(prior_means, 10), class = "b")
fit <- brm(..., prior = bprior, stanvars = stanvars)
