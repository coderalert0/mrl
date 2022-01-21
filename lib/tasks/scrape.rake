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

task scrape_schools: :environment do
  $stdout.puts 'Please enter your email address:'
  email = $stdin.gets.strip

  $stdout.puts 'Please enter your password:'
  password = $stdin.gets.strip

  args = %w[--headless]
  options = { args: args }
  browser = Watir::Browser.new :firefox, options: options

  # Login
  browser.goto('https://www.doximity.com/signin')
  browser.text_field(id: 'login').set email
  browser.text_field(id: 'password').set password
  browser.button(id: 'signinbutton').click
  browser.wait_until { browser.text.include? 'Home' }

  Program.active.includes(:program_users)

  # List all specialities with id
  Speciality.active.all.each do |speciality|
    $stdout.puts "#{speciality.id} - #{speciality.name}"
  end
  $stdout.puts 'Please enter a Speciality ID:'
  speciality_id = $stdin.gets.strip

  # Prompt for doximity URL for programs sorted by IMG Friendliness
  Speciality.find(speciality_id).programs.active.order(:name).each do |program|
    next unless program.feeder_schools.nil?

    $stdout.puts program.name
    $stdout.puts program.address
    $stdout.puts program.program_director
    $stdout.puts program.program_coordinator
    $stdout.puts 'Please enter a corresponding Doximity URL:'
    doximity_url = $stdin.gets.strip
    next unless doximity_url.present?

    program.update(doximity_url: doximity_url)

    browser.goto(doximity_url)
    browser.wait_until { browser.text.include? 'Read more about' }

    feeder_list_elements = browser.lis(class: 'residency-program-top-feeder-list-item')

    program.update(feeder_schools: feeder_list_elements.count.positive?)

    feeder_list_elements.each do |li|
      next if li.text == 'Other'

      medical_school = MedicalSchool.find_or_create_by(name: li.text)
      MedicalSchoolProgram.find_or_create_by(medical_school: medical_school, program: program)
    end

    $stdout.puts program.reload.feeder_schools.to_s
    $stdout.puts program.medical_schools.map(&:name).to_s
    $stdout.puts
    $stdout.puts
  end

  browser.close
end

task scrape_schoolz: :environment do
  # This number will change every year
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

  (798..total_program).each do |index|
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
    feeder_medical_schools_element = browser.element(xpath: '//*[@id="top5body"]/div/script[1]')
    if feeder_medical_schools_element.exists?
      feeder_medical_schools_element = feeder_medical_schools_element.html.gsub(/\{(.*?)\}/).first
      feeder_medical_schools_element = JSON.parse(feeder_medical_schools_element)

      program = Program.find_by(acgme_program_code: program_hash['acgme_program_code'])
      unless program.medical_schools.present?
        feeder_medical_schools_element.each do |key, value|
          next if key == 'More than 1 school has this rank*' || value < 10

          puts "#{key}: #{value}"
          medical_school = MedicalSchool.find_or_create_by(name: key)
          MedicalSchoolProgram.find_or_create_by(medical_school: medical_school, program: program)
        end
      end
    end

    puts
  rescue StandardError
    puts 'An error occurred'
  end

  browser.close
end
