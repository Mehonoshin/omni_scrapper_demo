module Scrappers
  class AdsSchema < OmniScrapper::Schema
    def schema
      {
        type: :object,
        required: [:name, :description],
        properties: {
          name: {
            type: :string
          },
          description: {
            type: :string
          },
          phone: {
            type: :string
          }
        }
      }
    end
  end
end
