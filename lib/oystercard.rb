class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_log
  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_log = {}
  end

  def top_up(sum)
    fail "£#{MAXIMUM_BALANCE} limit" if (@balance + sum) > MAXIMUM_BALANCE
    @balance += sum
  end
  def touch_in(station)
    fail "Insufficient funds. Please top up" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end
  def touch_out(station) 
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    journey
  end
  def in_journey?
    !!entry_station
  end
  def entry_station
    @entry_station
  end
  def exit_station
    @exit_station
  end
  def journey
    @journey_log[@entry_station] = @exit_station
    @entry_station = nil
  end
  def view_journey
    puts @journey_log
  end


  private
  def deduct(fare)
    @balance -= fare
  end
end