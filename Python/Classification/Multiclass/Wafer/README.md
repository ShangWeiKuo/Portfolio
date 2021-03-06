# 半導體晶圓表面缺陷分類-以輕量級深度神經網路模型為例
<ol>
  <font size=14><b><li>研究議題: 圖像辨識、遷移(轉換)學習</li></b></font>
  <font size=14><b><li>資料名稱來源: <a href="https://www.kaggle.com/qingyi/wm811k-wafer-map">WM-811K wafer map</a> </li></b></font>
  <font size=14><b><li>資料授權種類: CC0: Public Domain</li></b></font>
  <font size=14><b><li>使用語言: Python</li></b></font>
  <font size=14><b><li>運作環境: Colaboratory</li></b></font>
  <font size=14><b><li>框架: Tensorflow(搭配Keras API)</li></b></font>
  <font size=14><b><li>處理器: GPU</li></b></font>
</ol>

## 前言
隨著近年來自動駕駛、物聯網與智慧醫療的興起，為了能滿足即時與快速的需求，終端裝置因此被導入了AI技術，深度神經網路模型便是其中一項例子，而早期的深度神經網路模型雖然在預測或識別準確度上有著亮眼的表現，但是所需要的參數也與之成正比，這意味著模型會面臨記憶體不足的困境，無法應用於內存資源少且計算量不高的終端裝置，因此為了能在少量參數的情況下，讓模型保有足夠的複雜度，從而發展出輕量級網路架構，本專案的研究目的將比較MobileNet-V2、Densenet201、ResNet101、Xception等輕量級深度神經網路模型應用於半導體晶圓表面缺陷分類的表現。
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/cnn_comparison.png", width="700"><br>
  上圖為各個深度神經網路模型的參數與預測準確度，可以看出MobileNet-V2、Densenet201、ResNet101、Inception-v3、Xception在其所屬類型中的預測效果較佳。(註:TOP-1 Accuracy是指一張照片第1次辨識，正確分類的準確率。)<br>
  圖片來源:  &#91;<a href="https://arxiv.org/abs/1605.07678">paper</a>&#93; &#91;<a href="https://towardsdatascience.com/neural-network-architectures-156e5bad51ba">blog</a>&#93;
</p>

## 分析流程
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/schedule.png", width="400">
</p>
<ol>
  <li><a href="#preprocess"> 資料前置處理 </a></li>
  <li><a href="#model"> 模型建置 </a></li>
  <li><a href="#evaluation"> 模型評估 </a></li>
</ol>

## 1. 資料前置處理
### 1-1 Median Filter
根據國立清華大學博士生所著論文**視覺特徵用於大規模學習: 以晶圓圖與音樂曲風分類為例**，針對晶圓圖案上出現的雜訊，可以藉由median filter方法去除之，且相較於沒有去除雜訊的圖片，前者在分類預測上的效果優於後者，因此本研究將以median filter去除晶圓圖片上的雜訊。<br>
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/filter.png", width="500">
</p>
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/filter_resize.png", width="700">
</p>

## 2. 模型建置
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/model.png", width="500">
</p>

## 3. 模型評估
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/evaluation-accuracy.png", width="600">
</p>
<p align="center">
  <img src="/Python/Classification/Multiclass/Wafer/image/dense_roc.png", width="700">
</p>
