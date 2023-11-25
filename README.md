# ML_Portfolio
Hello! I'm David Laziuk, a recent Machine Learning graduate from Stevens Institute of Technology. Welcome to my project portfolio, where I've compiled a range of initiatives showcasing my expertise in AI, data mining, and natural language processing. Each project here represents a blend of innovative machine learning techniques, from end-to-end system development to advanced work with synthetic data.

<!--
## Live Website

A live version of this website can be found [here](https://example.com/).

## Technologies Used

-->

# Projects

## [Transformers in Financial NLP: Market Movements from 8-K reports](https://github.com/dlaziuk/ML_Portfolio/blob/main/Transformers%20in%20Financial%20NLP/Financial%20NLP.ipynb)
This project was designed to harness the power of Natural Language Processing (NLP) for analyzing financial documents, specifically the 8-K reports of S&P 500 companies. The primary goal was to utilize Transformer models and advanced data processing techniques to predict market movements, offering a novel financial indicator.

Key Achievements:
1. Advanced Data Preprocessing:
 - Employed sophisticated text preprocessing strategies to handle massive datasets of 8-K reports, ensuring the retention of crucial financial information.
 - Pioneered the use of tailored feature engineering methods to extract and emphasize the most relevant textual elements, significantly enhancing the model's accuracy and predictive relevance.
2. Innovative Use of Transformer Models:
 - Successfully adapted and fine-tuned the BERT (Bidirectional Encoder Representations from Transformers) model, tailoring it specifically for regression with financial text analysis.
 - Developed a method to adapt this advanced language model to the domain of finance, focusing on extracting pivotal insights from complex financial documents.
 - Currently engaged in ongoing experimentation with other Transformer models like FinBERT, XLNet, and GPT variants, aiming to broaden the scope and enhance the accuracy of financial text analysis.
3. Novel Market Sentiment Indicator:
 - Created a unique market sentiment indicator through meticulous model training, ensuring that it captures subtle nuances in the financial reports.
 - Demonstrated exceptional skill in model optimization, leveraging dropout techniques and linear regression layers for improved efficiency and performance.
4. Data Analysis and Visualization:
 - Conducted a thorough statistical analysis of the financial data, employing histograms, line plots, and correlation matrices to uncover deeper insights.
5. Benchmarking and Performance Evaluation:
 - Established baseline performances with traditional machine learning models, such as Naive Predictions, Linear Regression, and SVMs.
 - Rigorously evaluated the Transformer models against these baselines, using metrics like MAE, MSE, RMSE, and Directional Accuracy, where the Transformer models consistently outperformed the baselines.

## [Synthetic Image Generation](https://github.com/dlaziuk/ML_Portfolio/blob/main/Synthetic%20Image%20Generation/Plate%20Generator.ipynb)
In this project, I developed a tool to create an unlimited supply of fully-labeled, realistic license plate images. This synthetic dataset significantly boosted the performance of computer vision models in reading license plates, surpassing the limitations of available real-world data.

Key Achievements:
1. Data Collection and Configuration:
 - Meticulously gathered blank templates for all 50 U.S. states, including major variants such as recent standards and common vanity plates.
 - Configured a system to accurately reflect text color, font, spacing, and layout specific to each plate, enabling the generation of any realistic U.S. license plate.
2. Realistic Data Augmentation:
 - Implemented a range of augmentations, including Cutout, Occlusion, Cropping, Hue, Saturation, Exposure, Blur, Noise, Perspective Warp, and Background. These were applied randomly, following a normal distribution, with adjustable parameters to mimic real-world scenarios.
3. Custom Perspective Warp Challenge:
 - Addressed a major hurdle in achieving realistic perspective warp. I developed a custom solution using linear algebra to dissect the homography into individual components, allowing for accurate scaling of character bounding boxes in line with image warp.
4. Adherence to PyTorch YOLOv5 Standards:
 - Ensured that the generated data conformed to the requirements of PyTorch's YOLOv5, setting it as the baseline for data aggregation. However, the system is flexible and can be adapted to other standards.
5. Recommendations and Future Enhancements:
 - Suggested the use of Vision Transformers (ViTs) for potential users of the dataset, considering their advanced capabilities in computer vision tasks.
Proposed further improvements, such as applying data augmentations on a random gradient across the image, to enhance the dataset's realism and utility.

## [Time Series Analysis: Analyzing Daily SPY ETF Data and Monthly Solar Production](https://github.com/dlaziuk/ML_Portfolio/blob/main/GARCH%2C%20ARMA%2C%20SARMA/TSAPaper.pdf)
Conducted a comprehensive time series analysis on two distinct datasets: the daily adjusted close prices of the SPY ETF (non-seasonal) and the monthly solar production at the Southland Leisure Centre in Canada (seasonal).  
Preprocessed data using Python and performed the analysis with the R programming language. Verified non-seasonality and tested stationarity in the financial data. Applied different transformations, ARIMA, and GARCH models in the attempt to create accurate forecasts.  
Although GARCH models failed to provide satisfactory forecasts, a rolling mean detrending technique followed by the application of an ARMA(2,1) model led to successful forecasting of the SPY ETF prices. This demonstrated adaptability in employing different techniques to overcome analytical challenges.  
For the seasonal dataset, confirmed the presence of seasonality, performed seasonal differencing, and tested various SARIMA models. The best fitting SARIMA model provided accurate forecasts of the solar production data.  
Demonstrated advanced statistical forecasting techniques' effectiveness in addressing unique challenges posed by each dataset. The ability to accurately forecast both SPY ETF prices and solar production volumes can provide valuable insights for investment strategies, risk management, and renewable energy sector management, offering significant value to businesses in these areas.  

## [Adaptable CNN](https://github.com/dlaziuk/ML_Portfolio/blob/main/Adaptable%20CNN/CNN.ipynb)
I wanted to find a good CNN structure for [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html) image data, instead of constraining myself to redefining the model for all architecures,  
I developed a function that accepts a list of configurations, and automatically builds tests performance.  
Configurable paramaters include: Optimizer, Learning Rate, Batch Size, Padding, layer count, and data augmentation rules.
Per-Layer paramaters: (conv/dense), filter size, filter count, batchnorm, activation, dropout, and maxpool.

## [Hospital Readmission](https://github.com/dlaziuk/ML_Portfolio/tree/main/Hospital%20Readmission)
Predicting if a diabetes patient will be readmitted to the hospital.  

## [Parts of Speech Recognition](https://github.com/dlaziuk/ML_Portfolio/blob/main/Parts%20Of%20Speech/PartsOfSpeech.ipynb)
Here, features for classifing parts of speech were generated.  
OpenAI's text-davinci API was used to generate more abstract features.  

## [3D Reconstruction from Images](https://github.com/dlaziuk/ML_Portfolio/blob/main/VoxelGrid/VoxelGrid.ipynb)
This is a Voxel-Based Reconstruction of a dancer from 8 images taken in the same moment.  
A blank grid was populated from the images, where texture was later applied.

## [Panorama Stitching](https://github.com/dlaziuk/ML_Portfolio/blob/main/Panorama%20Stitching/Panorama%20Stiching.ipynb)
Developed a computer vision project to stitch two photos without using advanced external libraries.  

## [Algorithms from scratch](https://github.com/dlaziuk/ML_Portfolio/tree/main/Algorithms%20From%20Scratch)
- Feed-Forward Neural Network 
- Random Forest
- Cart Decision Tree
- Logistic Regression (SGD/Pseudo-inverse)
- Naïve Bayes
- k-NN

## Skills
- Data Preprocessing
- Feature Engineering
- Synthetic Data Generation
- Model Selection
- Model Evaluation and Validation
- Hyperparameter Tuning
- Deep Learning
- Computer Vision
- Time Series Analysis
- Data Visualization

## Contact
- Email: [davidlaziuk@gmail.com](mailto:davidlaziuk@gmail.com)
- LinkedIn: [linkedin.com/in/davidlaziuk](https://www.linkedin.com/in/davidlaziuk/)
