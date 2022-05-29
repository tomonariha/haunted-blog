# frozen_string_literal: true

class BlogValidator < ActiveModel::Validator
  def validate(record)
    record.random_eyecatch = false if (record.random_eyecatch == true) && (!record.user.premium == true)
  end
end
