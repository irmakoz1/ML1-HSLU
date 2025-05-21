library(mgcv)
library(ggplot2)
library(ggplotify)
library(cowplot)
setwd("C:/Users/irmak/Desktop/datascience/lulzern/ML/ML1-HSLU")
# Load data
X <- read.csv("X_enc.csv")
y <- read.csv("y_train_enc.csv")[,1]  
X_test <- read.csv("x_test_enc.csv")
y_test<- read.csv("y_test_enc.csv")

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


# Extract plots into a list
plots <- list()
n_terms <- length(model$smooth)

for (i in 1:n_terms) {
  p <- as.ggplot(~plot(model, select = i, residuals = TRUE, cex = 2))
  plots[[i]] <- p
}

# Combine into a grid
grid_plot <- plot_grid(plotlist = plots, ncol = 3)  # Adjust ncol as needed

# Save as PNG or PDF
ggsave("gam_grid_plots.png", grid_plot, width = 16, height = 12, dpi = 300)


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

# new_data is a data frame with the same predictors (x1, x2)
predictions <- predict(model, newdata = X_test, type = "response")

rmse <- sqrt(mean((y_test$military_expenditure - predictions)^2))
print(rmse)


any(is.na(y_test))
any(is.na(predictions))

any(is.nan(y_test))
any(is.nan(predictions))

dev.off()


