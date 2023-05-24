1. Design and create the Table

2. Create Test SQL seeds

TRUNCATE TABLE books RESTART IDENTITY; -- replace with your own table name.

INSERT INTO books (title, author_name) VALUES ('Title_1', 'Author_1');
INSERT INTO books (title, author_name) VALUES ('Title_2', 'Author_2');

psql -h 127.0.0.1 your*database_name < seeds*{table_name}.sql

3. Define the class names
   Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE

# Table name: book

# Model class

# (in lib/book.rb)

class Book
end

# Repository class

# (in lib/book_repository.rb)

class BookRepository
end

4. Implement the Model class
   Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE

# Table name: book

# Model class

# (in lib/book.rb)

class Book

# Replace the attributes by your own columns.

attr_accessor :id, :title, :author_name
end

# The keyword attr_accessor is a special Ruby feature

# which allows us to set and get attributes on an object,

# here's an example:

#

# book = Book.new

# book.name = 'Emma'

# book.name

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
   Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE

# Table name: books

# Repository class

# (in lib/book_repository.rb)

class BookRepository

# Selecting all records

# No arguments

def all # Executes the SQL query: # SELECT id, title, author_name FROM students;

    # Returns an array of Book objects.

end

# Gets a single record by its ID

# One argument: the id (number)

def find(id) # Executes the SQL query:

# SELECT id, title, author_name FROM books WHERE id = 1;

    # Returns a single Book object.

end

# Add more methods below for each operation you'd like to implement.

# def create(book)

# end

# def update(book)

# end

# def delete(book)

# end

end

6. Write Test Examples
   Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1

# Get all book

repo = BookRepository.new

book = repo.all

book.length # => 2

books[0].id # => 1
books[0].name # => 'Nineteen Eighty-Four'
books[0].author_name # => 'George Orwell'

books[1].id # => 2
books[1].name # => 'Mrs Dalloway'
books[1].author_name # => 'Virginia Woolf'

# 2

# Get a single book

repo = BookRepository.new

book = repo.find(1)

books.id # => 1
books.name # => 'Nineteen Eighty-Four'
books.author_name # => 'George Orwell'

# Add more examples for each method

Encode this example as a test.

7. Reload the SQL seeds before each test run
   Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/book_repository_spec.rb

def reset_book_table
seed_sql = File.read('spec/seeds_book.sql')
connection = PG.connect({ host: '127.0.0.1', dbname: 'book' })
connection.exec(seed_sql)
end

describe BookRepository do
before(:each) do
reset_book_table
end

# (your tests will go here).

end

8.  Test-drive and implement the Repository class behaviour
    After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
