rm(list = ls(all=T)); gc()
pacman::p_load(dplyr, caret)

filepath = paste0(getwd(), "/")
load("data_preprocess.rdata")

# Feature Selection
# 將從 colnames(train_loan)[-FC] 得到的預測變數帶入 glm 中，得出新模型 new_loan_glm
new_loan_glm <- glm(loan_status ~ ., data = train_loan, family = "binomial")

# 利用 summary() 了解各預 new_loan_glm 中測變數的顯著度
summary(new_loan_glm)

# 第一次逐步迴歸
step_1 <- step(new_loan_glm)
FS_1 <- names(step_1$coefficients)[-1]

# feature <- function(x){
#   for(i in 1:length(x)){
#     if(i == 1){
#       text <- paste(x[i], sep = "+")
#     } else{
#       text <- paste(text, x[i], sep = "+")
#     }
#   } 
#   return(text)
# }

# 將第一次逐步迴歸所得到的最佳 formula 帶入 glm 中，得到新模型new_loan_glm_step1
# new_loan_glm_step1 <- glm(as.formula(paste0("loan_status ~ ", feature(FS_1))),
#                           family = "binomial", data = train_loan)

new_loan_glm_step1 <- glm(loan_status ~ ., 
                          family = "binomial", data = train_loan[, c("loan_status", FS_1)])

# 利用 summary() 了解 new_loan_glm_step1 中各預測變數的顯著度，其中 
# pub_rec、total_rec_int 呈現不顯著狀態
summary(new_loan_glm_step1)

# 第二次逐步迴歸
step_2 <- step(new_loan_glm_step1)
FS_2 <- names(step_2$coefficients)[-1]
FS_2 <- FS_2[-c(5, 9)]

# 第一次和第二次逐步迴歸的結果皆相同，因此這邊我去除 summary() 中不顯著的預測變數
# ，並再次執行 glm 迴歸模型，得出新模型 new_loan_glm_step2
new_loan_glm_step2 <- glm(loan_status ~ ., 
                          family = "binomial", data = train_loan[, c("loan_status", FS_2)])

# 利用 summary() 了解 new_loan_glm_step2 中各預測變數的顯著度
summary(new_loan_glm_step2)

save(train_loan, test_loan, new_loan_glm_step2, file = paste0(filepath, "feature_selection_stepwise.rdata"))