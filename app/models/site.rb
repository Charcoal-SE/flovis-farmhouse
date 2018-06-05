# frozen_string_literal: true

class Site < ApplicationRecord
  has_many :posts

  def self.update_sites
    require 'net/http'
    url = URI.parse('https://api.stackexchange.com/2.2/sites?pagesize=1000&filter=!SlEYpdqUFo-phXUJAq')
    res = Net::HTTP.get_response(url)
    sites = JSON.parse(res.body)['items']
    return unless sites.count > 100 # all is not well; bail
    sites.each do |site|
      uri = URI.parse(site['site_url'])
      s = Site.find_or_initialize_by(domain: uri.host)

      s.api_parameter = site['api_site_parameter']
      s.url = site['site_url']
      s.icon_url = site['favicon_url'].gsub(/https?:/, '')
      s.name = site['name']
      s.is_child_meta = site['site_type'] == 'meta_site'
      s.save!
    end
  end
end
