library(ggplot2)

source("../../R/performance.R")
source("../../R/datagen/simple_linear/dg_simple_linear.R")

models   <- list(m1 = create_model("./stan/lr_glm.stan",
                                   cmdstan_dir = "d:/cmdstan-develop/"),
                # m2 = create_model("./stan/lr_basic.stan",
                #                   cmdstan_dir = "d:/cmdstan-develop-cpu/"),
                 m3 = create_model("./stan/lr_glm.stan",
                                   cmdstan_dir = "d:/cmdstan-develop-cpu/"))

datagens <- list(d0 = dg_simple_linear(variants = expand.grid(seed = 0, 
                                                              n = 4^(8),
                                                              k = c(100), 
                                                              type = "normal")))

res <- benchmark(models, datagens, n_reps = 1,
                 temp_dir = paste0(getwd(), "/temp/"),
                 cmdstan_param_string = get_cmdstan_param_string())

print(res$all_results)
saveRDS(res, file = "./lr_results.rds")

g1 <- ggplot(res$all_results, aes(x = n, y = time_in_ms, colour = paste(cmdstan_dir, stan_file, sep = "; "))) + 
  geom_point() + geom_smooth() + facet_wrap(.~k)
plot(g1)
