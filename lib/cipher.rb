require 'date'

class  Cipher
  attr_reader :charset, :date

  def initialize
    @charset = ('a'..'z').to_a << ' '
    @date = Date.today.strftime('%d%m%y')
  end
end
