module SimilarityScores
  module_function
  def compare(target: ids, data: array_of_id_arrays)
    target = Set.new(target)
    data = data.map{ |ids| Set.new(ids) }
    data.inject(0) { |sum, ids| sum + target.intersection(ids).size }
  end

  def count_distinct(data: array_of_id_arrays)
    data.flatten.uniq.size
  end
end
