class CompletionSerializer < ActiveModel::Serializer
  attributes :id, :goal_id, :frequency, :created_at

  def frequency
    object.goal&.frequency
  end
end
