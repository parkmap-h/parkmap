class FeeCalculator
  class TypeError < StandardError; end

  def self._basic(range,simple_attr)
    time = range.first
    attr = simple_attr
    fee = 0
    while range.cover? time
      time = time.since(attr['per_minute'].minute)
      fee += attr['fee']
    end
    if attr.key? 'max'
      fee = attr['max'] if fee > attr['max']
    end
    [time, fee]
  end

  # times_attrのtimesに含まれる料金情報をひとつだけ算出して進めた時間と金額を返す
  #
  # 8時から20時 20時から8時で 9時から21時の範囲を計算したいなら
  # 9時から20時までのみ計算して 20時と料金を返す
  def self._times(range,times_attr)
    time = range.first
    # 日付の切り替わりごとに分解する
    ranges = []
    times_attr['times'].each do |basic|
      start = basic['start']
      start_hour = start['hour']
      start_min = start['min']
      _end = basic['end']
      end_hour = _end['hour']
      end_min = _end['min']

      if start_hour > end_hour
        ranges << [create_range(time,start_hour,start_min,24,0), basic]
        ranges << [create_range(time,0,0,end_hour,end_min), basic]
      else
        ranges << [create_range(time,start_hour,start_min,end_hour,end_min), basic]
      end
    end

    target,attr = *ranges.select do |target_range,_|
      target_range.cover? time
    end.first
    target_range = time...([range.last,target.last].min)
    _basic(target_range,attr)
  end

  def self.create_range(time,start_hour,start_min,end_hour,end_min)
    start = time.change(hour: start_hour, minute: start_min)
    _end = time.change(hour:  end_hour, minute: end_min)
    start..._end
  end

  def initialize(attr)
    @attr = attr
  end

  def calc(range)
    now = range.first
    fees = []
    fee = 0
    while range.cover? now
      target_range = now...range.last
      case @attr['type']
      when 'basic'
        now, fee = *_basic(target_range, @attr)
      when 'times'
        now, fee = *_times(target_range, @attr)
      else
        raise TypeError, '対応していない種類です。'
      end
      fees << fee
    end
    fees.reduce(:+)
  end

  def hour_fee(time=DateTime.now)
    calc(time...time.since(1.hour))
  end

  def _basic(range, attr)
    self.class._basic(range, attr)
  end

  def _times(range, attr)
    self.class._times(range, attr)
  end
end
