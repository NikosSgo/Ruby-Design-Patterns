require_relative "view/students_app"

app = FXApp.new("StudentsApp", "FoxTest")
StudentsApp.new(app)
app.create
app.run