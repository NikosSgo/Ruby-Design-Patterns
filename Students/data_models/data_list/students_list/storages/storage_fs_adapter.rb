require_relative "storage_interface"
require_relative "../students_list_fs"

class StorageFSAdapter < StorageInterface
  def initialize(students_list_fs)
    raise ArgumentError, "Expected StudentListFS" if !students_list_fs.is_a?(StudentsListFS)
    @adapter = students_list_fs
  end

  def get_k_n_list(k,n,data_list = nil,filter: nil)
    @adapter.get_k_n_list_in_file(k,n,data_list,filter: filter)
  end

  def get_by_id(id)
    @adapter.get_by_id_in_file(id)
  end

  def delete_by_id(id)
    @adapter.delete_by_id_in_file(id)
  end

  def update_by_id(id,student)
    @adapter.update_by_id_in_file(id,student)
  end

  def get_students_count(filter = nil)
    @adapter.count_students_in_file(filter)
  end

  def add(student)
    @adapter.add_in_file(student)
  end
end
