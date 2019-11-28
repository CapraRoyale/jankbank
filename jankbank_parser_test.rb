require 'test/unit'
require './jankbank_parser'

janky_bank_data = <<DATA
  09/11                   FANG PET & GARDEN SUPPLY PORTLAND OR                                                                      41.98
  09/12                   AMZN Mktp US*0107436H3 Amzn.com/bill WA                                                                   22.98
  09/12                   24HOUR FITNESS USA,INC 800-432-6348 CA                                                                    78.91
  09/12                   Amazon Music*792VE47S3 888-802-3080 WA                                                                     3.99
  09/12                   4K 4CHARITY FUN RUN AT WWW.CVENT.COM VA                                                                   50.00
DATA

JANKY_LINES = janky_bank_data.split(/\n/)

class TestJankbankParser < Test::Unit::TestCase
  def setup
    @fang_line =    JANKY_LINES[0] # pet store
    @amzn_line =    JANKY_LINES[1] # amazon purchase
    @gym_line =     JANKY_LINES[2] # gym
    @music_line =   JANKY_LINES[3] # amazon music
    @charity_line = JANKY_LINES[4] # 4k 4 Charity!
    @fang = JankbankParser.new(@fang_line).parse
    @amzn = JankbankParser.new(@amzn_line).parse
    @gym = JankbankParser.new(@gym_line).parse
    @music = JankbankParser.new(@music_line).parse
    @charity = JankbankParser.new(@charity_line).parse
  end

  def test_parse_date
    assert @fang.date == "09/11"
    assert @amzn.date == "09/12"
    assert @gym.date == "09/12"
    assert @music.date == "09/12"
    assert @charity.date == "09/12"
  end

  def test_parse_description
    assert @fang.description == "FANG PET & GARDEN SUPPLY PORTLAND OR"
    assert @amzn.description ==    "AMZN Mktp US*0107436H3 Amzn.com/bill WA"
    assert @gym.description ==     "24HOUR FITNESS USA,INC 800-432-6348 CA"
    assert @music.description ==   "Amazon Music*792VE47S3 888-802-3080 WA"
    assert @charity.description == "4K 4CHARITY FUN RUN AT WWW.CVENT.COM VA"
  end

  def test_parse_amount
    assert @fang.amount == "41.98"
    assert @amzn.amount == "22.98"
    assert @gym.amount == "78.91"
    assert @music.amount ==  "3.99"
    assert @charity.amount == "50.00"
  end
  
  def test_parse_missing_date
    assert JankbankParser.new("bogus 42.20").parse == ParseError.new(
      message: :missing_date
    )
  end

  def test_parse_missing_amount
    assert JankbankParser.new("08/15 bogus").parse == ParseError.new(
      message: :missing_amount
    )
  end
end