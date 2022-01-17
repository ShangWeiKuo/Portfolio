# 半導體晶圓表面缺陷分類-以輕量級卷基神經網路為例
<ol>
  <font size=14><b><li>研究議題: 圖像辨識、遷移(轉換)學習</li></b></font>
  <font size=14><b><li>資料名稱來源: WM-811K wafer map(https://www.kaggle.com/qingyi/wm811k-wafer-map) </li></b></font>
  <font size=14><b><li>資料授權種類: CC0: Public Domain</li></b></font>
  <font size=14><b><li>使用語言: Python</li></b></font>
  <font size=14><b><li>運作環境: Colaboratory</li></b></font>
  <font size=14><b><li>框架: Tensorflow(搭配Keras API)</li></b></font>
  <font size=14><b><li>處理器: GPU</li></b></font>
</ol>

## 前言

<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/cnn_comparison.png", width="700"><br>
  圖片來源:  &#91;<a href="https://arxiv.org/abs/1605.07678">paper</a>&#93; &#91;<a href="https://towardsdatascience.com/neural-network-architectures-156e5bad51ba">blog</a>&#93;
</p>

## 分析流程
[1. 資料前置處理](#1. 資料前置處理)

## 1. 資料前置處理
根據國立清華大學博士生所著論文**視覺特徵用於大規模學習: 以晶圓圖與音樂曲風分類為例**，
