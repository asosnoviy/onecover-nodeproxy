#Использовать 1connector

АдрессДебагера = ПолучитьПеременнуюСреды("PROXY_URL");
Урл = "/e1crdbg/rdbg?cmd=setMeasureMode";

Если АргументыКоманднойСтроки.Количество() > 0 Тогда 
	Если АргументыКоманднойСтроки[0] = "start" Тогда
		ПутьКШаблону = "./fixtures/bodySamples/debugon.xml";
	ИначеЕсли АргументыКоманднойСтроки[0] = "attach" Тогда	
		ПутьКШаблону = "./fixtures/bodySamples/autoattach.xml";
		Урл = "/e1crdbg/rdbg?cmd=setAutoAttachSettings";
	Иначе
		ПутьКШаблону = "./fixtures/bodySamples/debugoff.xml";	
	КонецЕсли;	
Иначе
	ПутьКШаблону = "./fixtures/bodySamples/debugoff.xml";	
КонецЕсли;	

// http://localhost:1550/e1crdbg/rdbg?cmd=setAutoAttachSettings

Чтение = Новый ЧтениеТекста(ПутьКШаблону);
Тело = Чтение.Прочитать();
Чтение.Закрыть();

Заголовки = Новый Соответствие();
Заголовки.Вставить("accept-charset", "utf-8");
Заголовки.Вставить("content-type", "application/xml");


Результат = КоннекторHTTP.Post(
	АдрессДебагера + Урл,
	Тело,
	, 
	Новый Структура("Заголовки", Заголовки)
	);
