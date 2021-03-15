&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	КопироватьДанныеФормы(Параметры.Объект, Объект);

	СтрокаУникальныйИдентификатор = Параметры.Значение;

КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)

	Если ЗначениеЗаполнено(СтрокаУникальныйИдентификатор) Тогда
		Значение = Новый УникальныйИдентификатор(СтрокаУникальныйИдентификатор);
	Иначе
		Значение = Новый УникальныйИдентификатор;
	КонецЕсли;

	ВозвращаемоеЗначение = Новый Структура("Значение", Значение);

	Закрыть(ВозвращаемоеЗначение);

КонецПроцедуры

&НаКлиенте
Процедура УникальныйИдентификаторОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных,
	СтандартнаяОбработка)
	//СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Текст) Тогда
		Попытка
			ъ = Новый УникальныйИдентификатор(Текст);
		Исключение
			ВызватьИсключение "Некорректный уникальный идентификатор!";
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УникальныйИдентификаторПриИзменении(Элемент)
	Если ЗначениеЗаполнено(Ссылка) И Строка(Ссылка.УникальныйИдентификатор()) <> СтрокаУникальныйИдентификатор Тогда
		Ссылка = Неопределено;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	Если Ссылка <> Неопределено Тогда
		СтрокаУникальныйИдентификатор = Ссылка.УникальныйИдентификатор();
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, КлассСсылки, Менеджер, СтрокаУникальныйИдентификатор)

	Ссылка = Менеджер.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаУникальныйИдентификатор));
	ИмяМетаданных = Ссылка.Метаданные().Имя;
	ТаблицаБазы = КлассСсылки + "." + ИмяМетаданных;
	ИмяПараметра = КлассСсылки + ИмяМетаданных;
	;
	
	маЗапросПоиска.Добавить(
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Таблица.Ссылка КАК Ссылка
		|ИЗ
		|	" + ТаблицаБазы + " КАК Таблица
							   |ГДЕ
							   |	Таблица.Ссылка = &" + ИмяПараметра);
	ЗапросПоиска.УстановитьПараметр(ИмяПараметра, Ссылка);

КонецПроцедуры

&НаСервереБезКонтекста
Функция КомандаНайтиНаСервере(СтрокаУникальныйИдентификатор)

	ЗапросПоиска = Новый Запрос;
	маЗапросПоиска = Новый Массив;

	Для Каждого Менеджер Из Справочники Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "Справочник", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из Документы Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "Документ", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из ПланыСчетов Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "ПланСчетов", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из ПланыВидовХарактеристик Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "ПланВидовХарактеристик", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из ПланыВидовРасчета Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "ПланВидовРасчета", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из БизнесПроцессы Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "БизнесПроцесс", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из Задачи Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "Задача", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	Для Каждого Менеджер Из ПланыОбмена Цикл
		ДобавитьЗапрос(маЗапросПоиска, ЗапросПоиска, "ПланОбмена", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;

	ТекстЗапроса = СтрСоединить(маЗапросПоиска, "
												|ОБЪЕДИНИТЬ ВСЕ
												|");

	ЗапросПоиска.Текст = ТекстЗапроса;
	Выборка = ЗапросПоиска.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

&НаКлиенте
Процедура КомандаНайти(Команда)
	Ссылка = КомандаНайтиНаСервере(СтрокаУникальныйИдентификатор);
КонецПроцедуры