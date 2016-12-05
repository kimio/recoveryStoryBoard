#find storyboard
#copy when found xcode 8 version
#make new file with xml
require 'find'
=begin
Lib to parse XML / HTML
=end
require 'nokogiri'

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
      storyboardXcode8 = []
      for storyboardFileName in arrayStoryBoard
        doc = Nokogiri::XML(File.open(storyboardFileName))
        if doc.xpath("//device").count > 0
          storyboardXcode8.push([storyboardFileName,doc]);
        else
          arrayStoryBoard-= [storyboardFileName];
        end
      end
      if arrayStoryBoard.count < 1
        puts "Xcode 8 Storyboard not found"
      else
        puts "Update Xcode 8 StoryBoards to Xcode 7 Storyboard \n#{arrayStoryBoard}\n[Y/N] ?"
        answer = gets.strip
        if answer.upcase == "Y"
          #removing xcode 8 tags
          storyboardXcode8 = update_storyboard_to_xcode7(storyboardXcode8)

          #override xcode8 storyboards files
          puts "Override Files \n#{arrayStoryBoard}\n[Y/N] ?"
          answer = gets.strip
          if answer.upcase == "Y"
            override_xcode8_files(storyboardXcode8)
          end
        end
      end
    end
  end

  def update_storyboard_to_xcode7(storyboardXcode8)
    for file_and_storyboard in storyboardXcode8
      #remove device tag
      file_and_storyboard[1] = remove_device_tag(file_and_storyboard[1])

      #remove capability tag when attributte is minToolsVersion="8.0"
      file_and_storyboard[1] = remove_capability_tag(file_and_storyboard[1])

      #remove capability tag when attributte is minToolsVersion="8.0"
      file_and_storyboard[1] = remove_simulated_metrics_container(file_and_storyboard[1])
    end
    return storyboardXcode8
  end

  ##Remove tag Methods

  def remove_device_tag(storyboard)
    storyboard.search('//device').each do |node|
      node.remove
    end
    return storyboard
  end

  def remove_capability_tag(storyboard)
    storyboard.search('//capability').each do |node|
      if node["minToolsVersion"] == "8.0"
        node.remove
      end
    end
    return storyboard
  end

  def remove_simulated_metrics_container(storyboard)
    storyboard.search('//simulatedMetricsContainer').each do |node|
        node.remove
    end
    return storyboard
  end

  ##Override Xcode 8 files
  def override_xcode8_files(storyboardXcode8)
    for file_and_storyboard in storyboardXcode8
      aFile = File.new(file_and_storyboard[0], "w")
      if aFile
         aFile.syswrite(file_and_storyboard[1].to_s)
         puts "File Updated #{file_and_storyboard[0]}\n"
      end
    end
  end
=begin
  private methods
=end
  private :find_storyboard,
  :update_storyboard_to_xcode7,
  :remove_device_tag,
  :remove_capability_tag,
  :remove_simulated_metrics_container,
  :override_xcode8_files
end

puts "\n
Welcome :) lets recovery your Xcode 8 storyboard to Xcode 7 storyboard \\\o/
Where is the folder project?"
folder_project = gets
project = Project.new()
project.folder_project = folder_project.strip
project.replace_storyboard()
