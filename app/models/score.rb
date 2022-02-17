# Model to represent a score played by a golfer
# - total_score: total number of hits to finish all 18 holes
# - played_at: date when the score was played
class Score < ApplicationRecord
  belongs_to :user

  validates :number_of_scores, presence: true, inclusion: { in: [9, 18] }
  validate :future_score
  validate :correct_total_score

  def serialize
    {
      id: id,
      user_id: user_id,
      user_name: user.name,
      total_score: total_score,
      played_at: played_at,
      number_of_scores: number_of_scores,
    }
  end

  private

    def future_score
      errors.add(:played_at, 'must not be in the future') if played_at > Time.zone.today
    end

    def correct_total_score
      errors.add(:total_score, 'must be between [27, 90)')  if number_of_scores == 9 && (total_score < 27 || total_score >= 90)
      errors.add(:total_score, 'must be between [90, 180)') if number_of_scores == 18 && (total_score < 90 || total_score >= 180)
    end
end
