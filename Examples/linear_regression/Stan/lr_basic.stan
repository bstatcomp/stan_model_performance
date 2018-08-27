data {
  int<lower=1> k;
  int<lower=0> n;
  matrix[n, k] X;
  vector[n] y;
}

parameters {
  vector[k] beta;
  real<lower=0> sigma;
  real alpha;
}

model {
  target += normal_lpdf(y | X * beta + alpha, sigma);
}
