require 'test_helper'

class TypeLetterTest < ActiveSupport::TestCase
  test 'Создание пустого "Тип письма"' do
    typeLetter = TypeLetter.new
    assert_not typeLetter.save, '"Тип письма" не может быть пустым при создании'
  end
  test 'Создание "Тип письма" с пустым наименование' do
    typeLetter = TypeLetter.new
    typeLetter.service_number = 12
    assert_not typeLetter.save, '"Тип письма" не может быть создан с пустым наименованием'
  end
  test 'Создание "Тип письма" с пустым сервисным номером' do
    typeLetter = TypeLetter.new
    typeLetter.name = "Test 1"
    assert_not typeLetter.save, '"Тип письма" не может быть создан с пустым сервисным номером'
  end
  test 'Создание "Тип письма" с заполенным "Базовый" ' do
    typeLetter = TypeLetter.new
    typeLetter.service_number = 12
    typeLetter.name = "Test 1"
    typeLetter.basis = true
    typeLetter.save
    assert_not typeLetter.basis, '"Тип письма" не может быть создан с заполенным "Базовый"'
  end
  test 'Редактировать базового "Тип письма"' do
    typeLetter = TypeLetter.all.first
    typeLetter.service_number = 76
    assert_not typeLetter.save, 'Базовые типы писем закрыты на редактирование любого поля (service_number)'
    typeLetter.name = 76
    assert_not typeLetter.save, 'Базовые типы писем закрыты на редактирование любого поля (name)'
    typeLetter.basis = false
    assert_not typeLetter.save, 'Базовые типы писем закрыты на редактирование любого поля (basis)'
  end
  test 'Нельзя удалить любой базовый "Тип письма"' do
    typeLetter = TypeLetter.all.first
    assert_not typeLetter.destroy, 'Нельзя удалить любую Базовые типы писем'
  end
  test 'Создание и редактирование Тип письма' do
    typeLetter = TypeLetter.new
    typeLetter.service_number = 43
    typeLetter.name = "Test 1"
    assert typeLetter.save, 'Новый "Тип письма" с заполненным именем и сервисным номером'
    typeLetter.service_number = 44
    typeLetter.name = "Test 2"
    assert typeLetter.save, 'Редактируем "Тип письма" с заполненным именем и сервисным номером'
  end
  test 'Создание дублера Тип письма' do
    typeLetter1 = TypeLetter.new
    typeLetter1.service_number = 43
    typeLetter1.name = "Test 1"
    typeLetter1.save
    typeLetter2 = TypeLetter.new
    typeLetter2.service_number = 43
    typeLetter2.name = "Test 2"
    assert_not typeLetter2.save, 'Создание дублируещей записм "Тип письма" (service_number)'
    typeLetter3 = TypeLetter.new
    typeLetter3.service_number = 44
    typeLetter3.name = "Test 1"
    assert_not typeLetter3.save, 'Создание дублируещей записм "Тип письма" (name)'
  end
  test 'Удаление не базового Типа письма' do
    typeLetter = TypeLetter.new
    typeLetter.service_number = 12
    typeLetter.name = "Test 1"
    typeLetter.save
    assert typeLetter.destroy, 'Удаление не базового "Тип письма"'
  end
end
