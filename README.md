ML1-HSLU
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This repository contains the analysis conducted for the ML1 course at HSLU. The project explores the relationships between economic indicators, urbanization, military expenditure, and political factors using a range of statistical and machine learning models.

 Methods Applied:
- Generalized Linear Models (GLMs): Multinomial Logistic Regression, Multiple Linear Regression, Binomial GLM, Quasi-Poisson and Negative Binomial Models

- Generalized Additive Models (GAMs)

- Neural Networks

- Support Vector Machines (SVMs)

The goal of the analysis is to uncover interpretable patterns and predictive insights connecting economic and ideological factors.
-----------------------------------------------------------------------------------------------------------------------------------------------
*The folder structure is the following:*

**/ML1_report
	/preprocessing_scripts
	/processed_data
	/raw_data
	/gam_R
	/template**


-The file ML1_Project.html is the main report file.

-The file ML1_Report.ipnyb is the markdown file used to generate the HTML output.

-Preprocessing scripts folder contains 2 files, dataset_processing.R cleans and merges 3 datasets in one and new_data_merge merges the last dataset with others.

-Processed data folder contains the processed data file (new_data_with_count.csv) that we used in our analysis.

-Raw data contains 4 datasets (global_economy_indicators, global_leader_ideologies,military_spending_dataset,World POpulation and Unemployment Dataset) before preprocessing and the metadata file for global economic indicators dataset.

-gam_R folder contains, train-test data split from python (X_enc.csv,x_test_enc.csv,y_train_enc.csv,y_test_enc.csv) for loading in R, R script for GAM analysis (gam_r.R) and related plots and summary tables to load in jupyter notebook.

-Template folder contains hide_code utility for jupyter notebook output and convert_html.txt which includes the code to convert the jupyter notebook to html.

---------------------------------------------------------------------------
**Team Contibutions:**
This project was a collaborative effort where each member contributed their expertise to different stages of the workflow:

- **Data Selection & Cleaning:**  
  Özarslan Irmak was responsible for selecting the macroeconomic and political datasets and performed comprehensive data cleaning to ensure the dataset was reliable for analysis.

- **Exploratory Data Analysis (EDA):** 
  Batschelet Jimena conducted the exploratory data analysis, uncovering important trends, distributions, and relationships that informed subsequent modeling decisions.

- **Modeling:**  
    - Generalized Additive Model (GAM) and Poisson Model: Özarslan Irmak implemented and tuned the GAM and Poisson models.
    - Neural Networks & Binomial Model: Chichko Kostiantyn developed the neural network models and performed the Binomial model analysis.
    - Linear Regression & SVM: Batschelet Jimena was responsible for implementing the linear regression and support vector machine models.

- **Shared Responsibilities:**  
  All team members collaborated on project planning, coordination, result interpretation, report writing, and presentation preparation. Peer review and feedback were integral at every stage, ensuring high-quality and reproducible results.

**Team Members:**  
- Batschelet Jimena W.MSCIDS.2201 (<jimena.batschelet@stud.hslu.ch>)  
- Özarslan Irmak W.MSCIDS.2401 (<irmak.oezarslan@stud.hslu.ch>)  
- Chichko Kostiantyn W.MSCIDS.2401 (<kostiantyn.chichko@stud.hslu.ch>)


