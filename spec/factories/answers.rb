FactoryGirl.define do
  factory :answer do
    body "MyText"
  end
  factory :invalid_answer do
    # body nil
  end
end
