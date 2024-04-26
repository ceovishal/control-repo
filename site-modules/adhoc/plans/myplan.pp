# This is a description for my plan
plan adhoc::myplan(
  # input parameters go here
  TargetSpec $targets,
) {

  #string_output = "Hello World"
  #print(string_output)
  #puts('Hello')
  
  ##notify { 'Hello World': }

  # Define variables
$var1 = 'Hello'
$var2 = 'world'

# Format the string using format()
$formatted_string = format(' %s %s', $var1, $var2)

# Print the formatted string using notice
notice($formatted_string)

}
