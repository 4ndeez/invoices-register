currencies = %w[USD BYN]

# creating users
5.times do
  user = User.create(first_name: Faker::Name.first_name,
              middle_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              id: Faker::Number.unique.between(from: 100_000, to: 99_999_999),
              created_at: Faker::Date.between(from: 1.year.ago, to: Date.today))
  currencies.each {|c| user.invoices.create(currency: c, amount: 1_000)}
end

# creating deposits
users = User.all
users.each do |user|
  Operations::PerformDepositService.new(currency: currencies[0],
                                        receiver_id: user.id,
                                        amount: 100).call
end

# creating transfers
2.times do |index|
  Operations::PerformTransferService.new(currency: currencies[1],
                                         receiver_id: users[index].id,
                                         sender_id: users[index + 2],
                                         amount: 200).call
end

p "created #{User.count} users, #{Invoice.count} invoices, #{Operation.count} operations"