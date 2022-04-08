# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all
Sub.destroy_all
# PostSub.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('posts')
ActiveRecord::Base.connection.reset_pk_sequence!('subs')
ActiveRecord::Base.connection.reset_pk_sequence!('post_subs')

s1 = Sub.create(title: 'Jerry', description: 'guy', creator_id: User.first.id)
s2 = Sub.create(title: 'Jerry2', description: 'guy', creator_id: User.first.id)
s3 = Sub.create(title: 'Jerry3', description: 'guy', creator_id: User.first.id)

p1 = Post.create(title: 'be happy', url: 'google.com', content: 'search for happiness', author_id: User.first.id)

ps1 = PostSub.create(post_id: p1.id, sub_id: s1.id)
ps2 = PostSub.create(post_id: p1.id, sub_id: s3.id)