require 'watir'

task scrape: :environment do
  # browser.screenshot.save 'screenshot.png'

  # This number will change every year
  total_program = 5122

  program_hash = {}

  args = %w[--headless]
  options = { args: args }
  browser = Watir::Browser.new :firefox, options: options

  # Login
  browser.goto('https://www.residencyexplorer.org/')
  browser.link(text: 'Login to Account').click

  $stdout.puts 'Please enter your username:'
  email = $stdin.gets.strip

  $stdout.puts 'Please enter your password:'
  password = $stdin.gets.strip

  browser.text_field(id: 'mat-input-2').set email
  browser.text_field(id: 'password-field').set password
  browser.button(id: 'login-btn').click
  browser.wait_until { browser.text.include? 'Logout' }

  (1..total_program).each do |index|
    puts "#{index} of #{total_program}"

    # Visit program details page
    browser.goto("https://www.residencyexplorer.org/Program/GetById/#{index}")
    browser.wait_until { browser.text.include? 'Program Quick Facts' }

    # Extract program name
    program_hash['name'] = browser.h1(class: 'program-detail-name').text

    # Extract speciality
    speciality_name = browser.th(text: /Average for ACGME/).text.split("\n")[1].gsub(' Programs', '')

    # Extract program address
    program_hash['address'] = browser.label(text: 'Address:').parent.text.gsub("Address:\n", '')

    # Extract program attributes
    ['ACGME Program Code', 'Website', 'Phone', 'Email',
     'Program Coordinator Phone', 'Program Coordinator', 'Program Coordinator Email',
     'Program Director'].each do |label_text|
      label_element = browser.label(text: /#{label_text}/)

      program_hash[label_text.snakify] = label_element.siblings[1].text if label_element.siblings[1].exists?
    end

    # Extract more program attributes
    ['Minimum Step 1 Score', 'Step 2 Required', 'Minimum Step 2 Score',
     'J-1 Sponsorship through ECFMG', 'H1-B'].each do |td_text|
      th_element = browser.th(text: /#{td_text}/)

      next unless th_element.siblings[1].exists?

      program_hash[td_text
                   .gsub(' for Interview Consideration', '')
                   .snakify] = th_element.siblings[1].text
    end

    # Extract F1
    th_element = browser.th(text: /F-1/)

    # Extract Step CS pass criteria
    th_element = browser.th(text: /Must pass either the USMLE Step 2 CS/)

    program_hash['must_pass_step_2_cs_first_attempt'] = th_element.siblings[1].text if th_element.siblings[1].exists?

    # Extract applicant type stats
    applicant_types_element = browser.element(xpath: '//*[@id="collapseResDemoAndBkgd"]/div/div[3]/div/div/script[2]')
    applicant_types = applicant_types_element.html.gsub(/\{(.*?)\}/).first
    applicant_types = JSON.parse(applicant_types)

    applicant_types.each do |key, value|
      program_hash[key.snakify] = value
    end

    program_hash['active'] = true

    puts program_hash

    # Create speciality
    speciality = Speciality.find_or_create_by!(name: speciality_name) do |s|
      s.active = true
    end

    # Create or update program
    program = Program.where(acgme_program_code: program_hash['acgme_program_code']).first

    if program.present?
      program.update!(program_hash)
    else
      Program.create! program_hash.merge(speciality_id: speciality.id, active: true)
    end
  rescue StandardError
    puts 'An error occurred'
  end

  browser.close
end

task scrape_schoolz: :environment do
  # This number will change every year, manually need to check max value
  total_program = 5122

  program_hash = {}

  args = %w[--headless]
  options = { args: args }
  browser = Watir::Browser.new :firefox, options: options

  # Login
  browser.goto('https://www.residencyexplorer.org/')
  browser.wait_until { browser.text.include? 'Login to Account' }

  browser.link(text: 'Login to Account').click

  $stdout.puts 'Please enter your username:'
  email = $stdin.gets.strip

  $stdout.puts 'Please enter your password:'
  password = $stdin.gets.strip

  browser.text_field(id: 'mat-input-2').set email
  browser.text_field(id: 'password-field').set password
  browser.button(id: 'login-btn').click
  browser.wait_until { browser.text.include? 'Logout' }

  (1..total_program).each do |index|
    puts "#{index} of #{total_program}"

    # Visit program details page
    browser.goto("https://www.residencyexplorer.org/Program/GetById/#{index}")
    browser.wait_until { browser.text.include? 'Program Quick Facts' }

    # Extract program name
    program_hash['name'] = browser.h1(class: 'program-detail-name').text

    label_element = browser.label(text: 'ACGME Program Code')
    program_hash['ACGME Program Code'.snakify] = label_element.siblings[1].text if label_element.siblings[1].exists?

    puts program_hash

    # Extract feeder medical schools
    feeder_medical_schools_element = browser.element(xpath: '//*[@id="MedSchoolModal"]//tbody')
    if feeder_medical_schools_element.exists?
      feeder_medical_schools_element.trs.each do |tr|
        medical_school_name = tr.tds[0].text_content
        percentage = tr.tds[2].text_content.delete('%')
        puts "#{medical_school_name}: #{percentage}"

        program = Program.find_by(acgme_program_code: program_hash['acgme_program_code'])

        medical_school = MedicalSchool.find_or_create_by(name: medical_school_name)
        medical_school_program = MedicalSchoolProgram.find_or_create_by(medical_school: medical_school,
                                                                        program: program)

        # will result in bad data on re-runs
        medical_school_program.increment!(:percentage, percentage.to_i)
      end
    end

    puts
  rescue StandardError
    puts 'An error occurred'
  end

  browser.close
end
