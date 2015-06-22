# -*- coding: utf-8 -*-
class FeeCalculator
  class TypeError < StandardError; end

  WDAYS = %W/sun mon tue wed thr fri sat sun/


  def self._basic(range, is_first, simple_attr)
    time = range.first
    attr = simple_attr
    total_fee = 0

    while range.cover? time
      per_minute = attr['per_minute']
      fee = attr['fee']
      if is_first
        per_minute = attr['first_minute'] if attr.key?'first_minute'
        fee =attr['first_fee'] if attr.key? 'first_fee'
      end
      time = time.since(per_minute.minute)
      total_fee += fee
      is_first = false
    end
    if attr.key? 'max'
      total_fee = attr['max'] if total_fee > attr['max']
    end
    [time, total_fee]
  end

  # times_attrのtimesに含まれる料金情報をひとつだけ算出して進めた時間と金額を返す
  #
  # 8時から20時 20時から8時で 9時から21時の範囲を計算したいなら
  # 9時から20時までのみ計算して 20時と料金を返す
  def self._times(range, is_first, times_attr)
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
    _basic(target_range,is_first,attr)
  end

  def self._wday(range, is_first, attr)
    wday = WDAYS[range.first.wday]
    target_attr = attr['wdays'].find do |basic|
      basic['wday'].include? wday
    end
    raise '#{wday}の情報がありあません。 #{attr}' if target_attr.nil?
    # TODO 日付が変わる場合はrangeを分割する必要がある
    _basic(range, is_first, target_attr)
  end

  def self.create_range(time,start_hour,start_min,end_hour,end_min)
    start = time.change(hour: start_hour, minute: start_min)
    _end = time.change(hour:  end_hour, minute: end_min)
    start..._end
  end

  def initialize(attr)
    if attr['type'] == 'within'
      @within = attr
      @attr = attr['within']
    else
      @attr = attr
    end
  end

  def calc(range)
    now = range.first
    fees = []
    fee = 0
    is_first = true
    while range.cover? now
      target_range = now...range.last
      case @attr['type']
      when 'basic'
        now, fee = *_basic(target_range, is_first, @attr)
      when 'times'
        now, fee = *_times(target_range, is_first, @attr)
      when 'wday'
        now, fee = *_wday(target_range, is_first, @attr)
      else
        raise TypeError, '対応していない種類です。'
      end
      is_first = false
      fees << fee
    end
    ret = fees.reduce(0,&:+)

    if @within
      if (range.last - range.begin) < @within['minute'].minute
        within = @within['fee']
        ret = within if ret > within
      end
    end
    ret
  end

  def hour_fee(time= Time.zone.now)
    calc(time...time.since(1.hour))
  end

  def _basic(range, is_first, attr)
    self.class._basic(range, is_first, attr)
  end

  def _times(range, is_first, attr)
    self.class._times(range, is_first, attr)
  end

  def _wday(range, is_first, attr)
    self.class._wday(range, is_first, attr)
  end
end
