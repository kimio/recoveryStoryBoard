#find storyboard
#copy when found xcode 8 version
#make new file with xml
require 'find'

class Project
  attr_accessor :folder_project
  def initialize()
  end

  def find_storyboard()
    arrayStoryBoard=[];
    Dir.chdir(@folder_project) do
      Find.find(".") do
        |e| arrayStoryBoard.push(e) if e.include?("storyboard")
      end
    end
    return arrayStoryBoard;
  end

  def replace_storyboard()
    arrayStoryBoard = []
    Dir.chdir(@folder_project) do
      arrayStoryBoard = find_storyboard()
      #/Users/felipekn/Documents/workspace/objective-c/itau-pf/ItauPf
      for storyboardFileName in arrayStoryBoard
        fileText = File.read(storyboardFileName)
        if fileText.include?("<device")
          puts fileText
          puts "\n"
        else
          arrayStoryBoard-= [storyboardFileName];
        end
      end
      if arrayStoryBoard.count <1
        puts "Xcode 8 Storyboard not found"
      else
        puts "Update Xcode 8 StoryBoards to Xcode 7 Storyboard [Y/N] ?\n #{arrayStoryBoard} ?"
        answer = gets.strip
        if answer.upcase == "Y"
          update_storyboard_to_xcode7(arrayStoryBoard)
        end
      end

    end
  end

  def update_storyboard_to_xcode7(arrayStoryBoard)
    puts "Update"
  end

=begin
  private methods
=end
  private :find_storyboard,:update_storyboard_to_xcode7
end

puts "\n
Welcome :) lets recovery your Xcode 8 storyboard to Xcode 7 storyboard \\\o/
Where is the folder project?"
folder_project = gets.strip
project = Project.new()
project.folder_project = folder_project
project.replace_storyboard()
#~/Users/felipekn/Documents/workspace/objective-c/itau-pf
#/Users/felipekn/Documents/workspace/objective-c
