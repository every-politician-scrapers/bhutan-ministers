#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      textparts[0].to_s.delete_prefix('Lyonpo ')
    end

    def position
      textparts[1].to_s.sub('Ministry', 'Minister')
    end

    def empty?
      name.empty?
    end

    private

    def textparts
      noko.xpath('.//text()').map(&:text).map(&:tidy).reject(&:empty?)
    end
  end

  class Members
    def member_items
      super.reject(&:empty?)
    end

    def member_container
      noko.css('#wp-table-reloaded-id-3-no-1 td')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
