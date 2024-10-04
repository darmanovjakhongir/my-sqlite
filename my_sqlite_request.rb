require 'csv'

class MySqliteRequest
def initialize
@type_of_request =: none
@select_columns = []
@where_conditions = []
@insert_values = {}
@table_name = nil
@order =: asc
@order_column = nil
@join_table = nil
@join_column_a = nil
@join_column_b = nil
end

def from(table_name)
@table_name = table_name
self
end

def select(columns)
@select_columns += Array(columns).map( &: to_s)
set_type_of_request(: select)
self
end

def where(column_name, criteria)
@where_conditions << [column_name, criteria]
self
end

def join(column_on_db_a, filename_db_b, column_on_db_b)
@join_table = filename_db_b
@join_column_a = column_on_db_a
@join_column_b = column_on_db_b
self
end

def order(order, column_name)
@order = order
@order_column = column_name
self
end

def insert(table_name)
set_type_of_request(: insert)
@table_name = table_name
self
end

def values(data)
@insert_values = data
if @type_of_request ==: insert
self
end

def update(table_name)
set_type_of_request(: update)
@table_name = table_name
self
end

def set(data)
@insert_values = data
self
end

def delete
set_type_of_request(: delete)
self
end

def update_delete_file(result)
CSV.open(@table_name, "w", headers: result.first.headers) do | csv |
    csv << result.first.headers
  result.each {
    | row | csv << row
  }
end
end

def print_select(result = nil)
if result.nil ?
  return
end

if result.empty ?
  puts "No information found"
else
  header = result.first.keys.join(' | ')
puts header
puts "-" * header.length
result.each {
  | line | puts line.values.join(' | ')
}
puts "-" * header.length
end
end

def print
puts "Type of request: #{@type_of_request}"
puts "Table name: #{@table_name}"
if @type_of_request ==: select
print_select
elsif @type_of_request ==: insert
puts "Insert Values: #{@insert_values}"
end
end

def run
print
case @type_of_request
when: select
result = run_select
print_select(result)
when: insert
run_insert
when: update
result = run_update
update_delete_file(result)
when: delete
result = run_delete
update_delete_file(result)
end
end

private

def set_type_of_request(new_type)
if @type_of_request ==: none || @type_of_request == new_type
@type_of_request = new_type
else
  raise 'Invalid request'
end
end

def run_select
data = CSV.parse(File.read(@table_name), headers: true)
result = []

if @join_table
join_data = CSV.parse(File.read(@join_table), headers: true)
data.each do | row |
  join_data.each do | join_row |
    if row[@join_column_a] == join_row[@join_column_b]
combined_row = row.to_hash.merge(join_row.to_hash)
result << combined_row.slice( * @select_columns)
end
end
end
else
  data.each do | row |
    if @where_conditions.all ? {
  | column,
  value | row[column] == value
}
result << row.to_hash.slice( * @select_columns)
end
end
end

result
end

def run_insert
CSV.open(@table_name, 'a+', headers: true) do | csv |
    csv << @insert_values.keys
  if
csv.count.zero ?
  csv << @insert_values.values
end
end

def run_update
data = CSV.table(@table_name, headers: true)
data.each do | row |
  if @where_conditions.all ? {
  | column,
  value | row[column] == value
}
@insert_values.each {
  | key, val | row[key] = val
}
end
end
data
end

def run_delete
data = CSV.table(@table_name, headers: true)
data.delete_if {
  | row | @where_conditions.any ? {
    | column,
    value | row[column] == value
  }
}
data
end
end
