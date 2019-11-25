# To run this file
# At a command line type: ruby json_to_markdown.rb {filepath of json file}

require 'json'

def valid_inputs?
  if ARGV.empty?
    puts "Must pass in a json file."
    return false
  end

  unless File.file? ARGV[0]
    puts "Must pass in a json file."
    return false
  end

  unless ARGV[0].split(".")[1] == "json"
    puts "Must pass in a json file."
    return false
  end

  true
end

def convert_json
  file_name = ARGV[0].split(".json")[0]

  file = File.read("#{file_name}.json")
  json = JSON.parse(file)

  output_file = File.open("#{file_name}.md", "w")
  output_file.puts "|first name|last name|middle initial|"
  output_file.puts "|----------|---------|--------------|"

  json.each do |person|
    names = {}
    person.keys.each do |name|
      key = name.downcase
      names[key] = person[name]
    end
    output_file.puts "|#{names["first name"]}|#{names["last name"]}|#{names["middle initial"]}|"
  end

  output_file.close
end



convert_json() if valid_inputs?()
