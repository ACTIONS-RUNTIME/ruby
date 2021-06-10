require 'pathname'
require 'yajl'

require 'byebug'

parser = Yajl::Parser.new
@results = Hash.new { |h, k| h[k] = Array.new }
@obj_list = []

parser.on_parse_complete = -> (obj) {
  obj_loc = obj.fetch("addr")
  obj_type = obj.fetch("type")

  alloc_key = [obj_loc, obj_type].join('_')

  @obj_list << alloc_key
  @results[alloc_key] << obj
}

json = parser.parse(
  Pathname.new(ARGV.first).expand_path.open
)

alloc_pairs = @results.transform_values { |value| value.count }

@obj_list.each do |id|
  case alloc_pairs[id]
  when 1
    # deallocation without an allocation is an error
    fail @results[id].inspect if @results[id].first["state"] == "free"
  when 2
    states = @results[id].map { |obj| obj["state"] }
  else
    fail @results[id].inspect
  end
end
