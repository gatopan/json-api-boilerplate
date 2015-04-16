class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  def validate_each(record, attribute, value)
    unless value =~ EMAIL_REGEX
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

