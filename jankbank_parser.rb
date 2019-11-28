class Transaction < Struct.new(:date, :description, :amount); end
class ParseError < Struct.new(:message)
end

class JankbankParser
  def initialize(line)
    @line = line
  end

  def parse
    /(?<date>\d{2}\/\d{2})/ =~ @line
    return ParseError.new(message: :missing_date) if date.nil?
    date_index = @line.index(date) + date.length
    end_index = @line.length-1
    line_without_date = @line[date_index..end_index]
    /(?<=\s)(?<amount>\d+\.\d+)/ =~ line_without_date
    return ParseError.new(message: :missing_amount) if amount.nil?
    amount_index = line_without_date.index(amount)
    desc = line_without_date[0..amount_index-1].strip
    return Transaction.new(date, desc, amount)
  end
end