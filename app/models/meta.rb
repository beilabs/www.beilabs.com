require 'action_view/helpers/date_helper'
include ActionView::Helpers::DateHelper

class Meta < ActiveRecord::Base
  def self.last_commit
    begin
      commits = GitHub::API.commits('beilabs','www.beilabs.com')
      message = "This site was last updated on #{ commits.first.committed_date.to_time + 7.hours }"
      File.open("#{ Rails.root }/app/views/shared/_last_commit.html.haml", 'w') {|f| f.write( message ) }
    rescue Exception => e
      logger.error "An exception occured when saving the file #{e.to_s}"
    end
  end
end
