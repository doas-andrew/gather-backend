User.destroy_all
Event.destroy_all

User.create(username: 'ASAllen67', first_name: 'Andrew', last_name: 'Allen', avatar_url: 'Andrew', password: '123')
User.create(username: 'Guest', first_name: 'Guest', last_name: 'User', password: '123')
User.create(username: 'dekadekadeka', first_name: 'Renee Deka', last_name: 'Ambia', avatar_url: 'Deka', password: '123')
User.create(username: 'Jae', first_name: 'Jaehyun', last_name: 'Park', avatar_url: 'Jaehyun', password: '123')
User.create(username: 'paulatulis', first_name: 'Paula', last_name: 'Tulis', avatar_url: 'Paula', password: '123')
User.create(username: 'PrestonElliott', first_name: 'Preston', last_name: 'Elliot', avatar_url: 'Preston', password: '123')
User.create(username: 'ascotttoney', first_name: 'Scott', last_name: 'Toney', avatar_url: 'Scott', password: '123')
User.create(username: 'The_Otter_Meme', first_name: 'Otto', last_name: 'Ottervanbergstein', avatar_url: 'Otter', password: '123')
User.create(username: 'CodeJones', first_name: 'Williard', last_name: 'Jones', avatar_url: 'Will', password: '123')

FriendRequest.create(sender: User.first, recipient: User.second)

Event.create(
	organizer: User.first,
	title: 'Dog Park Outing',
	details: 'Meeting at 10AM',
	category: 'Pets',
	date: Date.today,
	address: '32 Lafayette Drive NE',
	city: 'Atlanta',
	state: 'Georgia'
)
Attend.create(user: User.first, event: Event.last)

Event.create(
	organizer: User.last,
	title: '5 mile jog through Atlanta',
	details: 'Bring some water!',
	category: 'Health & Fitness',
	date: Date.today,
	address: '1200 Peachtree Street',
	city: 'Atlanta',
	state: 'Georgia'
)
Attend.create(user: User.last, event: Event.last)

50.times do
	user_id = User.all.sample.id
	recipient_id = User.all.sample.id

	if user_id != recipient_id
		Message.create(
			user_id: user_id,
			sender_id: user_id,
			recipient_id: recipient_id, 
			subject: Faker::Quote.famous_last_words,
			content: Faker::Quotes::Shakespeare.hamlet_quote
		)
	end
end
