require './scrappers/scrappers'
require 'pry'

data = {
  "type"=>"object",
  "required"=>["name", "description"],
  "properties"=>{
    "name"=>{"type"=>"string"},
    "description"=>{"type"=>"string"},
    "phone"=>{"type"=>"string"}
  }
}

OmniScrapper.setup(:camelot) do |config|
  config.schema data
  config.crawler :gallery

  config.entrypoint 'https://www.cmlt.ru/ads--rubric-88'
  config.next_page_link '→'
  config.ad_page_link /ad-\w+/
  config.id_within_site /ad-(.+)/

  config.field :name, selector: '//*[@id="MainContentTable"]/div[1]/table/tbody/tr/td[1]/h1/span'

  #config.field :phone,
    #selector: '//*[@id="MainContentTable"]/div[1]/div/div[1]/div/div[7]/div[2]/div[2]/div/div[2]/span[1]',
    #normalizer: :phone

  config.field :description,
    selector: '//*[@id="MainContentTable"]/div[1]/div/div[1]/div/div[4]'

  #config.field :age,
    #selector: '/html/body/table/tr[4]/td/table/tr/td[2]/table[2]/tr/td[1]/text()[1]',
    #pattern: / (\d{2})/,
    #type_cast_to: Integer

  #config.field :some_field, do: -> (page) { do_something }

  #config.field :comments, method: :scrap_comments
end

Scrappers::Camelot::Scrapper.run { |data| p data }
