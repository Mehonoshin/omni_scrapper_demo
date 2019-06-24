require './scrappers/scrappers'

Scrappers::Camelot::Scrapper.run { |data| p data }
