# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Teacher.create!(first_name: 'Sakko', last_name: 'Sama', email: 'sakko@b.c', password: '123456')
Teacher.create!(first_name: 'Kanat', last_name: 'Tangwongsan', email: 'kanat@mahidol.edu', password: '123456')
Student.create!(first_name: 'Majeed', last_name: 'Thaika', email: 'mj@b.c', password: '123456')
Student.create!(first_name: 'John', last_name: 'Virojvatanakul', email: 'john@b.c', password: '123456')
