//= require activestorage

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
 * Подсчет и валидация количества букв в поле ввода
 * в админской части сайта. 
 */
function lettersCountInInput() {
  let inputFields = document.querySelectorAll('.letters-count-in-input');
  if (inputFields) {
    inputFields.forEach((inputField) => {
      // при вводе в поле проставляем количество символов
      inputField.oninput = function () {
        this
          .nextElementSibling
          .nextElementSibling
          .lastElementChild.innerHTML = this.value.length;
      }
      // при загрузке страницы проставим количество сиволов
      inputField
        .nextElementSibling
        .nextElementSibling
        .lastElementChild.innerHTML = inputField.value.length;
    });
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

/**
 * Переключение товара: доступен для покупки или нет.
 */
function toogleAvailable() {
  let toogleAvailableButton = document.querySelector('#toogle-available');
  if (toogleAvailableButton) {
    toogleAvailableButton.onclick = function() {
      let formData = new FormData();
      formData.append('available', !this.checked);
      Rails.ajax({
        type: 'PATCH', 
        url: `/admin/order_calls/${this.dataset.productId}/toogle-available`,
        dataType: 'json',
        data: formData,
        success: (response) => {},
        error: (error) => console.error(error)
      });
    }
  }
}

document.addEventListener('turbolinks:load', function(event) {
  select();                    // поле select в админке
  selectErrorBottomBorderOn(); // вешаем класс invalid на поле select, если поле не проходит валидацию
  selectErrorStyleOff();       // снимаем стили ошибки валидации и убираем сообщение об ошибке
  M.updateTextFields();        // при загрузке перезагружает поля, на случай если форма не пуста
  disableLink();               // отключаем ссылку на удаление ради избежания повторных кликов и запросов
  lettersCountInInput();       // вывод числа символов
  toogleAvailable();           // переключение доступности товара

  // поиск, метод находится в aplication.js
  seachFieldAutocomplete({
    url: '/admin/search-products', 
    outputBodyIdSelector: '#search-result', 
    picture: false
  });
});

