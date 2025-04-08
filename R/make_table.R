# @author Nolan Vibhakar
# creates a table using the given data columns, then writes it to the given
# folder as a csv file with the given name.
#
# @param data_cols -dataframe or individual column or columns of a dataframe
# @param folder -the folder and path to write the file to
# @param name -the name of the file to be written
#
# @return writes a new file
#
# @examples
# make_table(data_cols, folder, name)

library(readr)

make_table <- function(data_cols, folder, name) {
  table <- table(data_cols)
  write_csv(as.data.frame(table), file = paste(folder, "/", name, sep = ""))
}