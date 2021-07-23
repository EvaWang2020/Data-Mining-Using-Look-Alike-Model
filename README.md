This expo explains how to use a look-alike model to find the target audience through similarity scores. A similarity score describes the similarity between an instance and the known good or bad instance. The model itself is a formula and can be repeatedly applied to new datasets. Previous I wrote an [article explaining the whole process](https://evaanalytics.wixsite.com/website/post/target-high-value-audience-using-look-alike-model). In this repo, I will add a choice to use R to find the most correlated variables to postal code average spending using Pearson Correlation Matrix. It is more accurate to use R to find the correlation coefficient.  It is also more flexible, as it allows you to remove, add or change as many variables to test as you can.

**Repo documents**:

Look_Alike_Model.sql
- It is a T-SQL script to find the most profitable postal code, create the model, calculate the distance and find the most similar postal codes

Prepare_dataset_for_pearson_correlation_matrix.sql
- It is a T-SQL script to get the dataset, which is used for the correlation matrix creation. After you save the output into an Excel /CSV file, you need to replace all the “NULL” texts with nothing. 

Pearson_Correlation_Matrix. ipynb
- It is a Jupyter notebook indicating how to use R to create a Pearson Correlation Matrix, which include correlation coefficients between multiple pairs of variables.

TargetAnalysisTable.7z
- It is a zip file that includes the dataset in CSV format. The “Null” texts have been removed.
