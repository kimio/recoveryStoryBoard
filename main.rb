require_relative 'project'

puts "\n
Welcome :) lets recovery your Xcode 8 storyboard to Xcode 7 storyboard \\\o/
Where is the folder project?"

project = Project.new()
project.folder_project = gets.strip
project.replace_storyboard(update_storyboard:true,override_files:true)
