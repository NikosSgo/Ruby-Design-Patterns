class StorageInterface

  def get_k_n_list(k,n,data_list = nil, filter: nil)
    raise NotImplementedError, "Метод get_k_n_list не реаилизован."
  end

  def get_by_id(id)
    raise NotImplementedError, "Метод get_by_id не реаилизован."
  end

  def delete_by_id(id)
    raise NotImplementedError, "Метод delete_by_id не реаилизован."
  end

  def update_by_id(id,student)
    raise NotImplementedError, "Метод update_by_id не реаилизован."
  end

  def count_students(filter = nil)
    raise NotImplementedError, "Метод count_students не реаилизован."
  end

  def add(student)
    raise NotImplementedError, "Метод add не реаилизован."
  end

end
