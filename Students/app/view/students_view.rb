require 'fox16'
require_relative '../controller/students_controller'
include Fox

class StudentsView < FXHorizontalFrame
  
  attr_accessor :current_page

  ROWS_PER_PAGE =  3

  def initialize(parent)
    super(parent,opts: LAYOUT_FILL)
    self.controller = StudentsController.new(self)
    self.filters = {}
    setup_table_area
    filtering_and_butttons_area = FXVerticalFrame.new(self)
    setup_filtering_area(filtering_and_butttons_area)
    setup_control_buttons_area(filtering_and_butttons_area)
    self.current_page = 1
    self.total_pages = 1 
    self.refresh_data
  end

  def refresh_data
    self.current_page = 1
    self.controller.refresh_data
  end

  def set_table_params(column_names, whole_entities_count)
    column_names.each_with_index do |name, index|
        self.table.setColumnText(index, name)
    end
    self.total_pages = (whole_entities_count / ROWS_PER_PAGE.to_f).ceil
    update_page_label
  end

  def set_table_data(data_table)
    clear_table
    index = (self.current_page - 1) * ROWS_PER_PAGE + 1
    (0...data_table.row_count).each do |row|
        self.table.setItemText(row, 0, index.to_s)
        (1...data_table.column_count).each do |col|
            self.table.setItemText(row, col, data_table.get_element(row, col).to_s)
        end
      index += 1
    end
  end

  private

  attr_accessor :table, :total_pages, :page_label, :prev_button, :next_button, :add_button, :update_button, :edit_button, :delete_button, :filters, :selected_rows, :controller
  
  def setup_table_area
    table_area = FXVerticalFrame.new(self,opts: LAYOUT_FILL)
    self.table = FXTable.new(table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(ROWS_PER_PAGE, 4)
    self.table.setColumnWidth(0,30)
    self.table.setColumnWidth(1,150)
    self.table.setColumnWidth(2,200)
    controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(controls, "<<<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    self.page_label = FXLabel.new(controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(controls, ">>>", opts: BUTTON_NORMAL | LAYOUT_RIGHT)
    self.prev_button.connect(SEL_COMMAND) { switch_page(-1) }
    self.next_button.connect(SEL_COMMAND) { switch_page(1) }
    self.table.columnHeader.connect(SEL_COMMAND) do |_, _, pos|
        self.controller.sort_by_column!(pos)
        refresh_data
    end
  end

  def setup_control_buttons_area(parent)
    button_area = FXVerticalFrame.new(parent, opts: PACK_UNIFORM_WIDTH)
    self.add_button = FXButton.new(button_area, "Добавить", opts: BUTTON_NORMAL)
    self.edit_button = FXButton.new(button_area, "Изменить", opts: BUTTON_NORMAL)
    self.delete_button = FXButton.new(button_area, "Удалить", opts: BUTTON_NORMAL)
    self.update_button = FXButton.new(button_area, "Обновить", opts: BUTTON_NORMAL)
    self.add_button.connect(SEL_COMMAND) { on_add }
    self.update_button.connect(SEL_COMMAND) { on_update }
    self.edit_button.connect(SEL_COMMAND) { on_edit }
    self.delete_button.connect(SEL_COMMAND) { on_delete }
    self.table.connect(SEL_SELECTED) { update_button_states }
    self.table.connect(SEL_DESELECTED) { update_button_states }
    update_button_states
  end

  def setup_filtering_area(parent)
    filtering_area = FXVerticalFrame.new(parent, opts: LAYOUT_SIDE_TOP)
    FXLabel.new(filtering_area, "Фильтрация")
    name_text_field = nil
    FXVerticalFrame.new(filtering_area, opts: LAYOUT_FILL_X) do |frame|
        FXLabel.new(frame, "Фамилия и инициалы:")
        name_text_field = FXTextField.new(frame, 20, opts: TEXTFIELD_NORMAL)
    end
    self.filters['name'] = { text_field: name_text_field }
    add_filtering_row(filtering_area, "Гит:")
    add_filtering_row(filtering_area, "Почта:")
    add_filtering_row(filtering_area, "Телефон:")
    add_filtering_row(filtering_area, "Телеграм:")
    FXButton.new(filtering_area, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
        reset_filters
    end
  end