questions = [
  {
    text: "What is the capital of France?",
    answer: "Paris"
  },
  {
    text: "What is the largest planet in our solar system?",
    answer: "Jupiter"
  },
  {
    text: "Who wrote 'To Kill a Mockingbird'?",
    answer: "Harper Lee"
  },
  {
    text: "What is the chemical symbol for gold?",
    answer: "Au"
  },
  {
    text: "In what year did the Titanic sink?",
    answer: "1912"
  },
  {
    text: "What is the hardest natural substance on Earth?",
    answer: "Diamond"
  },
  {
    text: "Who painted the Mona Lisa?",
    answer: "Leonardo da Vinci"
  },
  {
    text: "What is the smallest country in the world?",
    answer: "Vatican City"
  },
  {
    text: "What is the currency of Japan?",
    answer: "Yen"
  },
  {
    text: "Who was the first person to walk on the moon?",
    answer: "Neil Armstrong"
  },
]

questions.each do |question|
  Question.create(question)
end
