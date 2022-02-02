# class to access the current user and keep all current users separated
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end