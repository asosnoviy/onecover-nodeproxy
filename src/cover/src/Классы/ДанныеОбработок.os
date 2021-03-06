#Использовать xml-parser

Перем ПутьКИсходникам;
Перем ДанныеОбъектов;
Перем ТипыМодулей;

Процедура ПриСозданииОбъекта(ВхПутьКИсходникам) Экспорт 

	ТипыМодулей = Новый Соответствие;
	ИнициализацияТипыМодулей();
	ДанныеОбъектов = Новый Соответствие;
	ПутьКИсходникам = ВхПутьКИсходникам;

КонецПроцедуры	


Функция ПутьКФайлу(ПутьКВнешнейОбработке, objectID, propertyID) Экспорт

	Путь = ДанныеОбъектов.Получить(ПутьКВнешнейОбработке + "_" + objectID);

	Если Путь = Неопределено Тогда
		ИнициализацияКаталогаСОбработками(ПутьКВнешнейОбработке);
	КонецЕсли;	

	Путь = ДанныеОбъектов.Получить(ПутьКВнешнейОбработке + "_" + objectID);

	Возврат Путь;

КонецФункции	

Процедура ИнициализацияКаталогаСОбработками(ПутьКВнешнейОбработке)

	ФайлОбработки = Новый Файл(ПутьКВнешнейОбработке);
	КаталогОбработок = ФайлОбработки.Пути;

	ФайлыXML = НайтиФайлы(КаталогОбработок, "*.xml");

	Для Каждого ФайлXML Из ФайлыXML Цикл
		ИнициализироватьДанныеВнешнейОБработки(ФайлXML);
	КонецЦикла;	

КонецПроцедуры	

Функция ОпределитьМодульПоId(ИмяФайла, IdОбъекта) Экспорт

	ДанныеМодуля = ИмяФайла + "_" + IdОбъекта;

	Возврат ДанныеМодуля;

КонецФункции	

Функция ТипМодуля(idТипа)

	ТипМодуля = ТипыМодулей.Получить(idТипа);
	Если ТипМодуля = Неопределено Тогда
		ТипМодуля = idТипа;
	КонецЕсли;	

	Возврат ТипМодуля;

КонецФункции	

Процедура ИнициализироватьДанныеВнешнейОБработки(ФайлXML, ПутьКФайлуОбработки)

	ПутьКФайлуОбработки = СтрЗаменить(ПутьКВнешнейОбработке, ".epf", "");
	ПутьКФайлуОбработкиXMl = ФайлXML.ПолноеИмя;
	
	ПроцессорXML = Новый СериализацияДанныхXML();
	РезультатЧтения = ПроцессорXML.ПрочитатьИзФайла(ПутьКФайлуОбработкиXMl);

	ПутьКМодулю = СтрЗаменить(ПутьКФайлуОбработки, ПутьКИсходникам, "") 
		+ ПолучитьРазделительПути() 
		+ "Ext" 
		+ ПолучитьРазделительПути() 
		+ "ObjectModule.bsl";
		
	objectID = РезультатЧтения.Получить("MetaDataObject")["_Элементы"]
		["ExternalDataProcessor"]["_Атрибуты"]["uuid"];

	КлючМодуля = ПутьКВнешнейОбработке + "_" + objectID;
	ДанныеОбъектов.Вставить(КлючМодуля, ПутьКМодулю);

	Формы = ИменаФормОбработки(РезультатЧтения);

	Для Каждого ИмяФормы Из Формы Цикл
		ИнициализироватьДанныеФормы(ПутьКВнешнейОбработке, ИмяФормы);
	КонецЦикла;	

КонецПроцедуры

Процедура ИнициализироватьДанныеФормы(ПутьКВнешнейОбработке, ИмяФормы)

	ПутьКФайлуОбработки = СтрЗаменить(ПутьКВнешнейОбработке, ".epf", "");

	ОтносительныйПуть = СтрЗаменить(ПутьКФайлуОбработки, ПутьКИсходникам, "");

	ПутьКXMLФормы = ПутьКФайлуОбработки 
	+ ПолучитьРазделительПути()
	+ "Forms"
	+ ПолучитьРазделительПути()
	+ ИмяФормы
	+ ".xml"
	;
	// ВнешняяОбработка1\Forms\ФормаДва\Ext\Form
	ПроцессорXML = Новый СериализацияДанныхXML();
	РезультатЧтения = ПроцессорXML.ПрочитатьИзФайла(ПутьКXMLФормы);

	ПутьКМодулю = СтрЗаменить(ПутьКФайлуОбработки, ПутьКИсходникам, "") 
		+ ПолучитьРазделительПути() 
		+ "Forms" 
		+ ПолучитьРазделительПути() 
		+ ИмяФормы
		+ ПолучитьРазделительПути()
		+ "Ext"
		+ ПолучитьРазделительПути()
		+ "Form"
		+ ПолучитьРазделительПути()
		+ "Module.bsl";
		
	objectID =  РезультатЧтения.Получить("MetaDataObject")["_Элементы"]
		["Form"]["_Атрибуты"]["uuid"];

	КлючМодуля = ПутьКВнешнейОбработке + "_" + objectID;
	ДанныеОбъектов.Вставить(КлючМодуля, ПутьКМодулю);

КонецПроцедуры	

Функция ИменаФормОбработки(РезультатЧтения)

	ИменаФорм = Новый Массив();

	ChildObjects = РезультатЧтения
		.Получить("MetaDataObject")
		["_Элементы"]
		["ExternalDataProcessor"]
		["_Элементы"]
		["ChildObjects"];

	Для Каждого Object Из ChildObjects Цикл
	
		Если ТипЗнч(Object) = Тип("КлючИЗначение") Тогда
			Если Object.Ключ = "Form" Тогда
				ИменаФорм.Добавить(Object.Значение);
			КонецЕсли;	
		Иначе
			ИмяФормы = Object.Получить("Form");	
			Если ЗначениеЗаполнено(ИмяФормы) Тогда
				ИменаФорм.Добавить(ИмяФормы);
			КонецЕсли;		
		КонецЕсли;	

		
	КонецЦикла;	


	Возврат ИменаФорм;

КонецФункции	


Процедура ИнициализацияТипыМодулей()
	ТипыМодулей = ПутиФайловКонфигурации.ТипыМодулей();
КонецПроцедуры	