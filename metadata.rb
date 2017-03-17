# TODO: Add testing for this script

class String
  def red; "\033[31m#{self}\033[0m" end
end

def checkCharCount(file, max)
  file_contents = File.read(file)
  num_chars = file_contents.length
  if num_chars > max
    puts "\nFile: #{file}"
    puts "Warning: too many characters...(#{num_chars})".red
  end
end

if ARGV.empty? || ARGV[0] == "--help"
  puts "\n---- DIRECTIONS ----"
  puts "Provide a command line argument to indicate platform:"
  puts "   -a     # Android"
  puts "   -i     # iOS"
  puts "\nScript must be placed within the top level directory where your metadata files are contained. Make sure to run the script with the proper flags. It will take care of the rest."
else
  # Only modify the file names here if your metadata files are named differently.
  # Do not change the max count values as those are defined by the platform
  # specific guidelines.
  case ARGV[0]
  when "-a"
    file_pairs = {
      "full_description" => 4000,
      "short_description" => 80,
      "[0-9][0-9]" => 500
    }
  when "-i"
    file_pairs = {
      "description" => 4000,
      "release_notes" => 4000,
      "keywords" => 100
    }
  else
    puts "ERROR: invalid argument"
    exit
  end

  file_pairs.each do |name, max|
    Dir.glob("**/#{name}.txt") do |file|
      checkCharCount(file, max)
    end
  end
end
