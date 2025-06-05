library(mgcv)
library(ggplot2)
library(ggplotify)
library(cowplot)
library(bestNormalize)
library(bestglm)

setwd("C:/Users/irmak/Desktop/datascience/lulzern/ML/ML1-HSLU")

X <- read.csv("gam_R/X_enc.csv")
y <- read.csv("gam_R/y_train_enc.csv")[,1]
X_test <- read.csv("gam_R/x_test_enc.csv")
y_test<- read.csv("gam_R/y_test_enc.csv")

# Combine into a single dataframe
df <- cbind(X, y_train = y)

# Convert dummy vars to factors
df$leader_ideology_rightist <- factor(df$leader_ideology_rightist)
df$leader_ideology_leftist <- factor(df$leader_ideology_leftist)
df$democracy_True <- factor(df$democracy_yes)
X_test$democracy_True <- factor(X_test$democracy_yes)



library(mgcv)
library(ggplot2)


model <- gam(
  y_train ~
    s(Per_capita_GNI) +
    s(agriculture_and_hunting_fishing_isic) +
    s(construction_isic) +
    s(Imports_of_goods_and_services) +
    s(mining_manifacturing_isic) +
    s(transport_storage_communication_isic) +
    s(GDP) +
    s(Urban_population_log) +
    leader_ideology_rightist +
    democracy_True +
    leader_ideology_leftist,
  data = df,
  method = "REML")

#BAM doesnt help with right skewness of residuals as well...
model <- bam(y_train ~
               s(Per_capita_GNI) +
               s(agriculture_and_hunting_fishing_isic) +
               s(construction_isic) +
               s(Imports_of_goods_and_services) +
               s(mining_manifacturing_isic) +
               s(transport_storage_communication_isic) +
               s(GDP) +
               s(Urban_population) +
               leader_ideology_rightist +
               democracy_True +
               leader_ideology_leftist, data = df, method = "fREML", select = TRUE)


residuals <- residuals(model)

# Plot the histogram of the residuals
hist(residuals,
     breaks = 40,
     col = "lightblue",
     border = "black",
     main = "Histogram of Deviance Residuals",
     xlab = "Residuals",
     ylab = "Frequency")

plots <- list()
n_terms <- length(model$smooth)
term_names <- attr(model$terms, "term.labels")

for (i in 1:n_terms) {
  # create the plot for term i
  p <- as.ggplot(~plot(model, select = i, residuals = TRUE, cex = 2))

  # modify the plot to rotate x-axis labels and add margin
  p <- p +
    ggtitle(term_names[i]) +     # add title with variable name
    theme(
      plot.title = element_text(hjust = 0.5, size = 8, face = "bold"),  # center & style
      axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
      axis.text.y = element_text(angle = 45, hjust = 1, size = 8),
      plot.margin = margin(t = 10, r = 10, b = 30, l = 40)
    )

  plots[[i]] <- p
}

# combine and save
grid_plot <- plot_grid(plotlist = plots, ncol = 3)
print(grid_plot)


# Save as PNG or PDF
ggsave("gam_grid_plots.png", grid_plot, width = 18, height = 15, dpi = 300)


summary(model)

# Residuals vs Fitted
plot(model$fitted.values, residuals(model, type = "deviance"),
     xlab = "Fitted values", ylab = "Deviance residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red", lty = 2)

# QQ Plot
qqnorm(residuals(model, type = "deviance"))
qqline(residuals(model, type = "deviance"), col = "blue")

gam.check(model)

# Save printed summary to a text file
sink("gam_model_summary.txt")
summary(model)
sink()
# Save gam.check output
sink("gam_check_output.txt")
gam.check(model)
sink()

# Save residuals vs fitted and QQ plot as a PNG
png("gam_residual_diagnostics.png", width = 800, height = 400)
par(mfrow = c(1, 2))

predictions <- predict(model, newdata = X_test, type = "response")

rmse <- sqrt(mean((y_test$military_expenditure - predictions)^2))
print(rmse)
mean_actual <- mean(y_test$military_expenditure)
relative_rmse_percent <- (rmse / mean_actual) * 100
print(paste("Relative RMSE (%):", round(relative_rmse_percent, 2)))

print(mean_actual)
relative_rmse <- 32.91
rmse_units <- relative_rmse * mean_actual / 100
print(rmse_units)



#YEOJOHNSON TRANSFORMATION
yj_obj <- yeojohnson(df$y_train)

model <- gam(
  yj_obj$x.t ~
    s(Per_capita_GNI) +
    s(agriculture_and_hunting_fishing_isic) +
    s(construction_isic) +
    s(Imports_of_goods_and_services) +
    s(mining_manifacturing_isic) +
    s(transport_storage_communication_isic) +
    s(GDP) +
    s(Urban_population_log) +
    leader_ideology_rightist +
    democracy_True +
    leader_ideology_leftist,
  data = df,
  method = "REML")

summary(model)

sink("YEOJOHNSON_model_summary.txt")
summary(model)
sink()

# Save gam.check output
sink("YEOJOHNSON_check_output.txt")
gam.check(model)
sink()

# Transform y_train
predictions_transformed <- predict(model, newdata = X_test)
predictions <- exp(predictions_transformed) - 1
predictions<-as.numeric(predictions)
predictions_original <- predict(yj_obj, newdata = predictions_transformed, inverse = TRUE)

rmse <- sqrt(mean((y_test$military_expenditure - predictions_original)^2))
print(rmse)
par(mfrow = c(1, 2))

# Residuals vs Fitted
plot(model$fitted.values, residuals(model, type = "deviance"),
     xlab = "Fitted values", ylab = "Deviance residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red", lty = 2)

# QQ Plot
qqnorm(residuals(model, type = "deviance"))
qqline(residuals(model, type = "deviance"), col = "blue")



dev.off()


