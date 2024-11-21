require_relative "storage_interface"
require_relative "../students_list_db"

class StorageDBAdapter < StorageInterface
  def initialize(students_list_db)
    raise ArgumentError, "Expected StudentListDB" if !students_list_db.is_a?(StudentsListDB)
    @storage_adapter = students_list_db
  end

  def get_k_n_list(k,n,data_list = nil)
    @storage_adapter.get_k_n_list_in_db(k,n,data_list)
  end

  def get_by_id(id)
    @storage_adapter.get_by_id_in_db(id)
    
  end

  def delete_by_id(id)
    @storage_adapter.delete_by_id_in_db(id)
  end

  def update_by_id(id,student)
    @storage_adapter.update_by_id_in_db(id,student)
  end

  def get_students_count
    @storage_adapter.count_students_in_db
  end

  def add(student)
    @storage_adapter.add_in_db(student)
  end
end
