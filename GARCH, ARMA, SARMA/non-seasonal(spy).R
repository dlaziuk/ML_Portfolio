

```{r Imports}
library(zoo)
library(tseries)
library(forecast)
library(TSA)
library(MuMIn)
require(rugarch)
library(rugarch)
library(LSTS)
library(quantmod)
library(ggplot2)
library(dplyr)
```

```{r  Loading Data}
raw<-read.csv("/Users/davidlaziuk/Desktop/MA641 Project/SPY.csv")$Adj.Close
data<-ts(raw[1:252])
future<-ts(raw[253:274])
#Plotting raw data
plot(data,xlab='Time',ylab='Adjusted Close',main='SPY Time Series')
```

```{r Seasonality Testing}
#Decomposition
decomposed<-stl(ts(raw[1:252],frequency=5),s.window="periodic")
plot(decomposed,main='Decomposed Time Series')
raw_range<-range(ts(raw,frequency=5))
seasonal_range <- range(decomposed$time.series[, "seasonal"])
cat("Original Time Series Range: ", raw_range[1], " - ", raw_range[2], "\n")
cat("Seasonal Component Range: ", seasonal_range[1], " - ", seasonal_range[2], "\n")
print('The magnitude of the seasonal component is insignificant')
#ACF/PACF
acf(ts(raw,frequency=5),main='Raw Data ACF')
print('No significant seasonality indication in ACF')
pacf(ts(raw,frequency=5),main='Raw Data PACF')
print('No significant seasonality indication in PACF')
#Should be safe to proceed with non-seasonal analysis
rm(raw_range,seasonal_range,decomposed)
```
```{r Stationarity Testing}
#Augmented Dicky-Fuller
cat("ADF test: p-value =", adf.test(data)$p.value, "\n")
print('According to the ACF and ADF test, the data is not stationary.')
#Data Augmentation
#Function to test augmented data
test<-function(data,name){
  layout(matrix(c(1,1,2,3),2,2,byrow=TRUE))
  plot(data,type='l',main=paste(name,'Time Series'))
  acf(data,lag.max=50,main=paste(name,' ACF'))
  pacf(data,lag.max=50,main=paste(name,' PACF'))
  print(name)
  eacf(data)
  cat(name,"ADF test p-value:",adf.test(data)$p.value,"\n")
  cat(name,"KPSS test p-value:",kpss.test(data)$p.value,"\n")
}
#-------------------------------------------------------------------------------
#Raw Data
test(data,'Raw') #NOT STATIONARY
```
```{r}
#Log Data
log_data<-(log(data))
test(log_data,'Log Data') #NOT STATIONARY
```
```{r}
#First Difference of Data
first_diff <- diff(data)
test(first_diff,'First Dif') #STATIONARY
```
```{r}
#Log Differenced Data (return)
log_first_diff<-diff(log(data))
test(log_first_diff,'Log First Difference') #STATIONARY
```
```{r}
#Abs Return
abs_return<-abs(diff(log(data)))
test(abs_return,'Abs Log Diff') #STATIONARY
```
```{r}
#Squared Return
sqr_return<-(diff(log(data)))^2
test(sqr_return,'Sqr Log First Diff') #STATIONARY
```


Stationary Data:
Single Difference
Log Single Difference
Abs of Return (Close Enough)
Return ^ 2 (Close Enough)


```{r}
#Finding Models
#Fucntion to test AICc & BIC
test_aicc<-function(data) {
  orders <- list(c(0,0,0),c(1,0,0),c(0,0,1),c(1,0,1),c(0,0,2),c(1,0,2),c(2,0,0),c(2,0,1),c(2,0,2),
                 c(0,0,3),c(3,0,0),c(1,0,3),c(3,0,1),c(2,0,3),c(3,0,2),c(3,0,3))
  for (order in orders) {
    arima_model<-Arima(data,order=order)
    aicc_value<-AICc(arima_model)
    bic_value<-BIC(arima_model)
    cat("ARIMA(",order[1],",",order[3],")  AICc:",aicc_value," BIC: ",bic_value, "\n")
  }
}
#-------------------------------------------------------------------------------
#First Difference
test_aicc(first_diff)
```
NOTHING BEATS 0,0
```{r}
#Log Differenced
test_aicc(log_first_diff)
```
NOTHING BEATS 0,0
```{r}
#Abs Differenced Data
test_aicc(abs_return)
```
(1,2),(2,1),(2,2),(1,3)(3,1) BEAT (0,0) IN AICc
```{r}
#Sqr Differenced Data
test_aicc(sqr_return)
```
NOTHING BEATS (0,0)
```{r}
#WE WILL TEST (1,2),(2,1),(2,2),(1,3)(3,1) FOR |Return| (GARCH)
test_model<-function(data,name){
  layout(matrix(c(1,1,2,3),2,2,byrow=TRUE))
  plot(data$res,main=name)
  acf(data$res,lag.max=254,main='Residuals ACF')
  pacf(data$res,lag.max=254,main='Residuals PACF')
  print(data)
  layout(1)
  tsdiag(data,gof=254)
  hist(window(rstandard(data)),xlab='Standardized Residuals')
  qqnorm(window(residuals(data)))
  qqline(window(residuals(data)))
  shapiro.test(residuals(data))
}
#-------------------------------------------------------------------------------
garch12<-Arima(abs_return,order=c(1,0,2))
test_model(garch12,'GARCH(1,2) Residuals')
```
```{r}
garch21<-Arima(abs_return,order=c(2,0,1))
test_model(garch21,'GARCH(2,1) Residuals')
```
```{r}
garch22<-Arima(abs_return,order=c(2,0,2))
test_model(garch22,'GARCH(2,2) Residuals')
```
```{r}
garch13<-Arima(abs_return,order=c(1,0,3))
test_model(garch13,'GARCH(1,3) Residuals')
```
```{r}
garch31<-Arima(abs_return,order=c(3,0,1))
test_model(garch31,'GARCH(3,1) Residuals')
```
GARCH(1,3) has highest log likelihood
GARCH(1,2) has lowest AIC/BIC
ALL MODELS FAIL NORMALITY

```{r}
reverse_abs_diff <- function(last_value, abs_return_forecast) {
  sign_forecast <- sign(abs_return_forecast)
  log_return_forecast <- sign_forecast * abs_return_forecast
  log_return_forecast <- c(last_value, log_return_forecast[-1])
  return(log_return_forecast)
}
pred <- function(model, name){
  # Forecasting
  n_forecast <- 22
  abs_return_forecast <- forecast(model, h=n_forecast)$mean
  # Reverse the transformation for the forecasted values and combine with the original data
  log_data <- log(data)
  last_log_return <- tail(diff(log_data), 1)
  log_return_forecast <- reverse_abs_diff(last_log_return, abs_return_forecast)
  last_value <- tail(data, 1)
  original_forecast <- c(last_value, rep(NA, n_forecast))
  for (i in 1:n_forecast) {
    original_forecast[i + 1] <- original_forecast[i] * exp(log_return_forecast[i])
  }
  # Plot
  original_ts <- ts(data)
  future_ts <- ts(future, start = 253)
  forecast_ts <- ts(original_forecast[-1], start = 253)
  finite_values <- c(data, future, original_forecast[-1])
  finite_values <- finite_values[is.finite(finite_values)]
  plot(original_ts, xlim = c(1, 252 + n_forecast), ylim = range(finite_values), type = "l", col = "black", lwd = 1, main = paste("Original Data and Forecast with ",name), xlab = "Time", ylab = "Value")
  lines(future_ts, col = "blue", lwd = 1)
  lines(forecast_ts, col = "red", lwd = 1)
  legend("topleft", legend = c("Observed", "Future", "Forecast"), col = c("black", "blue", "red"), lty = 1, lwd = 1, bty = "n")
}
#-------------------------------------------------------------------------------
pred(garch12,'GARCH(2,1)')
#-------------------------------------------------------------------------------
pred(garch13,"GARCH(3,1)")
```








Experimenting with Rolling Mean detrending:















```{r}
rollingmean<-rollmean(log(data),k=22, fill = NA)
Detrended<-log(data)-rollingmean
rolled_data<-na.omit(Detrended)
test(rolled_data,'Rolling Mean')
```

```{r}
test_aicc(rolled_data)
```
(1,3)(1,2) suggested from ACF/PACF
(2,2)(3,1)and(3,2) look good on AICc
(2,1) looks good for BIC
```{r}
roll13<-Arima(rolled_data,order=c(1,0,3))
test_model(roll13,'Rolled ARMA(1,3)')
```
```{r}
roll12<-Arima(rolled_data,order=c(1,0,2))
test_model(roll12,'Rolled ARMA(1,2)')
```
```{r}
roll22<-Arima(rolled_data,order=c(2,0,2))
test_model(roll22,'Rolled ARMA(2,2)')
```
```{r}
roll31<-Arima(rolled_data,order=c(3,0,1))
test_model(roll31,'Rolled ARMA(3,1)')
```
```{r}
roll32<-Arima(rolled_data,order=c(3,0,2))
test_model(roll32,'Rolled ARMA(3,2)')
```
```{r}
roll21<-Arima(rolled_data,order=c(2,0,1))
test_model(roll21,'Rolled ARMA(2,1)')
```
(2,1) Seems to be the best

```{r}
roll21_fore<-forecast(roll21,h=22)
plot(roll21_fore)
```

```{r}
future_rollingmean <- rollmean(log(c(data[(length(data)-22+1):length(data)], future)), k =22, fill = NA)
detrended_forecast <- roll21_fore$mean + tail(future_rollingmean,22)
forecast_values <- exp(detrended_forecast)
data_idx <- seq(1, length(data))
future_idx <- seq(length(data) + 1, length(data) + length(future))
df <- data.frame(Time = c(data_idx, future_idx),
                 Value = c(data, forecast_values),
                 Type = c(rep("Original", length(data)), rep("Forecast", length(future))))
true_df <- data.frame(Time = future_idx,
                      Value = future,
                      Type = "True")
combined_df <- bind_rows(df, true_df)
ggplot(combined_df, aes(x = Time, y = Value, color = Type)) +
  geom_line() +
  scale_color_manual(values = c("Original" = "blue", "Forecast" = "red", "True" = "green")) +
  labs(title = "Time Series Forecast",
       x = "Time",
       y = "Value",
       color = "Type") +
  theme_minimal()
```



