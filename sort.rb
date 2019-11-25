# To run this file
# At a command line type: ruby json_to_markdown.rb {filepath of json file}
start = Time.now
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

  unless ARGV[0].split(".json")[1] == ".json"
    puts "Must pass in a json file."
    return false
  end

  true
end

def convert_json
  file_name = ARGV[0].split(".json")[0]

  file = File.read("#{file_name}.json")
  json = JSON.parse(file)

  people = []

  json.each do |person|
    names = {}
    keys = {
      "first name" => false,
      "last name" => false,
      "middle initial" => false
    }

    person.keys.each do |name_type|
      key = name_type.downcase
      names[key] = person[name_type]
      keys[key] = true
    end
    keys.each { |k, v| names[k] = "" unless v }
    people << names
  end

  people.sort_by { |k| [k["first name"], k["last name"], k["middle initial"]] }
end


def write_to_file(people)
  file_name = ARGV[0].split(".json")[0]
  output_file = File.open("#{file_name}.md", "w")
  output_file.puts "|first name|last name|middle initial|"
  output_file.puts "|----------|---------|--------------|"

  people.each do |person|
    output_file.puts "|#{person["first name"]}|#{person["last name"]}|#{person["middle initial"]}|"
  end
  output_file.close
end


people = convert_json()

write_to_file(people)

puts "Total time: #{((Time.now - start) * 1000).round(2)} ms"
