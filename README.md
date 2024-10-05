# My Sqlite

A lightweight SQL-like command-line interface for working with CSV files as a database. MySQLite CLI supports 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'JOIN', 'WHERE' and 'ORDER' functions.

## Contents

- [Task](#task)
- [Description](#description)
- [Install](#install)
- [Usage](#usage)

## Task

- [x] You will need to create a folder and in this folder will be additional files containing your work.
- [x] Folder names must start with special file names and also contain ( my_sqlite_request.rb my_sqlite_cli.rb ).
- [x] Create a class called MySqliteRequest in my_sqlite_request.rb.
- [x] It will have a similar behavior than a request on the real sqlite.

## Description

The MySQLite CLI allows users to perform SQL-like operations on CSV files. It is built using Ruby and provides a simple interface for database-like interactions. Supported commands include:

- **SELECT**: select columns from a CSV file with optional filtering and sorting.
- **INSERT**: Insert new lines into CSV file.
- **UPDATE**: Update existing rows in a CSV file based on specified conditions.
- **DELETE**: Delete rows from a CSV file based on specified conditions.
- **JOIN**: Join two CSV files in specified columns.
- **WHERE**: Filter rows based on conditions.
- **Order**: sort rows based on column.

## Installation

1. Make sure you have Ruby installed on your system.
2. Clone this repository: `https://github.com/darmanovjakhongir/Full-Stack-My-Sqlite.git`.
3. Go to the project directory: `cd Full-Stack-My-Sqlite`.
4. Install the required gems (CSV is part of the Ruby standard library): `bundle install`.
5. Make sure the `my_sqlite_request.rb` file is in the same directory as your CLI script.

## Usage

1. Run the following command in the terminal to start My-SQLite: `ruby my_sqlite_cli.rb`.
2. To exit My-SQLite, type exit and press Enter.

## Core team

<span><i> Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span >
