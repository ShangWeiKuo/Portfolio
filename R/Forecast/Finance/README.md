# 以時間序列模型預測個人未來的總貸款金額
###### 資料來源: https://www.jcic.org.tw/main_ch/download_page.aspx?uid=213&pid=213 (財團法人金融聯合徵信中心-OpenData專區-企業授信統計資訊: 1-4 個人總貸款狀況統計趨勢資料) 
<br>

## 專題介紹
#### 一、	議題背景
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;個人貸款是銀行不可或缺的收入來源之一，而如何<b>藉由歷史資料客觀地預測未來貸款趨勢</b>乃銀行當前所關注的需求，因此本組將著重於<b>時間序列的建模，以期能觀察並分析產業別的貸款金額走向</b>。

#### 二、	資料欄位與檢視
<p align="center">
  <img src="/R/Forecast/Finance/image/data_summary.png" width="200px">
  <br>
   圖 1		建模用資料集
</p>

## 探索性資料分析
#### 一、	企業產業別貸款總金額變化圖(2012-2021)
引入ggplot2與plotly套件，並將資料集轉為時間序列型態資料，因為時間欄位中含有月份，因此frequency設定為12(週期為12個月)，接著以折線圖方式觀察2012-2021年個人總貸款金額的變化趨勢。從折線圖來看，個人總貸款金額金額呈現正成長的趨勢，因此我們將預測該項目未來的借貸情形是否為穩定正成長。
<p align="center">
  <kbd>
    <img src="/R/Forecast/Finance/image/trend.png" width="800px">
  </kbd>
  <br>
   圖 2		折線圖程式碼
</p>
<br>

#### 二、	分析資料的時間序列是否可建模
利用ACF和PACF圖來了解該資料的時間序列是否具準確性，接著製作ARIMA模型，矯正出最佳的可預測模型。如下圖所示，一般情況與ARIMA模型的ACF、PACF之比較，可以看出右邊的ACF和PACF圖有呈現白噪音的特性，表示該模型是好的。
<br>

|一般情況|ARIMA模型|
|---|---|
|<p align="center"><kbd><img src="/R/Forecast/Finance/image/acf.png" width="400px"></kbd><br>ACF圖</p>|<p align="center"><kbd><img src="/R/Forecast/Finance/image/pacf.png" width="400px"></kbd><br>PACF圖</p>|
|<p align="center"><kbd><img src="/R/Forecast/Finance/image/acf_arima.png" width="400px"></kbd><br>ARIMA模型的ACF圖</p>|<p align="center"><kbd><img src="/R/Forecast/Finance/image/pacf_arima.png" width="400px"></kbd><br>ARIMA模型的PACF圖</p>|
<br>

#### 三、	建立預測模型
1.	利用predict函數預測個人總貸款未來6個月(202102-202107)的可能金額，並利用forecast函數將ARIMA模型結果轉換成圖表。
<p align="center">
  <kbd>
    <img src="/R/Forecast/Finance/image/predict_value.png" width="650px">
  </kbd>
  <br>
   圖 3		predict預測值
</p>
<br>

2. 以mape(平均絕對百分比誤差)和smape(對稱平均絕對百分比誤差)兩種模型評估指標衡量預測結果，其屬於Lewis(1982)所提出的「高精準的預測」等級。
<p align="center">
  <kbd>
    <img src="/R/Forecast/Finance/image/predict_result.png" width="650px">
  </kbd>
  <br>
   圖 4		predict函數之未來未來6個月(202102-202107)的預測值
</p>
<br>
<p align="center">
  <kbd>
    <img src="/R/Forecast/Finance/image/predict_result_plot.png" width="800px">
  </kbd>
  <br>
   圖 5		未來6個月(202102-202107)的時間序列估計圖
</p>
<br>
