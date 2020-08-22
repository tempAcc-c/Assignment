x<- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject  <- rbind(subject_train, subject_test)
merged_data <- rbind(subject,y,x)

tidy_data <- merged_data%>% select(subject,code,contains("mean"), contains("std"))
tidy_data$code <- activities[tidy_data$code,2]
names(tidy_data)[2]= "activity"
names(tidy_data)<- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<- gsub("^t", "Time", names(tidy_data))
names(tidy_data)<- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<- gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<- gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<- gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<- gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<- gsub("gravity", "Gravity", names(tidy_data))

final_data <- tidy_data%>%
  group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(final_data,"final_data.txt", row.name = FALSE)