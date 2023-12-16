# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
questions_data = [
  { body: "次の2択から自分にあった方を選んでください" },
  { body: "自分に当てはまる方を選んでください" },
  { body: "自分に当てはまる方を選んでください" },
  # Add more questions as needed
]

# Seed questions
questions_data.each do |question_data|
    question = Question.create(question_data)
  
    # Seed choices for each question
    choices_data = [
      { question: 1, body: "高卒か一般大学卒" },
      { question: 1, body: "福祉大学卒か養成施設卒" },
      { question: 2, body: "介護福祉士養成施設卒" },
      { question: 2, body: "福祉系の大学卒か福祉系養成施設卒" },
      { question: 3, body: "実務経験3年（見込みもあり）" },
      { question: 3, body: "福祉系高校卒" },
      # Add more choices as needed
    ]
  
    # Seed choices
    choices_data.each do |choice_data|
      Choice.create(choice_data)
    end
  end
  
  puts "Seed data for questions and choices created successfully."