# Credit_card_fraud_detection


# Dataset:
Context
Limited credit card transaction data is available for training fraud detection models and other uses, such as analyzing similar purchase patterns. Credit card data that is available often has significant obfuscation, relatively few transactions, and short time duration. For example, this Kaggle dataset has 284,000 transactions over two days, of which less than 500 are fraudulent. In addition, all but two columns have had a principal components transformation, which obfuscates true values and makes the column values uncorrelated.

Content
The data here has almost no obfuscation and is provided in a CSV file whose schema is described in the first row. This data has more than 20 million transactions generated from a multi-agent virtual world simulation performed by IBM. The data covers 2000 (synthetic) consumers resident in the United States, but who travel the world. The data also covers decades of purchases, and includes multiple cards from many of the consumers.

Further details about the generation are here. Analyses of the data suggest that it is a reasonable match for real data in many dimensions, e.g. fraud rates, purchase amounts, Merchant Category Codes (MCCs), and other metrics. In addition, all columns except merchant name have their "natural" value. Such natural values can be helpful in feature engineering of models.

F1 provides a useful score for models predicting whether a particular transaction is fraudulent. In addition, comparison can be made to the results other fraud detection models, e.g.

TabFormer (BERT-based Model)
LSTM and GRU Models for AI on IBM Z Mainframe
A broader set of synthetic financial transactions labeled for money laundering is also available on Kaggle:

AML: Anti Money Laundering Data
