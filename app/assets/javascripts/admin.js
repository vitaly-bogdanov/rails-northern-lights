/**
 * Выбор категории.
 */ 
function select() {
  var select = document.querySelectorAll('select');
  M.FormSelect.init(select);
}

/**
 * Выделяем нижнюю границу красным цветом если есть ошибка.
 */
function selectErrorBottomBorderOn() {
  if (document.querySelector('#note-error') && document.querySelector('#note-error').innerHTML != '') {
    document.querySelector('.select-wrapper .select-dropdown').classList.add('invalid');
  }
}

/**
 * Выключаем стили валидационной ошибки элемента select.
 */
function selectErrorStyleOff() {
  let selectInput = document.querySelector('.select-wrapper .invalid');
  if (selectInput) {
    selectInput.onclick = function() {
      this.classList.remove('invalid');
      document.querySelector('#note-error').innerHTML = '';
    }
  }  
}


/**
 * Деактивируем ссылку на удаление при первом нажатии 
 * для избежания действий от повторного нажатия.
 */
function disableLink() {
  document.querySelectorAll('.horizontal-grid__item-delete a').forEach((link) => {
    link.onclick = function() {
      this.classList.add('disabled');
    }
  });
}

document.addEventListener('page:load', function(event) {
  select();                    // поле select в админке
  selectErrorBottomBorderOn(); // вешаем класс invalid на поле select, если поле не проходит валидацию
  selectErrorStyleOff();       // снимаем стили ошибки валидации и убираем сообщение об ошибке
  M.updateTextFields();        // при загрузке перезагружает поля, на случай если форма не пуста
  disableLink();               // отключаем ссылку на удаление ради избежания повторных кликов и запросов
});

document.addEventListener('turbolinks:load', function(event) {
  select();                    // поле select в админке
  selectErrorBottomBorderOn(); // вешаем класс invalid на поле select, если поле не проходит валидацию
  selectErrorStyleOff();       // снимаем стили ошибки валидации и убираем сообщение об ошибке
  M.updateTextFields();        // при загрузке перезагружает поля, на случай если форма не пуста
  disableLink();               // отключаем ссылку на удаление ради избежания повторных кликов и запросов
});