#check if there is any null
#
#@param x
#
#@return int

check_null <- function(x) {
  sum(is.null(x))
}
