# The library should:
# 1. Have a collection of books
# 2. Be able to search for the books
#   - by title and author
#   - by availability
# 3. Let person check out books
#   - change return date to a month from now
require './lib/library.rb'

describe Library do
  let(:fixture_file) { './spec/fixtures/data.yml' }
  before(:each) do
    collection = YAML.load_file('./lib/data.yml')
    File.open(fixture_file, 'w') { |f| f.write collection.to_yaml }
  end

  it 'should have a collection of books' do
    collection = YAML.load_file('./lib/data.yml')
    expect(subject.collection).to eq collection
  end

  context '#search_by_title' do
    it 'should allow to search a book by its title' do
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

    it 'should work with a different title' do
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

  it 'should allow people to checkout books' do

    library = Library.new(fixture_file)
    book = {
      item: {
        title: 'Pippi Långstrump',
        author: 'Astrid Lindgren'
      },
      available: true,
      return_date: nil
    }
    library.rent_a_book(book)
    found_book = library.search_by_title(book[:item][:title])

    expect(found_book[:available]).to eq false
  end

  it 'ensures that the return date is correct when a person borrows a book' do
    expected_return_date = Date.today.next_month(1).strftime('%d/%m')
    library = Library.new(fixture_file)
    book = {
      item: {
        title: 'Pippi Långstrump',
        author: 'Astrid Lindgren'
      },
      available: true,
      return_date: nil
    }
    library.rent_a_book(book)
    found_book = library.search_by_title(book[:item][:title])

    expect(found_book[:return_date]).to eq expected_return_date
  end
end
