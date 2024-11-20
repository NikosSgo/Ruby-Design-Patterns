require_relative "../data_list"

class DataListStudentShort < DataList

  def get_names
    ["№","surname_and_initials","git","contact"]
  end

  private
  def data_row(id,student)
    [id,student.surname_and_initials,student.git,student.contact]
  end

end