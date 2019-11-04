require 'omni_scrapper'

# JSON schema that validates correctness of scrapping result
data = {
  "type"=>"object",
  "required"=>["name", "description"],
  "properties"=>{
    "name"=>{"type"=>"string"},
    "description"=>{"type"=>"string"},
    "phone"=>{"type"=>"string"}
  }
}

# Generate runnable scrapper class named `camelot`
result = OmniScrapper.setup(:camelot) do |config|
  config.schema data
  # Set crawler name, that implements logic of navigation through website.
  config.crawler :gallery

  # Set crawler parameters, required for succesful navigation
  #
  # Initial page where crawler starts its journey
  config.entrypoint 'https://www.cmlt.ru/ads--rubric-88'
  # A text on the link, which leads crawler to the next page in the list
  config.next_page_link '//*[@id="MainContentTable"]/div[6]/a[9]'
  # A pattern that allows crawler to detect links to specific pages, that should contain actual data
  config.page_link '//*[@id="ans-list-box"]/div[*]/div/a'
  # A pattern in specific page URL, which defines it's unique ID
  config.id_within_site /ad-(.+)/

  # Example fields that should be extracted from page and saved into result
  # Accepts XPATH selector, that points to specific piece of data.
  config.field :name, selector: '//*[@id="MainContentTable"]/div[1]/table/tbody/tr/td[1]/h1/span'
  config.field :description,
    selector: '//*[@id="MainContentTable"]/div[1]/div/div[1]/div/div[4]'
  config.field :phone, selector: '//*[@id="an-contacts-block"]/div[2]/div[1]/div[2]/span[1]'

  # Example of additional options that may be passed to field
  #config.field :age,
    #selector: '/html/body/table/tr[4]/td/table/tr/td[2]/table[2]/tr/td[1]/text()[1]',
    #pattern: / (\d{2})/,
    #type_cast_to: Integer

  # Example of proc usage for field proccessing
  #config.field :some_field, do: -> (page) { do_something }
end

# Call scrapper and for each new result execute block.
result.run { |data| p data }
