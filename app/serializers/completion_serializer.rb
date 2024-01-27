class CompletionSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :goal

  attributes :id, :goal_id, :frequency, :created_at

  def frequency
    object.goal&.frequency
  end
end
