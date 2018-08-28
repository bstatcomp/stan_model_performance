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
  for (i in 1:n) {
    target += normal_lpdf(y[i] | X[i] * beta + alpha, sigma);
  }
}
