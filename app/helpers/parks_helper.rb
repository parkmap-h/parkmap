module ParksHelper
  def sample_fee_json
    <<JSON
{
  "type":"times",
  "times":[
    {
       "type":"basic",
       "start":{"hour":7,"min":0},
       "end":{"hour":22,"min":0},
       "per_minute":30,
       "fee":180,
       "max":1200
    },
    {
       "type":"basic",
       "start":{"hour":22,"min":0},
       "end":{"hour":7,"min":0},
       "per_minute":30,
       "fee":180,
       "max":1200
    }
  ]
}

12時間以内の最大料金がある場合の例
{
  "type": "within",
  "minute": 720,
  "fee": 1300,
  "repeat": true,
  "within": {
    "type": "times",
    "times": [
      {
        "type": "basic",
        "start": {
          "hour": 8,
          "min": 0
        },
        "end": {
          "hour": 20,
          "min": 0
        },
        "per_minute": 60,
        "fee": 200
      },
      {
        "type": "basic",
        "start": {
          "hour": 20,
          "min": 0
        },
        "end": {
          "hour": 8,
          "min": 0
        },
        "per_minute": 60,
        "fee": 100
      }
    ]
  }
}

JSON
  end
end
