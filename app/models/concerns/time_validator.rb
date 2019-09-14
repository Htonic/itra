class TimeValidator < ActiveModel::Validator
  def validate(record)
    if not record.end_time.nil?
      record.end_time.future?
    end
  end
end
