book = Book.new

book.id
book.title
book.author_name

book_repository = BookRepository.new

#select all books
#select id, title, author_name FROM books
#return an array of book object 
book_repository.all

#select a single book
#SQL: SELECT * id, title, author_name FROM books WHERE id = '1'
#returns a single Book object
book_repository.find(1)


new_book = Book.new
new_book.title = "Dracula"
#SQL insert into BOOKS

book_repository.create(new_book)

