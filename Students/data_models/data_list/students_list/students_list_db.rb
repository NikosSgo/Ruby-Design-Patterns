require_relative "../../../db/mysql/db_connection"
require_relative "../../../student_short/student_short"

class StudentsListDB
  def initialize
    @client = DBConnection.instance
  end

  ########################################################

  def get_by_id_in_db(id)
    student_hash = @client.query("SELECT * FROM students WHERE id = #{id}").first
    student_hash ? StudentShort.new(**student_hash.transform_keys(&:to_sym)) : nil
  end
  
  def delete_by_id_in_db(id)
    @client.query("DELETE FROM students WHERE id = #{id}")
  end 
  
  def update_by_id_in_db(id, updated_student)
    git = null_field_to_sql(updated_student.git)
    contact = null_field_to_sql(updated_student.contact)
    query = <<~SQL
      UPDATE students
      SET surname_and_initials = '#{updated_student.surname_and_initials}',
          git = #{git},
          contact = #{contact}
      WHERE id = #{id}
    SQL
    @client.query(query)
  end

  def count_students_in_db
    result = @client.query('SELECT COUNT(*) AS count FROM students').first
    result['count']
  end

  def add_in_db(student)
    git = null_field_to_sql(student.git)
    contact = null_field_to_sql(student.contact)
    query = <<~SQL
      INSERT INTO students (surname_and_initials, git, contact)
      VALUES ('#{student.surname_and_initials}', #{git}, #{contact})
    SQL
    @client.query(query)
    student
  end

  def get_k_n_list_in_db(k, n, other_data_list = nil, filter: nil)
    offset = (k - 1) * n
    query = "SELECT * FROM students"

    if filter
      where_clauses = filter.apply_db
      query += " WHERE #{where_clauses}" unless where_clauses.empty?
    end

    query += " LIMIT #{n} OFFSET #{offset}"

    result = @client.query(query).to_a

    short_list = result.map do |student_hash| 
      student_hash = student_hash.transform_keys(&:to_sym)
      StudentShort.new(**student_hash)
    end
    other_data_list&.update(short_list) || DataListStudentShort.new(short_list)
  end

  def count_students_in_db(filter = nil)
    query = "SELECT COUNT(*) AS count FROM students"

    if filter
      where_clauses = filter.apply_db
      query += " WHERE #{where_clauses}" unless where_clauses.empty?
    end

    result = @client.query(query).first
    result['count']
  end

  private

  def null_field_to_sql(field)
    field.nil? ? "NULL" : "'"+ field + "'"
  end

end