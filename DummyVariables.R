
require(readxl)
require(dplyr)


data = read_excel("Dummy1.xlsx")
data_final = data

# for (i in 8:22){
#   
#   data_final[, i] = as.numeric( as.character(data_final[,i] ))
#   
# }

cols <- sapply(data, is.logical)
data_final[,cols] <- lapply(data[,cols], as.numeric)


str(data)
str(data_final)


for ( i in unique(data$ID)){
  #i = 1
  
  data_1 = subset(data, process_end != "END")
  
  data_id = filter(data_1, ID == i)
  
  sum_data_id = as.numeric(colSums( data_id[, 8:22], na.rm = T ))
  
  names_data = names(data_id[, 8:22])
  
  
  #str(sum_data_id)
  sum_data_id_2 = matrix(sum_data_id, nrow = 1, ncol = 15)
  
  colnames(sum_data_id_2) = names_data
  
  #str(sum_data_id_2)
  
  sum_data_id_3 = as.data.frame(sum_data_id_2)
  #str(sum_data_id_3)
  data_final[data$ID == i & data$process_end == "END", 8:22 ] = sum_data_id_3
  
  
  #final = data[data$ID == i & data$process_end == "END", 8:22 ] 
}


#data_final[which(data_final == "FALSE", arr.ind = T)] = 0
#data_final[which(data_final == FALSE, arr.ind = T)] = 0

write.csv(data_final, "data_final.csv", row.names = F)


#Method 2
# final = data %>% group_by(ID, Historical_Step_Name) %>% summarise(total_process_time = sum(Historical_Step_Status.Duration)) 
# final = final[order(final$ID, final$Historical_Step_Name), ]