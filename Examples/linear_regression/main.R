library(ggplot2)

setwd("d:/work/stan_model_performance//Examples/linear_regression")

source("../../R/performance.R")
source("../../R/datagen/simple_linear/dg_simple_linear.R")

models   <- list(m0 = create_model("./stan/lr_basic.stan",
                                   cmdstan_dir = "d:/work/Stan/cmdstan-develop/"),
                 m1 = create_model("./stan/lr_glm.stan", 
                                   cmdstan_dir = "d:/work/Stan/cmdstan-develop/"))

datagens <- list(d0 = dg_simple_linear(variants = expand.grid(seed = 0, 
                                                              n = 4^(2:7),
                                                              k = 10, 
                                                              type = "normal")))

res <- benchmark(models, datagens, n_reps = 5,
                 cmdstan_dir = "d:/work/Stan/cmdstan-develop/",
                 temp_dir = paste0(getwd(), "/temp/"),
                 cmdstan_param_string = get_cmdstan_param_string())

print(res$all_results)

g1 <- ggplot(res$all_results, aes(x = n, y = time_in_ms, colour = paste(cmdstan_dir, stan_file, sep = "; "))) + 
  geom_point() + geom_smooth()
plot(g1)