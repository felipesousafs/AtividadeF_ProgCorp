# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '[-] Apagando usuários...'
User.destroy_all
User.reset_pk_sequence
puts '[-] Apagando taxas de condomínio...'
CondominiumFee.destroy_all
CondominiumFee.reset_pk_sequence
puts '[-] Apagando despesas...'
Expense.destroy_all
Expense.reset_pk_sequence
puts '[-] Apagando apartamentos...'
Apartment.destroy_all
Apartment.reset_pk_sequence

puts '[+] Criando Usuários...'
User.create!(
    email: "admin@email.com",
    password: 123456,
    name: "Administrador",
    phone: "86 9111-1111"
)
9.times do |i|
  User.create!(
      email: "teste#{i+1}@email.com",
      password: 123456,
      name: "Teste #{i+1}",
      phone: "86 99#{i}9-999#{i}"
  )
end

puts '[+] Criando Apartamentos...'
x = 6
5.times do |i|
  Apartment.create!(
               number: i+1,
               number_of_rooms: 3,
               resident_id: x,
               owner_id: i+1
  )
  x += 1
end
x = 1
5.times do |i|
  Apartment.create!(
      number: x+5,
      number_of_rooms: 2,
      resident_id: x,
      owner_id: i+1
  )
  x += 1
end

puts '[+] Criando Expenses...'
n = 5
day = (Date.today.at_beginning_of_month + 15.days)
5.times do |i|
  Expense.create(
      description: "Água",
      is_fixed_value: true,
      month_of_ref:  day - (n-i).month,
      created_at:  day - (n-i).month,
      updated_at:  day - (n-i).month,
      value: 500+(20*i)
  )
  Expense.create(
      description: "Energia elétrica",
      is_fixed_value: true,
      month_of_ref:  day - (n-i).month,
      created_at:  day - (n-i).month,
      updated_at:  day - (n-i).month,
      value: 1000-(20*i)
  )
  Expense.create(
      description: "Uso do Salão de Festas",
      apartment_id: i+1,
      month_of_ref:  day - (n-i).month,
      created_at:  day - (n-i).month,
      updated_at:  day - (n-i).month,
      value: 25
  )
  CondominiumFee.generate_condominium_fee(Apartment.all, day - (n-i).month)
end
