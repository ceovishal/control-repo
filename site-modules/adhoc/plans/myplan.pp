# This is a description for my plan
plan adhoc::myplan(
  # input parameters go here
  TargetSpec $targets,
) {

  string_output = "Hello World"
  #print(string_output)
  notice sprintf($string_output)
}
