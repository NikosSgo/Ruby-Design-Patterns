class BaseFilter

  protected
  
  def apply(data)
    raise NotImplementedError, 'Метод apply должен быть реализован в подклассе'
  end

  def apply_db
    raise NotImplementedError, 'Метод apply_db должен быть реализован в подклассе'
  end
end
