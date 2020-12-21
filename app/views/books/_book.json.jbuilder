json.extract! book, :id, :title, :description, :cover

json.url book_url(book, format: :json)
