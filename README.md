ML1-HSLU
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This repository contains the analysis conducted for the ML1 course at HSLU. The project explores the relationships between economic indicators, urbanization, military expenditure, and political factors using a range of statistical and machine learning models.

 Methods Applied:
- Generalized Linear Models (GLMs): Multinomial Logistic Regression, Multiple Linear Regression, Binomial GLM, Quasi-Poisson and Negative Binomial Models

- Generalized Additive Models (GAMs)

- Neural Networks

- Support Vector Machines (SVMs)

**The goal of the analysis is to uncover interpretable patterns and predictive insights connecting economic and ideological factors.**

-----------------------------------------------------------------------------------------------------------------------------------------------

**The folder structure:**


<pre> 📦ML1_report    
 ┣ 📂gam_R             # train-test data split from python (X_enc.csv,x_test_enc.csv,y_train_enc.csv,y_test_enc.csv), R script for GAM analysis and plots and summary tables to load in jupyter notebook
 ┃ ┣ 📜gam_check_output.txt
 ┃ ┣ 📜gam_model_summary.txt
 ┃ ┣ 📜gam_r.R         #  R script for GAM analysis
 ┃ ┣ 📜grid_plot.png
 ┃ ┣ 📜RESIDUAL_DIAG.png
 ┃ ┣ 📜X_enc.csv
 ┃ ┣ 📜x_test_enc.csv
 ┃ ┣ 📜YEOJOHNSONTRANSFORMED.png
 ┃ ┣ 📜YEOJOHNSON_check_output.txt
 ┃ ┣ 📜yeojohnson_histogram.png
 ┃ ┣ 📜YEOJOHNSON_model_summary.txt
 ┃ ┣ 📜yeojohnson_qqplot.png
 ┃ ┣ 📜y_test_enc.csv
 ┃ ┗ 📜y_train_enc.csv
 ┣ 📂processing_script
 ┃ ┗ 📜new_data_merge.R      # Merges all 4 datasets and renames and cleans them.
 ┣ 📂processed_data
 ┃ ┗ 📜new_data_with_count.csv   #The processed data file that we used in our analysis.
 ┣ 📂raw_data                     # Raw data for 4 datasets and metadata for GEM
 ┃ ┣ 📜GEM_Metadatadescriptions.xlsx
 ┃ ┣ 📜global_economy_indicators.csv
 ┃ ┣ 📜global_leader_ideologies.csv
 ┃ ┣ 📜military_spending_dataset.csv
 ┃ ┗ 📜World Population and Unemployment Dataset (1960-2023).csv
 ┣ 📂template
 ┃ ┣ 📜convert_html.txt             # HTML conversion command for .ipynb file
 ┃ ┗ 📜hide_code.tpl                #hide code utility for jupyter notebook
 ┣ 📜ML1_Project.html               # Main report file
 ┣ 📜ML1_Report.ipynb               # The markdown file used to generate the HTML output
 ┗ 📜README.md </pre>


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

-  **github:** https://github.com/irmakoz1/ML1-HSLU

**Team Members:**
- Batschelet Jimena W.MSCIDS.2201 (<jimena.batschelet@stud.hslu.ch>)
- Özarslan Irmak W.MSCIDS.2401 (<irmak.oezarslan@stud.hslu.ch>)
- Chichko Kostiantyn W.MSCIDS.2401 (<kostiantyn.chichko@stud.hslu.ch>)


