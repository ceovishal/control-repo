# This is a description for my plan
plan adhoc::myplan(
  # input parameters go here
  TargetSpec $targets,
) {

  # plan steps go here
  #out::message('Hello, world!')
  #notice("Hello world!")

  # Assign a string to a variable
  $my_string = "Hello, world!"

  # Print the value of the variable using the notice function
  puts($my_string)


}
