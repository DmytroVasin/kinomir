http://kinomir.herokuapp.com/

	### Приложение, за основу которого взято http://lostfilm.info/

	В нем используется:
		- PostgreSQL
		- gem twitter-bootstrap-rails 
		- gem jquery-rails (Ajax применен только для регистрации нового пользователя)
		- gem devise
		- gem client_side_validations 
		- gem kaminari ( в начале пагинация была Ajax-ом -потом заменил на постраничную, при обновлении текущая страница сохраняется )
		- gem pg_search ( очень простой по БД )
		- gem mini_magick
		- gem carrierwave ( для загрузки изображений для статей, изображение принимает :thumb и :main version для правильно отображение на index и на show экшене, используеться resize_to_fit, загружать можно только jpg jpeg png)
		- gem thin ( для Хероку )
		- gem cancan ( добавлялся последним - остались маленькие велосипеды )
		
		
		На странице /posts/ отображаеются все статьи ( по 6ть на страницу ), в каждом посте:
		- Номер поста
		- Время публикации ( в текущей временной зоне )
		- Заголовок статьи
		- Текст статьи (200 первых символов +/- до пробела)
		- Фотография стать (:main), если ее нет - отображаеться дефолтное фото с вопросиком
		- Теги, к которым принадлежит пост ( кликнув на тег - отобразятся все посты с таким тегом )
		- Количество коментариев
		- Автор 
			- Если это user
				- то будет отображен ссылкой на профиль
				- в профиле будут все статьи опубликованные этим автором
				- если текущий юзер смотрит на свой профиль, то будет отображаться кнопочка Edit
				- Edit, отредактировать свой профиль - Пароль, имя, страну, город, аватар... доступ к этой странице есть только у текушего пользоватея
			- Если автор удалён 
				- будет написано Delete и перечеркнуто
			- Если автор это админ
				- на админа нет ссылки
		- Звёздный рейтинг ( возможность голосовать - только в экшене show, и только один раз за один пост )
		- Административная зона ( просмотр статьи доступен всем, редактировать и удалять могут только автор и админ ) 

		1. При создании поста вы обязаны написать заголовок и текст, также отнести ее хотя бы к одной теме.
		2. Добавление коментариев идет ajax-ом.
		3. Если пользователь удален его аватарка измениться и имя тоже
		4. админ и автор могут только удалять комантарии к статье


		Страница имеет 2 поля ( Email и Password ) для входа под правами администратора
			- «Admin@gmail.com»
			- «password»
		После аутентификации идёт перенаправление на root_path

1. Админ:

		- Имя админа выделено ( добавлен значок )
		- Админ имеет доступ к странице всех пользователей ( где он может их удалить )
		- Админ имеет доступ к станице к тегам(темам постов) где может удалять и создавать их
		- может удалять комментарии
		- удалять посты ( редактировать посты )
		- ставить рейтинг посту ( и обнулять его ) {ставить рейтинг, как пользователь - один раз к одной статье}
2. Юзер: 

		- создавать посты 
		- редактировать и удалять посты ( только свои )
		- создавать комментариии удалять их ( только свои )
		- изменить свои данные ( Страну, Город, Пароль, Имя - только зная текущий пароль)
		- ставить свой рейтинг посту
3. Гость:

		- может просматривать посты и профили


# UPD
	- добавлена функция Ajax к 'звёздочкам' ( подкорректировал вьюху )
	- добавил еще одну модель, контроллер, пару вьюх, таблицу в БД -> "photos_controller"...
		- Гостям доступа на страницу вообще нет
		- Админу доступно всё ( хотя особого смысла в этом доступе нет - если админ может редактировать и удалять посты )
		- Юзерам, создавшим пост - доступна страница, другим юзерам - нет
	- Добавлен RedCloth, Textile markup language -> достпен только для постов(не для коментариев), все скрипты будут убраны ( 
		на индексной странице будет отображаться просто текст - без изменений )
( добавление photo сделано для удобства использования RedCloth, и для быстрого ориентирования в большом кол-ве фотографии,
 фотографии будут трёх типов - thumb -> для удобства, medium -> с ширеной страницы, и загруженная фото 
 Ссылка на загруженную фотографию будет в action show - т.е. линк которорый надо вставить в RedCloth для отображения загруженной фотографии,
 Или перед линком дописать medium - что б отобразило фото с шириной в 800px )


# Подробнее о каждой странице:

http://kinomir-anahoret.herokuapp.com/

1. ***/ или root_path*** - стартовая страница
	Имеется верхнее меню ( на всех страницах ) 
		1. кнопка Home — ссылается на стартовую страницу
		2. кнопка Posts — ссылается на страницу с Постами (описание дальше)
		3. кнопка с именем текущего пользователя
			 - Для администрации выделена красным цветом со знаком внимания (и в этом случае добавляются две две дополнительных кнопки-ссылки «Servants» и «Categories» описанные ниже, доступные только для администрации  
			 - Для Залогиневшегося пользователя является ссылкой на просмотр его профиля
			 - Если пользователь не авторизован — то ссылка является кнопка для прохождения регистрации ( так же в этом случае добавляется 2 поля с быстрым доступом для регистрации — Email Password, действует только для входа пользователя, а не администратора )
		4. кнопка «Sign out» для выхода из текущей сессии пользователя (если пользователь авторизован)
	Есть большая кнопка-ссылка на страницу Posts (описание ниже)
	На странице представлено минимальное описание страниц

2. ***/users/registration*** - Страница для регистрации **НОВОГО** пользователя
	Содержит поля:
		 - Name ( заполнить более чем одним символом )
		 - Email ( Проверка на валидность // стандартная проверка //, и на то, что введённый email не используется )
		 - Password ( не может быть пустым и минимум 6ть символов ) 
		 - Password_confirmation ( должен соответствовать полю Password )
		 - Accept the rules (кнопка согласия с правилами сайта, должна быть установлена)

	На странице имеется кнопка «Sign in» ссылающаяся на страницу прохождения аутентификации

3. ***/users/login*** - Страница прохождения аутентификации
	с полями:
		 - Email ( Имейл )
		 - Password ( Пароль )
		 - Remember me (запоминающий флаг — для дальнейшего посещения сайта без аутентификации)    
		Имеется кнопка перехода на страницу регистрации

		Пароль и Логин при ошибке входа — выдаёт сообщение «Incorrect!»,  или «Signed in successfully.» при прохождении ( сообщение 	исчезает через 2 секунды, как и все flash[: …] сообщения ) - перенаправление происходит на стартовую страницу 

4. ***/servants***  - Страница отображения всех пользователей( Административная область )
		Страница доступна только администраторам, на ней есть отображение всех зарегистрированных пользователей с их данными:
	 - Аватар
	 - Имя
	 - Email
	 - Время последнего посещения сайта
	 - Время регистрации пользователя
	 - Страна (если установлена пользователем — по дефолту выставлена «unknown»)
	 - Город (если установлена пользователем — по дефолту выставлена «unknown»)
	 - опции: Show(показывает его профиль — страница профиля, описание ниже) и Delete(Удаляет пользователя, при удалении посты пользователя не будут потеряны — просто автор сменится на «deleted user» и аватар автора тоже сменится на «Deleted avatar», тоже будет со всеми комментариями данного пользователя)

6. ***/servants/1*** - Страница Профиля выбранного пользователя: ( или ***/servants/:id*** )

 - Демонстрирует все данные введенные пользователем(имя, email, страна и город) и даты регистрации, и последнего посещения
 - Посты созданные пользователем:
    - (с кнопками демонстрации — Show)
    - Даты создания
    - Заголовком
    - Темой (началом темы — первые 200 символов )
 - Если страница является профилем текущего пользователя — то добавляется клавиша «Edit profile». Ссылающуюся на страницу редактирования профиля.    

7. ***/users/edit*** - Редактирование профиля пользователя ( Только для зарегистрированных пользователей ) 
	Если пользователь не зарегистрирован — перенаправит на страницу регистрации
	 - Клавиша «Back» - назад на предыдущую страницу.
	 - Клавиша просмотра текущего пользователя ( servants/:id — current_user)
	 - Клавиша удаления аккаунта ( не удаляет посты и комментарии созданные пользователем )
	 - Картинка-клавиша отображения аватарки ( при клике ссылается на gravatar.com — для изменения аватрки текущего email адреса ) 
	 - Поля Name, Email — заполнены ( редактировать для изменения)
	 - Поле выбора страны ( и поле выбора города появится, — если в базе данных предусмотрены для данной страны города, для демонстрации города выберите «United Kingdom», если не предусмотрены — то поле города в отображении будет принимать вид «unknown» )
	 - Поля изменения пароля ( Password и Password confirmation )
	 - Поле текущего пароля ( если вы внесли изменения — то надо его заполнить, что бы они вступили в силу // кроме аватарки — так как она изменяется отдельно от профиля ) 

8. ***/categories*** и ***/categories/new***  - страницы создания категорий, к которым будут принадлежать посты 
	При удалении категории они будут просто стерты из постов ( имеющих такие категории ) 
		 - минимум должна быть одна категория 
		 - Кнопка удаления категории
		 - Кнопка добавления категории ( категория проверяется на наличие хоть одного символа presence )

9. ***/posts*** — страница просмотра тем(постов)
	Страница доступна всем пользователям, даже не зарегистрированным

	На странице имеется:
	 - простой поиск (реализованный на базе PostgreSQL)
	 - Пагинация (если количество постов достаточное) — сделана Ajax-ом + клавиши обратного доступа ( назад, вперед около браузерной строки ), Есть клавиши первой, последней, следующей, предыдущей страницы (если кол-во позволяет)
	 - Кнопка создания поста
	 - Отображение восьми постов на странице ( посты включают в себя ):
		- номер инекса
		- дату публикации ( в текущей временной зоне )
		- Тему новости ( явл. Ссылкой на просмотр данной темы — action «show» )
		- Текст новости ( ограниченный в 200 символов)
		- фотографии (:main) уменьшенный вариант той, которая будет в экшене show ( если же пользователь не загружал ниодну картинку — то отобразится стандартная «картинка с вопросиком»
		- Темы к которым относится данная статья ( также доступна Сортировка по этим темам ) 
		- Имя автора темы ( доступна ссылка на имени — которая приведет в его профиль — где и можно глянуть все темы этого автора ) , если автор темы удалён то будет написано «Deleted» и перечеркнуто, если автор статьи является администратором — то ссылка на его профиль не будет доступна 
		- количество комментариев в данном посте 
		- Административная область:
			1. Клавиша «Show» доступна всем пользователям ( так же не зарегистрированным )
			2. клавиши «edit» и «destroy» - доступны только авторам( создателям данной статьи или администраторам)

10. ***/posts/1*** — страница просмотра первой темы (публикации)
	На ней:
	 - большая фотография загруженного автором изображения ( если такого нет — то будет показано дефолтное фото ) 
	 - Тема поста
	 - Текст поста ( польностью )
	 - категории ( если нажать — то будет отсортированы все посты по данной категории ) 
	 - дата публикации
	 - автор и его аватарка ( если автор удалён — то аватарка будет отображаться для удалённого пользователя, а Имя будет заменено на «deleted» и перечеркнуто
	    
	Коментарии:  (добавление комментариев сделано Ajax-ом 
		1.Поле для имеющихся комментариев:
			- Имя автора комментария
			- Дата публикации комментария
			- Текст комментария
			- кнопка «delete» - доступна только для автора комментария и для администратора
			- аватарка коментатора
		2.Поле ввода комментария (доступна только зарегистрированным пользователям):
			- Аватар текущего пользователя ( админа ) 
			- Поле ввода ( и кнопка создать комментарий — в начале отключена, включается только когда в поле ввода будет более 3х символов )

	Административная область:
		 - Кнопка возврата ко всем постам 
		 - Кнопка редактирование статьи ( доступно автору или администратору )
		 - Кнопка удаления поста ( доступно автору или администратору )
		
11. ***/posts/new*** и ***/posts/:id/edit*** 
	Созадние или редактирование поста
	 - Клавиша возврата 
	 - Поле ввода темы поста ( проверка на наличие )
	 - поле ввода текста ( проверка на наличие ) 
	 - Чек-боксы для выбора к какой категории принадлежит данная тема ( должна быть выбрана хоть одна категория ) 
		(если вы редактируете пост — и не хотите изменять категории, надо просто оставить их пустыми )
	 - Поле вставки фотографии ( которая будет уменьшена с помощью carierWave — в двух размерах :thumb(отображается при просмотре всех постов - /posts ) и :main ( картинка с большим расширением отображается при просмотре отдельной темы - /post/1 )
		( если вы редактируете пост — и не хотите изменять картинку, надо просто оставить поле пустым ) 