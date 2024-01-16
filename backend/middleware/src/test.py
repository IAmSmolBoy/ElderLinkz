import os
import joblib
import pandas as pd


status: int = joblib.load(os.path.abspath('middleware/src/models/sickness_MLPC_GS.pkl')).predict(
    pd.DataFrame({
        'body temperature': [36],
        'SpO2': [95]
    })
)[0]

print(status)