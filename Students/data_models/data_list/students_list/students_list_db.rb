require_relative "../../../db/mysql/db_connection"
require_relative "../../../student_short/student_short"

class StudentsListDB
  def initialize
    @client = DBConnection.instance
  end

  ########################################################
  
  def get_k_n_list_in_db(k, n, existing_data_list = nil)
    offset = (k - 1) * n
    result = @client.query("SELECT * FROM students LIMIT #{n} OFFSET #{offset}").to_a
    short_list = result.map { |student_hash| StudentShort.new(**student_hash.transform_keys(&:to_sym)) }
    existing_data_list&.update(short_list) || DataListStudentShort.new(short_list)
  end

  def get_by_id_in_db(id)
    result = @client.query("SELECT * FROM students WHERE id = #{id}").first
    student = nil
    result ? student = StudentShort.new(**result.transform_keys(&:to_sym)) : student
    student
  end
  
  def delete_by_id_in_db(id)
    @client.query("DELETE FROM students WHERE id = #{id}")
  end 
  
  def update_by_id_in_db(id, updated_student)
    query = <<~SQL
      UPDATE students
      SET surname_and_initials = '#{updated_student.surname_and_initials}',
      git = '#{updated_student.git}',
      contact = '#{updated_student.contact}'
      WHERE id = #{id}
    SQL
    @client.query(query)
  end

  def count_students_in_db
    result = @client.query('SELECT COUNT(*) AS count FROM students').first
    result['count']
  end

  def add_in_db(student)
    query = <<~SQL
      INSERT INTO students (surname_and_initials, git, contact)
      VALUES ('#{student.surname_and_initials}', '#{student.git}', '#{student.contact}')
    SQL
    @client.query(query)
    student
  end

end
