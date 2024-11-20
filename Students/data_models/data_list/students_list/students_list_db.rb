require_relative "../student_short/data_list_student_short"
require_relative "../../../student_short/student_short"
require_relative "file_strategies/file_strategies"
require_relative "../../../db/mysql/db_connection"

class StudentsListDB
  def initialize
    @client = DBConnection.client
  end

  ########################################################

  def get_k_n_students(k, n, existing_data_list = nil)
    offset = (k - 1) * n
    result = @client.query("SELECT * FROM students LIMIT #{n} OFFSET #{offset}").to_a
    short_list = result.map { |student| StudentShort.new(student) }
    existing_data_list&.update(short_list) || DataListStudentShort.new(short_list)
  end
  
  def get_student_by_id(id)
    result = @client.query("SELECT * FROM students WHERE id = #{id}").first
    result ? StudentShort.new(result) : nil
  end

  def update_by_id(id, student)
    query = <<~SQL
      UPDATE students
      SET surname_and_initals = '#{student.surname_and_initals}',
          git = '#{updated_student.patronymic}',
          contact = '#{updated_student.email}'
      WHERE id = #{id}
    SQL
    @client.query(query)
  end

  def delete_by_id(id)
    @client.query("DELETE FROM students WHERE id = #{id}")
  end

  def get_students_count
    result = @client.query('SELECT COUNT(*) AS count FROM students').first
    result['count']
  end

  def add(student)
    query = <<~SQL
      INSERT INTO students (surname_and_initials, git, contact)
      VALUES ('#{student.surname_and_initials}', '#{student.git}', '#{student.contact}')
    SQL
    @client.query(query)
    student.id = @client.last_id
    student
  end

end
