# ML1 Project: Evaluation Criteria & Instructions (Summary)

**Share this summary with your team to ensure your project meets all course requirements.**

---

## 1. Dataset Requirements

- **Size:** 1,000–100,000 observations.
- **Predictors:** 10–20 variables across types:
  - Continuous (e.g., GDP, GNI, population, military spending) ✅
  - Categorical (e.g., leader ideology – left/center/right, democracy) ✅
  - Count (e.g., urban/rural population counts) ✅
  - Binary (e.g., democracy yes/no) ✅
  - At least one categorical variable with >2 levels (e.g., leader ideology) ✅
- **Originality:** Avoid overused datasets (e.g., Kaggle defaults). Justify any data modifications (log-transforms, scaling).

## 2. Model Implementation

- **Required Models:**
  - Linear Model (LM): Multiple predictors, not just one.
  - GLM Poisson/Binomial: For count/binary outcomes (e.g., urban pop, democracy).
  - GAM: Use for non-linear relationships.
  - Neural Network (NN): Specify layers, activations, tuning.
  - SVM: Tune kernel (RBF/linear), regularization (C).
- **Log-Transform:** Apply log(1 + x) to all "amount" variables (e.g., GDP, GNI).
- **Model Comparison:** Compare complex models (NN/SVM) against non-linear LM/GAM. Use polynomial/spline terms for fairness.
- **Residual Analysis:** Required for all models (Q-Q plots, residuals vs. fitted).

## 3. Report Structure & Content

- **Core Sections:** EDA, Modeling (all 6 methods, interpret coefficients), Conclusions (client-facing, link to hypotheses).
- **Length:** Max 30 pages (PDF/HTML). Remove redundant code/output.
- **Creativity:** Tell a story with findings. Use visualizations (boxplots, trends) to highlight key insights.

## 4. Deliverables

- **Files:** Raw data, PDF/HTML report, code scripts (.R/.py), README (describe all files and team roles).
- **Naming:** Zip as FamilyName1_FamilyName2_MatricNo.zip (e.g., Barbanti_Meister_010923.zip).
- **Submission:** Upload final version to ILIAS by deadline.

## 5. Personal Contribution

- **Team Roles:** Each member leads one model (e.g., "Student A led GAM analysis"). Make individual roles explicit.
- **Agreement:** Submit signed "team agreement" on ILIAS.

## 6. AI Usage Reflection

- **Required:** Explicitly describe how AI was used (e.g., for code generation, method clarification).
- **Critical Reflection:** Discuss limitations (e.g., "ChatGPT gave wrong SVM hyperparameters; fixed manually").

## 7. Grading Focus

- **Client-Ready Report:** Frame as actionable insights for stakeholders.
- **Creativity:** Highlight unique strengths (parameter interpretation, advanced SVM tuning, HTML formatting).
- **Proper Model Use:** Use multiple predictors, log-transform amounts, fair model comparisons.

## 8. Key Hints

- **Compile Often:** Use caching or save fitted models to avoid reruns.
- **Log-Transform Amounts:** Always log-transform cost/income variables before modeling.
- **Fair Comparisons:** Use cross-validation (e.g., RMSE/AUC for comparison).
- **Clarity:** Prefer simple explanations over jargon for client readability.

## 9. Common Pitfalls

- Avoid Kaggle datasets.
- Only drop missing data with justification.
- Never fit models with a single predictor.
- Always link findings to hypotheses.
- Ensure all methods have residual analysis.

## 10. Final Notes

- **No Partial Submissions:** Only the last uploaded version is graded.
- **Test Early:** Ensure your report compiles before the deadline.
- **Client Storytelling:** Frame results as practical recommendations (e.g., "Invest in infrastructure to address rural voting patterns").

---