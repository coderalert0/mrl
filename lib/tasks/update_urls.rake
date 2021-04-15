require 'net/http'

task update_urls: :environment do
  # do not use, many successful requests from the browser fail here

  Program.all.each_with_index do |program, index|
    website = program.website

    next unless website

    puts "Program ID: #{program.id}"
    puts "Name: #{program.name}"
    puts "Speciality: #{program.speciality.name}"
    puts "Website: #{website}"

    begin
      url = URI.parse(website)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = http.request_head(url)
      status_code = request.code

      program.update(website: nil) if status_code == 404
      puts "Status Code: #{status_code}"
    rescue StandardError
      program.update(website: nil)
      puts 'Unable to make request'
    end

    puts "[#{index} of #{Program.count}]\n\n"
  end
end
