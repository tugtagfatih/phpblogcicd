<?php

@define('PLUGIN_EVENT_XHTMLCLEANUP_NAME', 'Исправить распространённые ошибки XHTML');
@define('PLUGIN_EVENT_XHTMLCLEANUP_DESC', 'Этот плагин исправляет распространённые проблемы с разметкой XHTML в записях. Это помогает поддерживать соответствие Вашего блога XHTML.');
@define('PLUGIN_EVENT_XHTMLCLEANUP_XHTML', 'Кодировать данные, обработанные в формате XML?');
@define('PLUGIN_EVENT_XHTMLCLEANUP_XHTML_DESC', 'Этот плагин использует метод синтаксического анализа XML для обеспечения корректности Вашего кода в формате XHTML. Этот синтаксический анализ XML может преобразовать уже допустимые объекты в неэкранированные, поэтому плагин кодирует все объекты после синтаксического анализа. Установите этот флажок в положение "Выкл", если происходит двойное кодирование!');
@define('PLUGIN_EVENT_XHTMLCLEANUP_UTF8', 'Очистить объекты UTF-8?');
@define('PLUGIN_EVENT_XHTMLCLEANUP_UTF8_DESC', 'Если включено, HTML-объекты, производные от символов UTF-8, будут правильно преобразованы и не будут дважды закодированы в Ваших выходных данных.');
@define('PLUGIN_EVENT_XHTMLCLEANUP_YOUTUBE', 'Очистить код Youtube-плеера?');
@define('PLUGIN_EVENT_XHTMLCLEANUP_YOUTUBE_DESC', 'Если включено, недопустимые теги объектов Youtube в формате XHTML по умолчанию будут удалены из части встраивания. Браузер по-прежнему будет корректно воспроизводить видео.');

