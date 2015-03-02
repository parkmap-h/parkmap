class FeeCalculator
  class TypeError < StandardError; end

  def self._basic(range,time,simple_attr)
    time = time.dup
    attr = simple_attr
    fee = 0
    while range.cover? time
      time = time.since(attr['per_minute'].minute)
      fee += attr['fee']
    end
    if attr.key? 'max'
      fee = attr['max']
    end
    [time, fee]
  end

  def initialize(attr)
    @attr = attr
  end

  def calc(range)
    now = range.first
    fees = []
    fee = 0
    while range.cover? now
      case @attr['type']
      when 'basic'
        now, fee = *_basic(range, now, @attr)
      else
        rasie TypeError, '対応していない種類です。'
      end
      fees << fee
    end
    fees.reduce(:+)
  end

  def hour_fee(time=DateTime.now)
    calc(time...time.since(1.hour))
  end

  def _basic(range, now, attr)
    self.class._basic(range, now, attr)
  end
end
