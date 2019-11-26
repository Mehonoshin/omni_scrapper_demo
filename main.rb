require 'omni_scrapper'
require 'pry'

# JSON schema that validates correctness of scrapping result
data = {
        type: :object,
        required: [:id_within_site, :title, :url],
        properties: {
          id_within_site: {
            type: :string
          },
          title: {
            type: :string
          },
          url: {
            type: :string
          }
        }
      }


# Generate runnable scrapper class named `camelot`
result = OmniScrapper.setup(:hackernews) do |config|
  config.schema data
  # Set crawler name, that implements logic of navigation through website.
  config.crawler :gallery_on_ferrum

  config.entrypoint 'https://news.ycombinator.com/'
  config.next_page_link '//a[normalize-space(.)="More"]'
  config.page_link '//a[starts-with(@href, "item?id=")]'
  config.id_within_site /id=(\d+)/

  config.field :title,
    selector: '//td[@class="title"]/a/text()'

  config.field :url,
    selector: '//td[@class="title"]/a/@href'
end

# Call scrapper and for each new result execute block.
#result.run { |data| print '.' }
result.run { |data| puts data.inspect }
