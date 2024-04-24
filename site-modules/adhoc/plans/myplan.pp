# This is a description for my plan
plan adhoc::myplan(
  # input parameters go here
  TargetSpec $targets,
) {

  # plan steps go here
  #out::message('Hello, world!')

  # Assign a string to a variable
  $my_string = "Hello, world!"
  notice($my_string)
  #notify { $my_string: }
}
