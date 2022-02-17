class AddNumberOfScoresToScores < ActiveRecord::Migration[6.1]
  def change
    add_column :scores, :number_of_scores, :integer
  end
end
