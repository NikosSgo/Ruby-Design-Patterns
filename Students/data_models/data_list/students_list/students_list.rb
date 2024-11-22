require_relative "storages/storage_interface"

class StudentsList

  attr_accessor :storage

  def initialize(storage)
    raise ArgumentError, "Expected child of StorageInterface" if !storage.is_a?(StorageInterface)
    @storage = storage
  end


  def get_k_n_list(k,n,data_list = nil,filter: nil)
    @storage.get_k_n_list(k,n,data_list,filter: filter)
  end

  def get_by_id(id)
    @storage.get_by_id(id)
  end

  def delete_by_id(id)
    @storage.delete_by_id(id)
  end

  def update_by_id(id,student)
    @storage.update_by_id(id,student)
  end

  def get_students_count(filter = nil)
    @storage.get_students_count(filter)
  end

  def add(student)
    @storage.add(student)
  end

end
