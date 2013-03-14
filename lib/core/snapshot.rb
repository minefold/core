require 'active_record'

module Fold
  class Snapshot < ActiveRecord::Base
    belongs_to :server
  end
end
