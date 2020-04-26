#Область ПрограммныйИнтерфейс

Функция ПолучитьТекстКомпонентыShowodwn() Экспорт
	ДвоичныеДанные=ПолучитьОбщийМакет("РМ_showdown");

	ИмяВременногоФайла=ПолучитьИмяВременногоФайла("js");
	ДвоичныеДанные.Записать(ИмяВременногоФайла);

	Текст=Новый ТекстовыйДокумент;
	Текст.Прочитать(ИмяВременногоФайла);

	БиблиотекаТекст=Текст.ПолучитьТекст();

	Попытка
		УдалитьФайлы(ИмяВременногоФайла);
	Исключение
	КонецПопытки;

	Возврат БиблиотекаТекст;
КонецФункции

Функция ПолучитьТекстКомпонентыHighligthjs() Экспорт
	ДвоичныеДанные=ПолучитьОбщийМакет("РМ_highligthjs");

	ИмяВременногоФайла=ПолучитьИмяВременногоФайла("js");
	ДвоичныеДанные.Записать(ИмяВременногоФайла);

	Текст=Новый ТекстовыйДокумент;
	Текст.Прочитать(ИмяВременногоФайла);

	БиблиотекаТекст=Текст.ПолучитьТекст();

	Попытка
		УдалитьФайлы(ИмяВременногоФайла);
	Исключение
	КонецПопытки;

	Возврат БиблиотекаТекст;
КонецФункции

Функция СформироватьТекстHTMLДляТекстаMarkdown(ВариантПодсветкиСинтаксиса) Экспорт
	БиблиотекаТекст=ПолучитьТекстКомпонентыShowodwn();
	ТекстРазукрашивателя=ПолучитьТекстКомпонентыHighligthjs();
	СтильПодсветкиСинтаксиса=ТекстСтиляПодсветкиСинтаксиса(ВариантПодсветкиСинтаксиса);

	СтильCSS= 
	"
	|h2, .wiki h1 {font-size: 20px;}
	|h3, .wiki h2 {font-size: 16px;}
	|h4, .wiki h3 {font-size: 13px;}
	|
	|
	|/***** Wiki *****/
	|div.wiki table {
	|  border-collapse: collapse;
	|  margin-bottom: 1em;
	|}
	|
	|div.wiki table, div.wiki td, div.wiki th {
	|  border: 1px solid #bbb;
	|  padding: 4px;
	|}
	|
	|div.wiki th{
	|	background-color: #EEEEEE;
	|}
	|
	|div.wiki .wiki-class-noborder, div.wiki .wiki-class-noborder td, div.wiki .wiki-class-noborder th {border:0;}
	|
	|div.wiki .external {
	|  background-position: 0% 60%;
	|  background-repeat: no-repeat;
	|  padding-left: 12px;
	|}
	|
	|div.wiki a {word-wrap: break-word;}
	|div.wiki a.new {color: #b73535;}
	|
	|div.wiki ul, div.wiki ol {margin-bottom:1em;}
	|div.wiki li>ul, div.wiki li>ol {margin-bottom: 0;}
	|
	|div.wiki pre {
	|  margin: 1em 1em 1em 1.6em;
	|  padding: 8px;
//	|  background-color: #fafafa;
	|  border: 1px solid #e2e2e2;
	|  border-radius: 3px;
	|  width:auto;
	|  overflow-x: auto;
	|  overflow-y: hidden;
	|}
	|
	|div.wiki ul.toc {
	|  background-color: #ffffdd;
	|  border: 1px solid #e4e4e4;
	|  padding: 4px;
	|  line-height: 1.2em;
	|  margin-bottom: 12px;
	|  margin-right: 12px;
	|  margin-left: 0;
	|  display: table
	|}
	|* html div.wiki ul.toc { width: 50%; } /* IE6 doesn't autosize div */
	|
	|div.wiki ul.toc.right { float: right; margin-left: 12px; margin-right: 0; width: auto; }
	|div.wiki ul.toc.left  { float: left; margin-right: 12px; margin-left: 0; width: auto; }
	|div.wiki ul.toc ul { margin: 0; padding: 0; }
	|div.wiki ul.toc li {list-style-type:none; margin: 0; font-size:12px;}
	|div.wiki ul.toc>li:first-child {margin-bottom: .5em; color: #777;}
	|div.wiki ul.toc li li {margin-left: 1.5em; font-size:10px;}
	|div.wiki ul.toc a {
	|  font-size: 0.9em;
	|  font-weight: normal;
	|  text-decoration: none;
	|  color: #606060;
	|}
	|div.wiki ul.toc a:hover { color: #c61a1a; text-decoration: underline;}
	|
	|a.wiki-anchor { display: none; margin-left: 6px; text-decoration: none; }
	|a.wiki-anchor:hover { color: #aaa !important; text-decoration: none; }
	|h1:hover a.wiki-anchor, h2:hover a.wiki-anchor, h3:hover a.wiki-anchor { display: inline; color: #ddd; }
	|
	|div.wiki img {vertical-align:middle; max-width:100%;}
	|blockquote { font-style: italic; border-left: 3px solid #e0e0e0; padding-left: 0.6em; margin-left: 0;}
	|blockquote blockquote { margin-left: 0;}
	|
	|" + СтильПодсветкиСинтаксиса + "
									|";
	ТекстHTML= 
	"<html>
	|<head>
	|	 <script>
	|" + ТекстРазукрашивателя + "
	|	</script>
	|    <script>
	|" + БиблиотекаТекст + "
	|	</script>
	|    <script>
	|		 
	|        var markdownTexts={};
	|		 var converter = new showdown.Converter();
	|	     converter.setFlavor('github');
	|
	|	     function clearTexts(){
	|            markdownTexts={};
	|        }
	|
	|        function addText(key, text){
	|            markdownTexts[key]=text;
	|        }
	|        function deleteText(key){
	|            delete markdownTexts[key];
	|        }
	|	     function convertOneText(key,text){
	|           
	|			 var newdiv = document.createElement('div');
	|            newdiv.className = 'wiki';
	|            newdiv.id = key;
	|
	|           newdiv.innerHTML = converter.makeHtml(text);
	|
	|           return newdiv;
	|      	 }
	|        
	|        function markdownConvert(){
	|            var container=document.getElementById('wiki-container');
	|            container.innerHTML='';
	|
	|            for (var key in markdownTexts) {
	|                if (markdownTexts.hasOwnProperty(key)) {
	|                    var markText = markdownTexts[key];
	|                    
	|                	 var newdiv=convertOneText(key,markText);
	|						
	|                    container.appendChild(newdiv);
	|                }
	|            }
	|  			var elems= document.getElementsByTagName('code');
	|			
	|			 for(var i = 0; i < elems.length; i++) {
	|				hljs.highlightBlock(elems[i]);
	|			}			
	|
	|        }
	|
	|    </script>
	|    <style>
	|    	html { 
	|			word-break: break-all;
	|    	}
	|		" + СтильCSS + "
	|    </style>	
	|	 
	|</head>
	|    
	|<body>
	|    <div id=""wiki-container""></div>
	|    <button id=""interactionButton"" style=""display: none"">Кнопка взаимодействия</button>
	|</body>
	|
	|    
	|</html>
	|";

	Возврат ТекстHTML;
КонецФункции

Функция ВариантыПодсветкиСинтаксиса() Экспорт
	ТабДокумент=ПолучитьОбщийМакет("РМ_ВариантыПодсветки");

	МассивВариантов=Новый Массив;
	Для НомерСтроки = 2 По ТабДокумент.ВысотаТаблицы Цикл
		Вариант=ТабДокумент.Область(НомерСтроки, 1, НомерСтроки, 1).Текст;
		Если Не ЗначениеЗаполнено(Вариант) Тогда
			Прервать;
		КонецЕсли;

		МассивВариантов.Добавить(Вариант);
	КонецЦикла;

	Возврат МассивВариантов;

КонецФункции

Функция ТекстСтиляПодсветкиСинтаксиса(ВариантПодсветки) Экспорт
	СоответствиеСтилей=Новый Соответствие;

	ТабДокумент=ПолучитьОбщийМакет("РМ_ВариантыПодсветки");

	Для НомерСтроки = 2 По ТабДокумент.ВысотаТаблицы Цикл
		Вариант=ТабДокумент.Область(НомерСтроки, 1, НомерСтроки, 1).Текст;
		Если Не ЗначениеЗаполнено(Вариант) Тогда
			Прервать;
		КонецЕсли;
		Стиль=ТабДокумент.Область(НомерСтроки, 2, НомерСтроки, 2).Текст;

		СоответствиеСтилей.Вставить(Вариант, Стиль);
	КонецЦикла;
	Стиль=СоответствиеСтилей[ВариантПодсветки];
	Если Стиль = Неопределено Тогда
		Стиль=СоответствиеСтилей["vs"];
	КонецЕсли;

	Возврат Стиль;
КонецФункции

Процедура ВставитьПолеРедактированияТекстаНаФорму(Форма, ГруппаЭлементовТекста, ПутьКДанным,
	ВариантПодсветкиСинтаксиса = "ones", ТолькоПросмотр=Ложь) Экспорт

	ОписаниеТиповСтрока = Новый ОписаниеТипов("Строка");

	ПутьКДаннымБезЛишнего=РМ_MarkdownКлиентСервер.ПолучитьПутьКДаннымБезЛишнего(ПутьКДанным);
	ПравильныйПутьКДанным=ПутьКДанным;
	
	//В маркдауне нужно сделать две закладки
	//редактирование и просмотр
	
	//1. Сначала добавляем страницы
	ИмяЭлементаСтраницРедактирования=РМ_MarkdownКлиентСервер.ПолучитьИмяЭлементаПанелиСтраницРедактированияКомментария(ПутьКДанным);
	
	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=ИмяЭлементаСтраницРедактирования;
	ОписаниеЭлемента.РодительЭлемента=ГруппаЭлементовТекста;

	ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.Страницы);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("ОтображениеСтраниц", ОтображениеСтраницФормы.ЗакладкиСнизу);
	ОписаниеЭлемента.Параметры.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);

	ОписаниеЭлемента.Действия.Вставить("ПриСменеСтраницы", "РМ_Подключаемый_ПриСменеСтраницыПоляКомментария");

	СтраницыРедактирования=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	
	Если Не ТолькоПросмотр Тогда
	//2. Страница редактирвания
		ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
		ОписаниеЭлемента.Имя=РМ_MarkdownКлиентСервер.ПолучитьИмяСтраницыРедактированияКомментария(ПутьКДанным);
		ОписаниеЭлемента.РодительЭлемента=СтраницыРедактирования;
		ОписаниеЭлемента.Заголовок="Редатирование";

		ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
		ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.Страница);
		ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
		ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);

		СтраницаРедактирования=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	КонецЕсли;
	
	//3. Страница просмотра
	ИмяЭлементаСтраницыПросмотра=РМ_MarkdownКлиентСервер.ПолучитьИмяСтраницыПросмотраКомментария(ПутьКДанным);
	
	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=ИмяЭлементаСтраницыПросмотра;
	ОписаниеЭлемента.РодительЭлемента=СтраницыРедактирования;
	ОписаниеЭлемента.Заголовок="Просмотр";

	ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.Страница);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);

	СтраницаПросмотра=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);

	Если Не ТолькоПросмотр Тогда
	//4.1. Командная панель редактирования
		ДобавитьКнопкиВКоманднуюПанельРедактированияПоляMarkdown(Форма, СтраницаРедактирования, ПутьКДаннымБезЛишнего);
	
	//4.2. текст редактирования
		ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
		ОписаниеЭлемента.Имя=РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы() + ПутьКДаннымБезЛишнего;
		ОписаниеЭлемента.ПутьКДанным=ПравильныйПутьКДанным;
		ОписаниеЭлемента.РодительЭлемента=СтраницаРедактирования;

		ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
		ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);
		ОписаниеЭлемента.Параметры.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);
		ОписаниеЭлемента.Параметры.Вставить("МногострочныйРежим", Истина);
		ОписаниеЭлемента.Параметры.Вставить("РасширенноеРедактирование", Истина);

		ТекстРедактирования=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	КонецЕсли;
	
	//5.1. Реквизит поля просмотра
	ПутьКПолюПросмотра=РМ_MarkdownКлиентСервер.ПолучитьИмяЭлементаПросмотраКомментария(ПутьКДанным);

	НовыйРеквизит=Новый РеквизитФормы(ПутьКПолюПросмотра, ОписаниеТиповСтрока);

	МассивДобавляемыхРеквизитов=Новый Массив;
	МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
	
	// 5.1.а Реквизит таблицы присоединенных файлов
	ПутьКТаблицеПрисоединенныхФайлов=РМ_MarkdownКлиентСервер.ИмяТаблицыПрисоединенныхФайлов(ПутьКДаннымБезЛишнего);
	Если Форма.Элементы.Найти(ПутьКТаблицеПрисоединенныхФайлов) = Неопределено Тогда

		НовыйРеквизит = Новый РеквизитФормы(ПутьКТаблицеПрисоединенныхФайлов, Новый ОписаниеТипов("ТаблицаЗначений"));
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
		
		НовыйРеквизит = Новый РеквизитФормы("Ссылка", Справочники.ТипВсеСсылки(), ПутьКТаблицеПрисоединенныхФайлов);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);

		НовыйРеквизит = Новый РеквизитФормы("ПутьКФайлу", ОписаниеТиповСтрока, ПутьКТаблицеПрисоединенныхФайлов);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);

		НовыйРеквизит = Новый РеквизитФормы("ИмяФайла", ОписаниеТиповСтрока, ПутьКТаблицеПрисоединенныхФайлов);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
		НовыйРеквизит = Новый РеквизитФормы("Адрес", ОписаниеТиповСтрока, ПутьКТаблицеПрисоединенныхФайлов);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
		НовыйРеквизит = Новый РеквизитФормы("ЭтоНовый", Новый ОписаниеТипов("Булево"), ПутьКТаблицеПрисоединенныхФайлов);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);

	КонецЕсли;

	Форма.ИзменитьРеквизиты(МассивДобавляемыхРеквизитов, );

	Форма[ПутьКПолюПросмотра]=СформироватьТекстHTMLДляТекстаMarkdown(ВариантПодсветкиСинтаксиса);
	
	//5.2. Поле формы просмтра
	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=ПутьКПолюПросмотра;
	ОписаниеЭлемента.ПутьКДанным=ПутьКПолюПросмотра;
	ОписаниеЭлемента.РодительЭлемента=СтраницаПросмотра;

	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидПоляФормы.ПолеHTMLДокумента);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);

	ОписаниеЭлемента.Действия.Вставить("ПриНажатии", "РМ_Подключаемый_ПриНажатииПоляПросмотраКомментария");
	ОписаниеЭлемента.Действия.Вставить("ДокументСформирован", "РМ_Подключаемый_ДокументСформированПоляПросмотраКомментария");

	СтраницыПросмотра=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	
	// 5.3 Присоединенные файлы
	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=РМ_MarkdownКлиентСервер.ИмяГруппыНовыхПрисоединенныхФайлов(ПутьКДаннымБезЛишнего);
	ОписаниеЭлемента.РодительЭлемента=СтраницаРедактирования;
	ОписаниеЭлемента.Заголовок="Новые файлы";

	ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.ОбычнаяГруппа);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяШирина", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("АвтоМаксимальнаяВысота", Ложь);
	ОписаниеЭлемента.Параметры.Вставить("Поведение", ПоведениеОбычнойГруппы.Свертываемая);

	ГруппаНовыеПрисоединенныеФайлы=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	
	Если ТолькоПросмотр Тогда
		Форма.Элементы[ИмяЭлементаСтраницРедактирования].ОтображениеСтраниц=ОтображениеСтраницФормы.Нет;
		Форма.Элементы[ИмяЭлементаСтраницРедактирования].ТекущаяСтраница=Форма.Элементы[ИмяЭлементаСтраницыПросмотра];
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьКнопкиВКоманднуюПанельРедактированияПоляMarkdown(Форма, ГруппаПоляРедактирования,
	ПутьКДаннымРедактирования, ЭтоВебКлиент = Ложь)

	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы()+"КомманднаяПанель_Редактирование_" + ПутьКДаннымРедактирования;
	ОписаниеЭлемента.РодительЭлемента=ГруппаПоляРедактирования;

	ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.КоманднаяПанель);

	КоманднаяПанель=СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);
	
	//ИЗменения шрифта
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЖирный", "Жирный", БиблиотекаКартинок.РМ_Жирный,
		Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDКурсив", "Курсив", БиблиотекаКартинок.РМ_Курсив,
		Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЗачеркнутый", "Зачеркнутый",
		БиблиотекаКартинок.РМ_Зачеркнутый, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);	

	//Заголовки
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЗаголовок1", "Заголовок 1",
		БиблиотекаКартинок.РМ_ЗаголовокH1, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЗаголовок2", "Заголовок 2",
		БиблиотекаКартинок.РМ_ЗаголовокH2, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЗаголовок3", "Заголовок 3",
		БиблиотекаКартинок.РМ_ЗаголовокH3, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);	

	//Всякое
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDЦитата", "Цитата", БиблиотекаКартинок.РМ_Цитата,
		Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDСсылка", "Ссылка", БиблиотекаКартинок.РМ_Ссылка,
		Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDПрограммныйКод", "Вставить код",
		БиблиотекаКартинок.РМ_ПрограммныйКод, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);	

	//Списки
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDМаркерыСписок", "Маркированный список",
		БиблиотекаКартинок.РМ_МаркерыСписок, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDНумерованныйСписок", "Нумерованный список",
		БиблиотекаКартинок.РМ_НумерованныйСписок, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDСписокЗадач", "Список задач",
		БиблиотекаКартинок.РМ_СписокЗадач, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDТаблица", "Вставить таблицу",
		БиблиотекаКартинок.РМ_Таблица, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);

	Если Не ЭтоВебКлиент Тогда
		СочетаниеКлавишВставкиКартинки=Новый СочетаниеКлавиш(Клавиша.Z, Ложь, Истина, Истина);
		ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDВставитьИзображениеИзБуфераОбмена",
			"Изображение из буфера", БиблиотекаКартинок.РМ_ВставитьКартинкуИзБуфера, Форма, КоманднаяПанель,
			ПутьКДаннымРедактирования, СочетаниеКлавишВставкиКартинки);
	КонецЕсли;

	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDДобавитьФайл", "Добавить файл",
		БиблиотекаКартинок.РМ_Скрепка, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);	
	
	ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown("КомандаMDОткрытьСинтаксис", "Добавить файл",
		БиблиотекаКартинок.РМ_Синтаксис, Форма, КоманднаяПанель, ПутьКДаннымРедактирования);	
	
	// подменю для вставки
	ОписаниеЭлемента=НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Имя=РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы()+"ПодменюВставитьЗагруженноеИзображение" + "_" + ПутьКДаннымРедактирования;
	ОписаниеЭлемента.РодительЭлемента=КоманднаяПанель;
	ОписаниеЭлемента.Заголовок="Вставить...";

	ОписаниеЭлемента.Параметры.Тип=Тип("ГруппаФормы");
	ОписаниеЭлемента.Параметры.Вставить("Вид", ВидГруппыФормы.Подменю);

	СоздатьЭлементПоОписанию(Форма, ОписаниеЭлемента);

КонецПроцедуры

Процедура ДобавитьКомандуНаКоманднуюПанельРедактированияMarkdown(ИмяКоманды, Заголовок, Картинка, Форма,
	КоманднаяПанель, ПутьКДаннымРедактирования, СочетаниеКлавиш = Неопределено)

	НовыйОписаниеКомандыКнопки=НовыйОписаниеКомандыКнопки();
	НовыйОписаниеКомандыКнопки.Имя=РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы()+ИмяКоманды + "_" + ПутьКДаннымРедактирования;
	НовыйОписаниеКомандыКнопки.Действие="РМ_Подключаемый_ОбработкаКомандыПоляКомментария";
	НовыйОписаниеКомандыКнопки.ИмяКоманды=РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы()+ИмяКоманды + "_" + ПутьКДаннымРедактирования;
	НовыйОписаниеКомандыКнопки.Заголовок=Заголовок;
	НовыйОписаниеКомандыКнопки.Картинка=Картинка;
	НовыйОписаниеКомандыКнопки.РодительЭлемента=КоманднаяПанель;
	НовыйОписаниеКомандыКнопки.СочетаниеКлавиш=СочетаниеКлавиш;

	СоздатьКомандуПоОписанию(Форма, НовыйОписаниеКомандыКнопки);
	СоздатьКнопкуПоОписанию(Форма, НовыйОписаниеКомандыКнопки);

КонецПроцедуры

Процедура ВывестиЭлементыПрисоединенногоФайлаНаФорму(Форма, ИмяФайла, ИдентификаторСтроки, ПутьКДаннымБезЛишнего) Экспорт

	Элементы = Форма.Элементы;

	ИмяГруппыНовыхФайлов=РМ_MarkdownКлиентСервер.ИмяГруппыНовыхПрисоединенныхФайлов(ПутьКДаннымБезЛишнего);
	ГруппаНовыеПрисоединенныеФайлы = Элементы.Найти(ИмяГруппыНовыхФайлов);

	ИмяГруппыТекФайла=РМ_MarkdownКлиентСервер.ИмяГруппыНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);
	ГруппаТекФайла = Элементы.Добавить(ИмяГруппыТекФайла, Тип("ГруппаФормы"), ГруппаНовыеПрисоединенныеФайлы);
	ГруппаТекФайла.Вид         = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаТекФайла.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	ГруппаТекФайла.ОтображатьЗаголовок = Ложь;

	ИмяЭлемента=РМ_MarkdownКлиентСервер.ИмяЭлементаНадписиНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);
	Эскиз = Элементы.Добавить(ИмяЭлемента, Тип("ДекорацияФормы"), ГруппаТекФайла);
//	Эскиз.Вид = ВидПоляФормы.ПолеНадписи;
//	Эскиз.ПутьКДанным = "ТаблицаПрисоединенныхФайлов["+ИндексСтроки+"].Адрес";	
	Эскиз.Заголовок = ИмяФайла;
//	Эскиз.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Лево;
//	Эскиз.РазмерКартинки = РазмерКартинки.Пропорционально;
//	Эскиз.РастягиватьПоГоризонтали = Ложь;
//	Эскиз.РастягиватьПоВертикали = Ложь;
//	Эскиз.Ширина = 10;
//	Эскиз.Высота = 4;

	ИмяГруппыКоманд=РМ_MarkdownКлиентСервер.ИмяГруппыКомандНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);
	ГруппаКоманд = Элементы.Добавить(ИмяГруппыКоманд, Тип("ГруппаФормы"), ГруппаТекФайла);
	ГруппаКоманд.Вид         = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаКоманд.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	ГруппаКоманд.ОтображатьЗаголовок = Ложь;
	
	// удалить
	ИмяКомандыУдалить = РМ_MarkdownКлиентСервер.ИмяКомандыУдалитьНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);

	Команда = Форма.Команды.Добавить(ИмяКомандыУдалить);
	Команда.Заголовок  = "Удалить";
	Команда.Действие   = "РМ_Подключаемый_УдалитьНовыйПрисоединенныйФайл";
	Команда.Картинка   = БиблиотекаКартинок.Удалить;
	Команда.ИзменяетСохраняемыеДанные = Истина;
	Команда.Отображение = ОтображениеКнопки.Картинка;

	КнопкаУдалить = Элементы.Добавить(ИмяКомандыУдалить, Тип("КнопкаФормы"), ГруппаКоманд);
	КнопкаУдалить.ИмяКоманды = ИмяКомандыУдалить;
	
	// открыть
	ИмяКомандыОткрыть = РМ_MarkdownКлиентСервер.ИмяКомандыОткрытьНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);

	Команда = Форма.Команды.Добавить(ИмяКомандыОткрыть);
	Команда.Заголовок  = "Открыть";
	Команда.Действие   = "РМ_Подключаемый_ОткрытьНовыйПрисоединенныйФайл";
	Команда.Картинка   = БиблиотекаКартинок.ПоказатьДанные;
	Команда.Отображение = ОтображениеКнопки.Картинка;

	КнопкаУдалить = Элементы.Добавить(ИмяКомандыОткрыть, Тип("КнопкаФормы"), ГруппаКоманд);
	КнопкаУдалить.ИмяКоманды = ИмяКомандыОткрыть;
	
	// вставить загруженное изображение
	//Доступно только если формат загружаемого файла является картинкой
	ИмяКомандыВставить = РМ_MarkdownКлиентСервер.ИмяКомандыВставитьНовогоПрисоединеногоФайла(ПутьКДаннымБезЛишнего,
		ИдентификаторСтроки);

	Команда = Форма.Команды.Добавить(ИмяКомандыВставить);
	Команда.Заголовок  = ИмяФайла;
	Команда.Действие   = "РМ_Подключаемый_ОбработкаКомандыПоляКомментария";
	Команда.Отображение = ОтображениеКнопки.Текст;

	Подменю = Элементы.Найти(РМ_MarkdownКлиентСервер.ПрефиксЭлементовФормы()+"ПодменюВставитьЗагруженноеИзображение_" + ПутьКДаннымБезЛишнего);

	КнопкаВставить = Элементы.Добавить(ИмяКомандыВставить, Тип("КнопкаФормы"), Подменю);
	КнопкаВставить.ИмяКоманды = ИмяКомандыВставить;

КонецПроцедуры

//@skip-warning
Функция ПолучитьСсылкуНаПрисоединенныйФайлПоИдентификатору(Идентификатор) Экспорт
//	Возврат Справочники.ЗадачаПрисоединенныеФайлы.ПолучитьСсылку(Идентификатор);
КонецФункции
#КонецОбласти

#Область РаботаСФормами

Функция НовыйОписаниеРеквизитаЭлемента() Экспорт
	СтруктураРеквизита = Новый Структура;
	
	СтруктураРеквизита.Вставить("СоздаватьРеквизит", Истина);
	СтруктураРеквизита.Вставить("Имя", "");
	СтруктураРеквизита.Вставить("ОписаниеТипов", Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(10)));
	СтруктураРеквизита.Вставить("ПутьКДанным", "");
	СтруктураРеквизита.Вставить("Заголовок", "");

	СтруктураРеквизита.Вставить("СоздаватьЭлемент", Истина);
	СтруктураРеквизита.Вставить("РодительЭлемента", Неопределено);
	СтруктураРеквизита.Вставить("ПередЭлементом", Неопределено);
	СтруктураРеквизита.Вставить("МногострочныйРежим", Неопределено);
	СтруктураРеквизита.Вставить("РасширенноеРедактирование", Неопределено);
	СтруктураРеквизита.Вставить("РастягиватьПоГоризонтали", Неопределено);
	СтруктураРеквизита.Вставить("РастягиватьПоВертикали", Неопределено);
	СтруктураРеквизита.Вставить("Параметры", НовыйПараметрыРеквизита());
	СтруктураРеквизита.Вставить("Действия", Новый Структура);
	Возврат СтруктураРеквизита;

КонецФункции

Функция НовыйПараметрыРеквизита()

	Параметры = Новый Структура;

	Параметры.Вставить("Тип", Тип("ПолеФормы"));
	Параметры.Вставить("Вид_ПоУмолчанию", ВидПоляФормы.ПолеВвода);

	Возврат Параметры;

КонецФункции

Функция НовыйОписаниеКомандыКнопки() Экспорт
	Структура = Новый Структура;

	Структура.Вставить("СоздаватьКоманду", Истина);
	Структура.Вставить("СоздаватьКнопку", Истина);

	Структура.Вставить("Имя", "");
	Структура.Вставить("Действие", "");
	Структура.Вставить("ИмяКоманды", "");
	Структура.Вставить("ЭтоГиперссылка", Ложь);
	Структура.Вставить("РодительЭлемента", Неопределено);
	Структура.Вставить("ПередЭлементом", Неопределено);
	Структура.Вставить("Заголовок", "");
	Структура.Вставить("Подсказка", "");
	Структура.Вставить("СочетаниеКлавиш", Неопределено);
	Структура.Вставить("Картинка", Неопределено);

	Возврат Структура;
КонецФункции

Функция СоздатьКомандуПоОписанию(Форма, ОписаниеКоманды) Экспорт
	Если Не ОписаниеКоманды.СоздаватьКоманду Тогда
		Возврат Неопределено;
	КонецЕсли;
	Команда = Форма.Команды.Добавить(ОписаниеКоманды.Имя);
	Команда.Заголовок  = ОписаниеКоманды.Заголовок;
	Команда.Подсказка  = ОписаниеКоманды.Подсказка;
	Команда.Действие   = ОписаниеКоманды.Действие;
	Команда.Картинка   = ОписаниеКоманды.Картинка;
	Если ОписаниеКоманды.СочетаниеКлавиш <> Неопределено Тогда
		Команда.СочетаниеКлавиш = ОписаниеКоманды.СочетаниеКлавиш;
	КонецЕсли;

	Возврат Команда;
КонецФункции

Функция СоздатьЭлементПоОписанию(Форма, ОписаниеРеквизита) Экспорт
	Если Не ОписаниеРеквизита.СоздаватьЭлемент Тогда
		Возврат Неопределено;
	КонецЕсли;

	ЭлементФормы = Форма.Элементы.Вставить(ИмяТаблицыПоляФормы(Форма, ОписаниеРеквизита.РодительЭлемента)
		+ ОписаниеРеквизита.Имя, ОписаниеРеквизита.Параметры.Тип, ЭлементФормы(Форма,
		ОписаниеРеквизита.РодительЭлемента), ЭлементФормы(Форма, ОписаниеРеквизита.ПередЭлементом));

	ЭлементФормы.Заголовок = ОписаниеРеквизита.Заголовок;

	Если Тип(ЭлементФормы) = Тип("ПолеФормы") Тогда
		ЭлементФормы.Вид = ОписаниеРеквизита.Параметры.Вид_ПоУмолчанию;
		Попытка
			Если ТипЗнч(Реквизит(Форма, ОписаниеРеквизита.Имя, ОписаниеРеквизита.ПутьКРеквизиту)) = Тип("Булево") Тогда
				ЭлементФормы.Вид = ВидПоляФормы.ПолеФлажка;
			КонецЕсли;
		Исключение
			ОписаниеОшибки = ОписаниеОшибки();
		КонецПопытки;
	КонецЕсли;

	ЗаполнитьЗначенияСвойств(ЭлементФормы, ОписаниеРеквизита.Параметры);

	Если Тип(ЭлементФормы) = Тип("ПолеФормы") Тогда
		Если ЗначениеЗаполнено(ОписаниеРеквизита.ПутьКДанным) Тогда
			ЭлементФормы.ПутьКДанным = ОписаниеРеквизита.ПутьКДанным;
		Иначе
			ЭлементФормы.ПутьКДанным = ОписаниеРеквизита.Имя;
		КонецЕсли;

		Если ОписаниеРеквизита.МногострочныйРежим <> Неопределено Тогда
			ЭлементФормы.МногострочныйРежим=ОписаниеРеквизита.МногострочныйРежим;
		КонецЕсли;
		Если ОписаниеРеквизита.РасширенноеРедактирование <> Неопределено Тогда
			ЭлементФормы.РасширенноеРедактирование=ОписаниеРеквизита.РасширенноеРедактирование;
		КонецЕсли;

	КонецЕсли;
	Если ОписаниеРеквизита.РастягиватьПоГоризонтали <> Неопределено Тогда
		ЭлементФормы.РастягиватьПоГоризонтали=ОписаниеРеквизита.РастягиватьПоГоризонтали;
	КонецЕсли;
	Если ОписаниеРеквизита.РастягиватьПоВертикали <> Неопределено Тогда
		ЭлементФормы.РастягиватьПоВертикали=ОписаниеРеквизита.РастягиватьПоВертикали;
	КонецЕсли;

	Для Каждого Действие Из ОписаниеРеквизита.Действия Цикл
		ЭлементФормы.УстановитьДействие(Действие.Ключ, Действие.Значение);
	КонецЦикла;
	Возврат ЭлементФормы;
КонецФункции

Функция СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки) Экспорт
	Если Не ОписаниеКнопки.СоздаватьКнопку Тогда
		Возврат Неопределено;
	КонецЕсли;

	Кнопка = Форма.Элементы.Вставить(ОписаниеКнопки.Имя, Тип("КнопкаФормы"), ЭлементФормы(Форма,
		ОписаниеКнопки.РодительЭлемента), ЭлементФормы(Форма, ОписаниеКнопки.ПередЭлементом));
	Если Не ОписаниеКнопки.СоздаватьКоманду Тогда
		Кнопка.Заголовок = ОписаниеКнопки.Заголовок;
	КонецЕсли;
	Если ОписаниеКнопки.ЭтоГиперссылка = Ложь Тогда
		Если ЭтоКнопкаКоманднойПанели(Форма, ОписаниеКнопки.РодительЭлемента) Тогда
			Кнопка.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
		Иначе
			Кнопка.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели;
		КонецЕсли;
	Иначе
		Если ЭтоКнопкаКоманднойПанели(Форма, ОписаниеКнопки.РодительЭлемента) Тогда
			Кнопка.Вид = ВидКнопкиФормы.Гиперссылка;
		Иначе
			Кнопка.Вид = ВидКнопкиФормы.ГиперссылкаКоманднойПанели;
		КонецЕсли;
	КонецЕсли;
	Кнопка.ИмяКоманды = ОписаниеКнопки.ИмяКоманды;

КонецФункции

Функция ЭтоКнопкаКоманднойПанели(Форма, Знач РодительКнопки)
	Если РодительКнопки = Неопределено Тогда
		Возврат Ложь;
	ИначеЕсли РодительКнопки = Форма.КоманднаяПанель Тогда
		Возврат Истина;
	ИначеЕсли ТипЗнч(РодительКнопки) = Тип("УправляемаяФорма") Тогда
		Возврат Ложь;
	Иначе
		РодительКнопки = ЭлементФормы(Форма, РодительКнопки);
		Возврат ЭтоКнопкаКоманднойПанели(Форма, РодительКнопки.Родитель);
	КонецЕсли;
КонецФункции

Функция ИмяТаблицыПоляФормы(Форма, Знач РодительЭлемента)
	Если РодительЭлемента = Неопределено Тогда
		Возврат "";
	ИначеЕсли ТипЗнч(РодительЭлемента) = Тип("ТаблицаФормы") Тогда
		Возврат РодительЭлемента.Имя;
	ИначеЕсли ТипЗнч(РодительЭлемента) = Тип("УправляемаяФорма") Тогда
		Возврат "";
	Иначе
		РодительКнопки = ЭлементФормы(Форма, РодительЭлемента);
		Возврат ИмяТаблицыПоляФормы(Форма, РодительЭлемента.Родитель);
	КонецЕсли;
КонецФункции

Функция ЭлементФормы(Форма, Идентификатор) Экспорт
	Если ТипЗнч(Идентификатор) = Тип("Строка") Тогда
		Возврат Форма.Элементы.Найти(Идентификатор);
	Иначе
		Возврат Идентификатор;
	КонецЕсли;
КонецФункции

Функция Реквизит(Форма, ИмяРеквизита, ПутьКРеквизиту = "") Экспорт
	Если ПутьКРеквизиту <> "" Тогда
		Разделитель = СтрНайти(ПутьКРеквизиту, ".");
		Если Разделитель = 0 Тогда
			ИмяШага = ПутьКРеквизиту;
			ОстатокПути = "";
		Иначе
			ИмяШага = Лев(ПутьКРеквизиту, Разделитель - 1);
			ОстатокПути = Сред(ПутьКРеквизиту, Разделитель + 1);
		КонецЕсли;
		Возврат Реквизит(Форма[ИмяШага], ИмяРеквизита, ОстатокПути);
	Иначе
		НесуществующееЗначение = Неопределено;
		Структура = Новый Структура(ИмяРеквизита, НесуществующееЗначение);
		ЗаполнитьЗначенияСвойств(Структура, Форма);
		Если Структура[ИмяРеквизита] = НесуществующееЗначение Тогда
			Возврат НесуществующееЗначение;
		КонецЕсли;
		Возврат Форма[ИмяРеквизита];
	КонецЕсли;
КонецФункции

#КонецОбласти