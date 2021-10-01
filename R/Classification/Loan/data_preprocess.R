rm(list = ls(all = T)); gc()
pacman::p_load(dplyr, stringr)


## 讀取資料
# Loading LoanStats3a.csv and importing it into variable named "loan".
loan <- data.table::fread("LoanStats3a.csv")


## 資料前置處理
# Keeping those records with "loan_status" in ("Charged Off", "Fully Paid")
loan <- loan[loan$loan_status %in% c("Charged Off", "Fully Paid"),]
# 計算每一個欄位內容是否只有一種值(ex: 全是空格、全是NA值、只有一種值)
level_length <- sapply(colnames(loan), function(x) eval(parse(text = paste("length(levels(as.factor(loan", "$", x, ")))", sep = ""))))
# 找尋值多於一種的欄位
col_level_length <- which(level_length > 1)
# 將選取欄位帶入loan中，使得loan的欄位被更改為上一行所擁有的欄位
loan <- loan %>%
          dplyr::select(col_level_length)
# Searching the columns cotaining "some" white spaces, 
# and changing them from "" to NA.
loan <- loan %>% 
          mutate_all(~replace(., .=="", NA)) %>%
            as.data.frame()
# Delete the columns whose containing number of NA values is more than than number of half of total rows
NA_number <- sapply(1:ncol(loan), function(x) ifelse(sum(is.na(loan[[x]])) < nrow(loan) * 0.5, x, NA))
col_No_NA <- which(!is.na(NA_number))
loan <- loan %>%
          dplyr::select(col_No_NA)
# 將剩下沒有被刪除的NA值以-1填值
loan <- loan %>% 
          mutate_all(~replace(., is.na(.), -1)) %>%
            as.data.frame()
# 將 int_rate、revol_util、term 等欄位的文字部分去除，並轉換為數值型態
loan$int_rate <- str_replace_all(string = loan$int_rate, pattern = "%", replacement = "")
loan$int_rate <- as.numeric(loan$int_rate) * (0.01)
loan$revol_util <- str_replace_all(string = loan$revol_util, pattern = "%", replacement = "")
loan$revol_util <- as.numeric(loan$revol_util) * (0.01)
loan$term <- str_replace_all(string = loan$term, pattern = "months", replacement = "")
loan$term <- as.numeric(loan$term)
# 將欄位內容的 character 型態轉換為 factor 型態
# 執行完這步驟便可確定 loan 資料集只有存在 numeric 和 factor 型態的資料
loan <- loan %>% 
  mutate_if(~is.character(.), as.factor) %>%
  as.data.frame()
# 抽取 factor 型態的資料並命名為 loan_factor
loan_factor <- select_if(loan, is.factor)
# 找尋 loan_factor 中，內容的分級數目少於52的欄位，並轉變為 loan_factor 的新欄位
level_factor_length <- sapply(colnames(loan_factor), function(x) eval(parse(text = paste("length(levels(loan_factor", "$", x, "))", sep = ""))))
col_level_factor_length <- which(level_factor_length < 52)
loan_factor <- loan_factor %>%
                  dplyr::select(col_level_factor_length)
# 調整"Fully Paid"和"Charged Off"的等級次序
loan_factor$loan_status <- factor(loan_factor$loan_status, levels = c("Fully Paid", "Charged Off"))
# 將 loan_factor 的資料轉換為 numeric 型態
loan_factor <- loan_factor %>%
  mutate_if(~is.factor(.), as.numeric) %>%
  as.data.frame() - 1
# 選取 loan 中 numeric 型態的資料
loan <- select_if(loan, is.numeric)
# 將只有 numeric 型態的 loan 與 loan_factor 資料合併為新的 loan 資料集
loan <- cbind(loan, loan_factor)
# Split the dataset into training (70%) and testing sets (30%) 
# with random seed set.seed(1).
set.seed(1)
train_loan_idx <- sample(1:nrow(loan), size = nrow(loan) * 0.7)
test_loan_idx <- setdiff(1:nrow(loan), train_loan_idx)
train_loan <- loan[train_loan_idx, ] # training sets
test_loan <- loan[test_loan_idx, ] # testing sets


## 儲存Rdata檔
save.image(file = "data_preprocess.rdata")