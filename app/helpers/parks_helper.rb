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
JSON
  end
end
