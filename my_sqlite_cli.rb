require 'readline'
require_relative "request"

def read_cli_input
input = Readline.readline('my_sqlite_cli>> ', true)
input
end

def parse_key_value_pairs(arr)
result = {}
arr.each do | pair |
    key, value = pair.split("=")
  result[key.strip] = value.strip
end
result
end

def process_cli_request(action, args, request)
case action
when "from"
request.from( * args)
when "select"
request.select(args)
when "where"
column, value = args[0].split("=")
request.where(column.strip, value.strip)
when "insert"
request.insert( * args)
when "values"
request.values(parse_key_value_pairs(args))
when "update"
request.update( * args)
when "set"
request.set(parse_key_value_pairs(args))
when "delete"
request.delete
else
  print_error_message(action)
end
end

def print_error_message(action = nil)
if action
puts "Undefined method: #{action}!"
else
  puts "Undefined method!"
end
end

def parse_sql_input(sql)
valid_actions = ["SELECT", "FROM", "WHERE", "INSERT", "VALUES", "UPDATE", "SET", "DELETE"]
tokens = sql.split(" ")
command = nil
args = []
request = MySqliteRequest.new

tokens.each do | token |
  if valid_actions.include ? (token.upcase)
process_command(command, args, request) if command
command = token.downcase
args = []
else
  args << token
end
end

finalize_request(command, args, request)
end

def process_command(command, args, request)
args = args.join(" ").split(", ")
process_cli_request(command, args, request)
end

def finalize_request(command, args, request)
if args.last & .end_with ? (";")
args[-1] = args.last.chomp(";")
process_cli_request(command, args, request)
request.run
else
  print_missing_semicolon_error
end
end

def print_missing_semicolon_error
puts "Finish your request with a semicolon (';')."
end

def run_cli
puts "Welcome to MySQLite CLI!"
puts "Type your SQL commands to interact with the database."
puts "End each command with a semicolon (';') and press Enter."
puts "Type 'exit' to quit the application."

while (command = read_cli_input)
  break
    if command.strip.downcase == "exit"
begin
parse_sql_input(command)
rescue => e
puts "Error processing command: #{e.message}"
end
end
end

run_cli
