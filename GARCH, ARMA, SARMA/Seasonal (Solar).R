```{r}
#Imports
library(zoo)
library(tseries)
library(forecast)
library(fracdiff)
library(TSA)
library(bsts)
```
```{r}
#Loading Solar Data
filename<-"/Users/davidlaziuk/Desktop/MA641 Project/SLC.csv"
raw<-read.csv(filename)$kWh
raw<-ts(raw,frequency=12)
#Plotting raw data
plot(raw,xlab='Time',ylab='kWh',main='SLC Monthly Solar')
rm(filename)
```
```{r}
#Testing for seasonality
#Decomposition
decomposed<-stl(raw,s.window="periodic")
plot(decomposed,main='Decomposed Time Series')
raw_range<-range(raw)
seasonal_range <- range(decomposed$time.series[, "seasonal"])
cat("Original Time Series Range: ", raw_range[1], " - ", raw_range[2], "\n")
cat("Seasonal Component Range: ", seasonal_range[1], " - ", seasonal_range[2], "\n")
print('The magnitude of the seasonal component is significant')
pacf(raw,main='Raw Data PACF')
print('Seasonality indication in PACF')
#Safe to proceed with seasonal analysis
rm(decomposed,raw_range,seasonal_range)
```
```{r}
#Stationarity Testing
#Augmented Dicky-Fuller
cat("\n","ADF test: p-value =", adf.test(raw)$p.value, "\n")
cat("\n","KPSS test: p-value =", kpss.test(raw)$p.value, "\n")
print('According to the ADF&KPSS test, the data is stationary.')
acf(raw,lag.max=60,main='Raw ACF')
pacf(raw,lag.max=60,main='Raw PACF')
print('According to the ACF, the series is not stationary')
```
```{r}
#Seasonal Differencing
s_diff<-diff(raw,lag=12)
plot(s_diff,main='Seasonal Differencing (12)')
cat("\n","ADF test: p-value =", adf.test(s_diff)$p.value, "\n")
cat("\n","KPSS test: p-value =", kpss.test(s_diff)$p.value, "\n")
print('According to the ADF supports stationarity, but KPSS does not')
acf(s_diff,lag.max=60,main='Seasonal Differenced ACF')
pacf(s_diff,lag.max=60,main='Seasonal Differenced PACF')
print('The ACF does not support stationarity')
eacf(s_diff)
# Stationary
```
```{r}
test_model<-function(data,name){
  layout(matrix(c(1,1,2,3),2,2,byrow=TRUE))
  plot(data$res,main=name)
  acf(data$res,lag.max=60,main='Residuals ACF')
  pacf(data$res,lag.max=60,main='Residuals PACF')
  print(data)
  layout(1)
  tsdiag(data,gof=60)
  hist(window(rstandard(data)),xlab='Standardized Residuals')
  qqnorm(window(residuals(data)))
  qqline(window(residuals(data)))
  shapiro.test(residuals(data))
}
#-------------------------------------------------------------------------------
sarma11s22=Arima(raw,order=c(1,0,1),seasonal=list(order=c(2,1,2),period=12))
test_model(sarma11s22,'SARMA(1,0,1)x(2,1,2)12')
```
```{r}
sarma11s21=Arima(raw,order=c(1,0,1),seasonal=list(order=c(2,1,1),period=12))
test_model(sarma11s21,'SARMA(1,0,1)x(2,1,1)12')
```
```{r}
sarma01s21=Arima(raw,order=c(0,0,1),seasonal=list(order=c(2,1,1),period=12))
test_model(sarma01s21,'SARMA(0,0,1)x(2,1,1)12')
```
```{r}
sarma01s21_forecast<-forecast(sarma01s21, h=24)
plot(sarma01s21_forecast)
```


```{r}
#Additional Differencing
sec_diff<-diff(diff(raw,lag=12))
plot(sec_diff,main='Seasonal Differencing (12)')
cat("\n","ADF test: p-value =", adf.test(sec_diff)$p.value, "\n")
cat("\n","KPSS test: p-value =", kpss.test(sec_diff)$p.value, "\n")
print('According to the ADF supports stationarity, but KPSS does not')
acf(sec_diff,lag.max=60,main='Seasonal Differenced ACF')
pacf(sec_diff,lag.max=60,main='Seasonal Differenced PACF')
print('The ACF does not support stationarity')
eacf(sec_diff)
#OVERDIFFERENCED
```

