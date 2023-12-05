"""
@Title: 
@Author(s): Stephen CUI
@LastEditor(s): Stephen CUI
@CreatedTime: 2023-11-19 16:20:37
@Description: 
"""

import numpy as np
from numpy import ndarray


def mape(y_true, y_pred) -> float:
    return 100 * np.mean(np.abs((y_true - y_pred) / y_true))


def simulate_process(is_stationary: bool, n: int = 400) -> ndarray:
    np.random.seed(42)

    process = np.zeros(n)
    if is_stationary:
        alpha = .5
    else:
        alpha = 1
    for i in range(n-1):
        process[i+1] = alpha * process[i] + np.random.standard_normal()

    return process


def mean_over_time(ts: ndarray) -> list:
    return [np.mean(ts[:i]) for i in range(1, len(ts))]


def var_over_time(ts: ndarray) -> list:
    return [np.var(ts[:i]) for i in range(1, len(ts))]


def add_original_feature(df, df_new):
    df_new['open'] = df['Open']
    df_new['open_1'] = df['Open'].shift(1)
    df_new['close_1'] = df['Close'].shift(1)
    df_new['high_1'] = df['High'].shift(1)
    df_new['low_1'] = df['Low'].shift(1)
    df_new['volume_1'] = df['Volume'].shift(1)
