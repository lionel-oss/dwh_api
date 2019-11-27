require 'csv'

module ApplicationHelper
  def to_csv(array_of_hashes)
    return [] unless array_of_hashes.first

    CSV.generate do |csv|
      csv << array_of_hashes.first.keys
      array_of_hashes.map { |hash| csv << hash.values }
    end
  end
end
