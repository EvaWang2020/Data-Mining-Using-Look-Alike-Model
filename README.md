This expo provides insights into utilizing a look-alike model to identify target audiences based on similarity scores. A similarity score measures the resemblance between an instance and known good or bad instances. The model, essentially a formula, can be iteratively applied to new datasets. For a detailed walkthrough of the entire process, refer to my previously written article Target High-Value Audience Using Look-Alike Model (https://evaanalytics.wixsite.com/website/post/target-high-value-audience-using-look-alike-model).

In this repository, I introduce an option to leverage R for identifying the most correlated variables to postal code average spending using the Pearson Correlation Matrix. Utilizing R for this task offers enhanced accuracy compared to the manual method used in the article Target High-Value Audience Using Look-Alike Model. Moreover, it provides greater flexibility, allowing for the addition, removal, or modification of variables to test various hypotheses.

**Repo documents**:

- __Look_Alike_Model.sql__: A T-SQL script facilitating the identification of profitable postal codes, model creation, distance calculation, and identification of similar postal codes.

- __Prepare_dataset_for_pearson_correlation_matrix.sql__: A T-SQL script to obtain the dataset required for creating the correlation matrix. After exporting the output to an Excel/CSV file, replace all instances of "NULL" with blank values.

- __Pearson_Correlation_Matrix.ipynb__: A Jupyter notebook demonstrating the use of R to generate a Pearson Correlation Matrix, providing correlation coefficients between multiple pairs of variables.

- __TargetAnalysisTable.7z__: A zip file containing the dataset in CSV format, with "NULL" values removed."

