class Bottles

  def initialize
    @bottles = 99
  end

  def play
    while @bottles >= 0 do
      displayLine
      @bottles = @bottles - 1
    end
  end

  def displayLine
    puts pluralize(@bottles, "bottle") + " of beer on the wall, " + pluralize(@bottles, "bottle") + " of beer."
    if @bottles > 0
      puts "Take one down and pass it around, " + pluralize(@bottles-1, "bottle") + " of beer on the wall."
    else
      puts "Go to the store and buy some more 99 bottles of beer on the wall."
    end
  end

  def pluralize(n, singular, plural=nil)
    if n == 1
      "1 #{singular}"
    elsif plural and n == 0
      "no more #{plural}"
    elsif plural
      "#{n} #{plural}"
    elsif n == 0
      "no more #{singular}s"
    else
      "#{n} #{singular}s"
    end
  end

end
