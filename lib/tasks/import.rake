namespace :import do
  desc 'Import local census users from csv file'
  task :csv, [:filename] => :environment do |t, args|
    require 'csv'
    require 'date'

    # document_types = {
    #   'N.I.F.' => 1,
    #   'PASAPORTE' => 2,
    #   'T. RESIDENCIA' => 3
    # }

    birth_date_threshold = Date.new 2003, 7, 15

    # nif, type, date, postal_code
    CSV.foreach(args[:filename]) do |row|
      date_of_birth = Date.strptime(row[2], '%d/%m/%Y')
      document_type = row[1].to_i

      next unless document_type
      next unless date_of_birth < birth_date_threshold

      created_record = LocalCensusRecord.new({
        document_number: row[0],
        document_type: document_type,
        date_of_birth: date_of_birth.to_s,
        postal_code: row[3].blank? ? '03760' : row[3]
      })

      created_record.save!
      print '.'
    end
  end
end
