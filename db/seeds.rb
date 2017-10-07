# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

one_time_usage_ips_size = 100

one_time_usage_ips = 1.upto(one_time_usage_ips_size).map { |cnt| "127.0.0.#{cnt}"}

random_time_usage_ips = 1.upto(100).map { |cnt| "127.0.1.#{cnt}"}

autors_logins = 1.upto(200).map { |cnt| Faker::Name.name }

0.upto(200_000) do |cnt|
  ip = (cnt > one_time_usage_ips_size) ? random_time_usage_ips.sample : one_time_usage_ips[cnt]
  params = {
    post_params: { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph },
    author_params: { login: autors_logins.sample },
    ip: ip
  }

  PostBuilder.new(params).create
end
