# Time-varying covariates ----

# Time-varying covariates are most flexibly modelled with splines.
# Here are some examples, from simple longitudinal models to models
# with time-varying covariates.
#
# Example data available here:
# http://discourse.mc-stan.org/t/longitudinal-mediation-analysis/4742
#
# Examples slightly modified for univariate models.
#
# y = outcome (continuous / Gaussian)
# t = time-points
# m = time-varying covariate
# x = time-constant covariate
# id = subject-ID

# Model 1 - constant change in time ----
brm(y ~ t + m + x + (1 + t | id), data)

# Model 2 - constant change in time, different slopes depending on covariate ----
# (interaction)
brm(y ~ t * m + x + (1 + t | id), data)

# Model 3 - non-linear change in time ----
brm(y ~ t + I(t^2) + m + x + (1 + t | id), data)

# Model 4 - non-linear change in time, different slopes depending on covariate ----
# (interaction)
brm(y ~ t * m + I(t^2) * m + x + (1 + t | id), data)

# Model 5 - non-linear change in time, time-varying covariate ----
# (interaction with non-linear covariate)
brm(y ~ y ~ t * m + I(t^2) * m + t * I(m^2) + I(t^2) * I(m^2) + x + (1 + t | id), data)

# Model 6 - non-linear change in time, time-varying covariate ---
# (cubic instead of quadratic interaction)
model6 <- brm(
  y ~ t * m + I(t^2) * m + I(t^3) * m + t * I(m^2) + t * I(m^3) +
    I(t^2) * I(m^2) + I(t^2) * I(m^3) + I(t^3) * I(m^2) +
    I(t^3) * I(m^3) + x + (1 + t | id),
  data
)

# This final model with splines is almost identical to model 6,
# when comparing marginal effects. The time-varying covariate
# needs to be specified in the "by"-argument from the spline-term.
# Time "t" is non-linear (spline), "m" varies over time.
model7 <- brm(y ~ s(t) + s(t, by = m) + x + (1 + t | id), data)
