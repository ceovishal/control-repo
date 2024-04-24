# This is a description for my plan
plan adhoc::myplan(
  # input parameters go here
  TargetSpec $targets,
) {

  # plan steps go here
  #out::message('Hello, world!')

  # Assign a string to a variable
  $my_string = "Hello, world!"

  out::message({ "key": "value" }.to_json)
  #out::message( $my_string )
  #notice("Your message here")
}
