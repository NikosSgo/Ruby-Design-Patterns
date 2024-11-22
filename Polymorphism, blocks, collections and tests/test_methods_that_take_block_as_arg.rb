require_relative 'methods_that_take_block_as_arg'

RSpec.describe MyArray do
  let(:array) { MyArray.new([1, 2, 3, 4, 5]) }

  describe '#my_cycle' do
    it 'циклично выполняет переданный блок указанное количество раз' do
      result = []
      array.my_cycle(2) { |item| result << item }
      expect(result).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4, 5])
    end

    it 'циклично выполняет блок бесконечно, если rep равен nil (ограничим проверку)' do
      result = []
      array.my_cycle { |item| result << item; break if result.size >= 10 }
      expect(result).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4, 5])
    end
  end

  describe '#my_inject' do
    it 'агрегирует значения массива с начальным значением' do
      sum = array.my_inject(10) { |acc, elem| acc + elem }
      expect(sum).to eq(25)
    end

    it 'агрегирует значения массива без начального значения' do
      sum = array.my_inject { |acc, elem| acc + elem }
      expect(sum).to eq(15)
    end
  end

  describe '#my_reject' do
    it 'отбрасывает элементы, соответствующие условию блока' do
      result = array.my_reject { |item| item.even? }
      expect(result).to eq([1, 3, 5])
    end

    it 'возвращает пустой массив, если все элементы соответствуют условию блока' do
      result = array.my_reject { |item| item > 0 }
      expect(result).to eq([])
    end
  end

  describe '#my_max_by' do
    it 'возвращает элемент с максимальным значением в блоке' do
      result = array.my_max_by { |item| item * -1 }
      expect(result).to eq(1)
    end

    it 'возвращает nil, если массив пуст' do
      empty_array = MyArray.new([])
      result = empty_array.my_max_by { |item| item }
      expect(result).to be_nil
    end
  end

  describe '#my_each_slice' do
    it 'разделяет массив на части и передает их в блок' do
      result = []
      array.my_each_slice(2) { |slice| result << slice }
      expect(result).to eq([[1, 2], [3, 4], [5]])
    end

    it 'работает корректно, если длина массива кратна размеру части' do
      new_array = MyArray.new([1, 2, 3, 4])
      result = []
      new_array.my_each_slice(2) { |slice| result << slice }
      expect(result).to eq([[1, 2], [3, 4]])
    end
  end

  describe '#my_sort_by' do
    it 'сортирует массив по результату выполнения блока' do
      result = array.my_sort_by { |item| -item }
      expect(result).to eq([5, 4, 3, 2, 1])
    end

    it 'возвращает пустой массив, если массив пуст' do
      empty_array = MyArray.new([])
      result = empty_array.my_sort_by { |item| item }
      expect(result).to eq([])
    end
  end
end
