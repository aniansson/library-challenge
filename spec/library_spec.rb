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

#   it 'should allow people to search for books by title'
#   it 'should allow people to search for books by author'
#   it 'should allow people to search for all available books'
#   it 'should allow people to checkout books'
#   it 'ensures that the return date is correct when a person borrows a book'
end
