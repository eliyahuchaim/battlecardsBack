class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :bf1_username
      t.integer :platform
      t.string :rank
      t.integer :kills
      t.integer :deaths
      t.integer :spm
      t.integer :kpm
      t.integer :skill
      t.integer :wins
      t.integer :losses
      t.integer :award_score
      t.integer :avenged_deaths
      t.integer :accuracy_ratio
      t.integer :flags_captured
      t.integer :flags_defended
      t.integer :head_shots
      t.integer :dogtags_taken
      t.string :best_class
      t.integer :highest_kill_streak
      t.integer :kdr
      t.integer :revives
      t.integer :longest_headshot
      t.integer :heals
      t.integer :savior_kills
      t.integer :squad_score
      t.integer :games_played
      t.integer :repairs
      t.integer :kill_assists
      t.integer :suppression_assists

      t.timestamps
    end
  end
end
