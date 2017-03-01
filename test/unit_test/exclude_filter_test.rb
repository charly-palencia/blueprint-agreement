require 'test_helper'
require 'json'
require 'blueprint_agreement/exclude_filter'

describe BlueprintAgreement::ExcludeFilter do
  let(:described_module) { BlueprintAgreement::ExcludeFilter }

  describe 'deep_exclude' do
    let(:response) do
      {
        actor: "Morgan Freeman",
        age: 79,
        nominations: {
          oscars: [
            { year: 2010 },
            { year: 2005 }
          ]

        },
        movies: [
          {
            name: 'angel has fallen',
            year: 2018
          },
          {
            name: 'Brubaker',
            year: 1980
          }
        ]
      }
    end

    it 'returns a filtered result' do
      exclude_attributes = ['age', movies: ['year'], nominations: { oscars: ['year'] }]
      expected_result = {
        actor: "Morgan Freeman",
        nominations: {
          oscars: [
            { },
            { }
          ]
        },
        movies: [
          {
            name: 'angel has fallen'
          },
          {
            name: 'Brubaker'
          }
        ]
      }

      filtered_response = described_module.deep_exclude(response, exclude_attributes)
      expect(JSON.generate(filtered_response)).must_equal(JSON.generate(expected_result))
    end

    it 'returns an empty hash when all the attributes were excluded' do
      exclude_attributes = ['age', 'movies', 'actor', 'nominations']
      filtered_response = described_module.deep_exclude(response, exclude_attributes)
      expect(filtered_response).must_equal({})
    end

    it 'returns the same hash when exclude_attributes is nil' do
      exclude_attributes = nil
      filtered_response = described_module.deep_exclude(response, exclude_attributes)
      expect(JSON.generate(filtered_response)).must_equal(JSON.generate(response))
    end
  end
end
