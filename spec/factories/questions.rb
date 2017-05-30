FactoryGirl.define do
  sequence :title do |n|
    "Question Title №#{n}"
  end

  sequence :body do |n|
    ('a'..'z').to_a.shuffle[0..50].join
  end

  factory :question do
    title
    body
  end

	factory :invalid_question, class: 'Question' do
		title nil
		body nil
	end
end
