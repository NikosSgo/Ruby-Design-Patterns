class BaseFilter
  def apply(data)
    raise NotImplementedError, 'Метод apply должен быть реализован в подклассе'
  end
end
