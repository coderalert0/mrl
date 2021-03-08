require 'csv'

task update_from_old_db: :environment do
  data = CSV.read('lib/tasks/old_mrl_db.csv')

  data.each do |program_csv_row|
    # Read csv row attributes
    program_code = program_csv_row[1]
    caribbean_img_friendly = program_csv_row[14] == 'yes'
    non_caribbean_img_friendly = program_csv_row[15] == 'yes'
    years_since_graduation = program_csv_row[16].to_i
    us_clinical_experience = program_csv_row[17] == 'yes'

    # Load program from new database
    program = Program.where('acgme_program_code LIKE ?', "%#{program_code}%").first

    # Update new database
    next unless program

    program.us_citizen_international_medical_graduates = 0 unless caribbean_img_friendly
    program.non_us_citizen_international_medical_graduates = 0 unless non_caribbean_img_friendly
    program.years_since_graduation = years_since_graduation if years_since_graduation.positive?
    program.us_clinical_experience = us_clinical_experience if us_clinical_experience
    puts "Program updated: #{program_code}" if program.save!
  end
end
