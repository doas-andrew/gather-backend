User.destroy_all
Event.destroy_all

User.create(username: 'ASA', first_name: 'Andrew', last_name: 'Allen', avatar_url: 'Andrew', password: '123')
User.create(username: 'dekadekadeka', first_name: 'Renee Deka', last_name: 'Ambia', avatar_url: 'Deka', password: '123')
User.create(username: 'Jae', first_name: 'Jaehyun', last_name: 'Park', avatar_url: 'Jaehyun', password: '123')
User.create(username: 'paulatulis', first_name: 'Paula', last_name: 'Tulis', avatar_url: 'Paula', password: '123')
User.create(username: 'PrestonElliott', first_name: 'Preston', last_name: 'Elliot', avatar_url: 'Preston', password: '123')
User.create(username: 'ascotttoney', first_name: 'Scott', last_name: 'Toney', avatar_url: 'Scott', password: '123')
User.create(username: 'The_Otter_Meme', first_name: 'Otto', last_name: 'Ottervanbergstein', avatar_url: 'Otter', password: '123')
User.create(username: 'CodeJones', first_name: 'Williard', last_name: 'Jones', avatar_url: 'Will', password: '123')

FriendRequest.create(recipient: User.first, sender: User.second)
FriendRequest.create(recipient: User.first, sender: User.third)

50.times do
	user_id = User.all.sample.id
	recipient_id = User.all.sample.id

	Message.create(
		user_id: user_id,
		sender_id: user_id,
		recipient_id: recipient_id, 
		subject: Faker::Quote.famous_last_words,
		content: Faker::Quotes::Shakespeare.hamlet_quote
	) unless user_id == recipient_id
end
