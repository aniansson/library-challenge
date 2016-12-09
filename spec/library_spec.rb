# The library should:
# 1. Have a collection of books
# 2. Be able to search for the books
#   - by title and author
#   - by availability
# 3. Let person check out books
#   - change return date to a month from now
require './lib/library.rb'

describe Library do
  it 'should have a collection of books' do
    collection = YAML.load_file('./lib/data.yml')
    expect(subject.collection).to eq collection
  end

  it 'should allow people to search for books by title' do
    book_title = 'Pippi Långstrump'
    expected_book = {
      item: {
        title: 'Pippi Långstrump',
        author: 'Astrid Lindgren'
      },
      available: true,
      return_date: nil
    }

    actual_book = subject.search_by_title(book_title)

    expect(actual_book).to eq expected_book
  end

  it 'should allow people to search for books by title with a different title' do
    book_title = 'Alfons och soldatpappan'
    expected_book = {
      item: {
        title: 'Alfons och soldatpappan',
        author: 'Gunilla Bergström'
      },
      available: true,
      return_date: nil
    }

    actual_book = subject.search_by_title(book_title)

    expect(actual_book).to eq expected_book
  end

  it 'should allow people to search for books by author' do
    book_author = 'Astrid Lindgren'
    expected_book = {
      item: {
        title: 'Pippi Långstrump',
        author: 'Astrid Lindgren'
      },
      available: true,
      return_date: nil
    }

    actual_book = subject.search_by_author(book_author)

    expect(actual_book).to eq expected_book
  end

  it 'should allow people to search for all available books' do
    expected_books = [
      'Alfons och soldatpappan', 'Osynligt med Alfons', 'Pippi Långstrump', 'Pippi Långstrump går ombord'
    ]

    actual_books = subject.available_books

    expect(actual_books).to eq expected_books

  end

#   it 'should allow people to checkout books'
#   it 'ensures that the return date is correct when a person borrows a book'
end
