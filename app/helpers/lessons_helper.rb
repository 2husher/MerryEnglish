module LessonsHelper
  def first_lesson?(category, lesson_num)
    @category = Category.find(category.id)
    min_num   = @category.lessons.minimum(:number)
    return true if lesson_num <= min_num
    return false
  end

  def last_lesson?(category, lesson_num)
    @category = Category.find(category.id)
    max_num   = @category.lessons.maximum("number")
    return true if lesson_num >= max_num
    return false
  end
end
