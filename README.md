== The problem ==
* Every year thousands of medical students apply to residency programs across the country. There are thousands of residency programs to apply to across specialties

* Application costs go into the thousands of dollars, so most applicants need to be very selective in where they apply
The application criteria for each program varies and is listed on each residency programs website, therefore applicants have to visit every website to see if they meet the application criteria


== The solution ==
* Build a centralized database of structured application criteria which applicants can query against using their scores, experience, immigration status, etc that returns them a list of residency programs whose criteria they satisfy

* The list can be consumed in html format or by downloading a csv file

* Saves them time from having to visit every website individually, time which they can spend on writing their personal statement, build volunteer experience, etc

== The tech stack ==
* Ruby on Rails (dockerized)
  ahoy_matey (track visitors and events)
  cancancan (authorization)
  devise (authentication)
  draper (decorators)
  friendly_id (seo-friendly urls)
  paper_trail (auditing)
  rubocop (style checking)
  stripe (payments)
  watir (web scraping)
  wicked (workflows)
* PostgreSQL
* HTML

== Web scraping ==
* The database was populated using a combination of manual entry and webscraping other websites
* Watir gem was scraping (typically used for UI test automation) using a combination of ids, text match, xpath to identify elements

== UML Diagram ==
<img width="942" alt="image" src="https://user-images.githubusercontent.com/70709697/231295382-3dd40327-25a0-4915-a89f-6ccf3434de78.png">

