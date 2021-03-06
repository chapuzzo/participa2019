class AddPollTranslations < ActiveRecord::Migration[4.2]

  def self.up
    Poll.create_translation_table!(
      {
        name:        :string,
        summary:     :text,
        description: :text
      },
      { migrate_data: true }
    )
  end

  def self.down
    Poll.drop_translation_table!
  end

end
