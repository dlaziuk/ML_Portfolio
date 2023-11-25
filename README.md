# ML_Portfolio
Hello! I'm David Laziuk, a recent Machine Learning graduate from Stevens Institute of Technology. Welcome to my project portfolio, where I've compiled a range of initiatives showcasing my expertise in AI, data mining, and natural language processing. Each project here represents a blend of innovative machine learning techniques, from end-to-end system development to advanced work with synthetic data.

<!--
## Live Website

A live version of this website can be found [here](https://example.com/).

## Technologies Used

-->

## Projects

### Project 1: Time Series Analysis: Analyzing Daily SPY ETF Data and Monthly Solar Production  [link](https://github.com/dlaziuk/ML_Portfolio/blob/main/GARCH%2C%20ARMA%2C%20SARMA/TSAPaper.pdf)
Conducted a comprehensive time series analysis on two distinct datasets: the daily adjusted close prices of the SPY ETF (non-seasonal) and the monthly solar production at the Southland Leisure Centre in Canada (seasonal).  
Preprocessed data using Python and performed the analysis with the R programming language. Verified non-seasonality and tested stationarity in the financial data. Applied different transformations, ARIMA, and GARCH models in the attempt to create accurate forecasts.  
Although GARCH models failed to provide satisfactory forecasts, a rolling mean detrending technique followed by the application of an ARMA(2,1) model led to successful forecasting of the SPY ETF prices. This demonstrated adaptability in employing different techniques to overcome analytical challenges.  
For the seasonal dataset, confirmed the presence of seasonality, performed seasonal differencing, and tested various SARIMA models. The best fitting SARIMA model provided accurate forecasts of the solar production data.  
Demonstrated advanced statistical forecasting techniques' effectiveness in addressing unique challenges posed by each dataset. The ability to accurately forecast both SPY ETF prices and solar production volumes can provide valuable insights for investment strategies, risk management, and renewable energy sector management, offering significant value to businesses in these areas.  

### Project 2: Hospital Readmission [link](https://github.com/dlaziuk/ML_Portfolio/tree/main/Hospital%20Readmission)
Predicting if a diabetes patient will be readmitted to the hospital.  

### Project 3: Adaptable CNN [link](https://github.com/dlaziuk/ML_Portfolio/blob/main/Adaptable%20CNN/CNN.ipynb)
I wanted to find a good CNN structure for [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html) image data, instead of constraining myself to redefining the model for all architecures,  
I developed a function that accepts a list of configurations, and automatically builds tests performance.  
Configurable paramaters include: Optimizer, Learning Rate, Batch Size, Padding, layer count, and data augmentation rules.
Per-Layer paramaters: (conv/dense), filter size, filter count, batchnorm, activation, dropout, and maxpool.

### Project 4: Parts of Speech Recognition [link](https://github.com/dlaziuk/ML_Portfolio/blob/main/Parts%20Of%20Speech/PartsOfSpeech.ipynb)
Here, features for classifing parts of speech were generated.  
OpenAI's text-davinci API was used to generate more abstract features.  

### Project 5: 3D Reconstruction from Images [link](https://github.com/dlaziuk/ML_Portfolio/blob/main/VoxelGrid/VoxelGrid.ipynb)
This is a Voxel-Based Reconstruction of a dancer from 8 images taken in the same moment.  
A blank grid was populated from the images, where texture was later applied.

### Project 6: Panorama Stitching [link](https://github.com/dlaziuk/ML_Portfolio/blob/main/Panorama%20Stitching/Panorama%20Stiching.ipynb)
Developed a computer vision project to stitch two photos without using external functions.  

## Algorithms from scratch
- Feed-Forward Neural Network 
- Random Forest
- Cart Decision Tree
- Logistic Regression (SGD/Pseudo-inverse)
- Naïve Bayes
- k-NN

## Skills
- Data preprocessing
- Feature engineering
- Model Selection
- Model evaluation and validation
- Hyperparameter tuning
- Deep Learning
- Computer vision
- Time Series Analysis
- Data visualization

## Contact
- Email: [davidlaziuk@gmail.com](mailto:davidlaziuk@gmail.com)
- LinkedIn: [linkedin.com/in/davidlaziuk](https://www.linkedin.com/in/davidlaziuk/)
