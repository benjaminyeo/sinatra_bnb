User.create(username: "Mentor", password: 1234)
User.create(username: "Ali" , password: 1234)

User.first.properties.create(name: "Studio for male", location: "Cyberjaya", availability: "O")
User.first.properties.create(name: "Loft for female", location: "Putrajaya", availability: "X")
User.second.properties.create(name: "3 bedroom Apartment", location: "Subang Jaya", availability: "O")

Property.first.comments.create(body: "This place is really nice!", user_id: 2)
Property.second.comments.create(body: "This place is really bad!", user_id: 2)
Property.third.comments.create(body: "This place is really hot!", user_id: 1)