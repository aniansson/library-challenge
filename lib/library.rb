class Library
  attr_accessor :collection

  def initialize(file_name = './lib/data.yml')
    @file_name = file_name
    @collection = YAML.load_file(file_name)
  end

  def search_by_title(book_title)
    @collection.detect { |book| book[:item][:title].include? book_title }
  end

  def search_by_author(book_author)
    @collection.detect { |book| book[:item][:author].include? book_author }
  end

  def available_books
    available = collection.select { |book| book[:available] == true }

    results = []
    available.each { |book|                       results.push(book[:item][:title]) }
    return results
  end

  def rent_a_book(book)
    collection.each do |search_book|
      if search_book == book
        search_book[:available] = false
        search_book[:return_date] = Date.today.next_month(1).strftime('%d/%m')
      end
    end
    File.open(@file_name, 'w') { |f| f.write collection.to_yaml }
  end
end
