// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//require_tree .

/**
 * Активируем dropdown в клиентской и админской части сайта.
 */
function navbarDropdown() {
  document.querySelectorAll('.dropdown-trigger').forEach(element => M.Dropdown.init(element));
}

/**
 * Передает все сообщения из url в toast и активирует его.
 * После чего очищает url от переменных.
 */
function toastActive(message) {
  if (!message) {
    if (decodeURI(window.location.search.split('=')[0]) == '?message') {
      let message = decodeURI(window.location.search.split('=')[1]);
      M.toast({html: message, completeCallback: () => {
        window.location.search = '';
      }});
    }
  } else {
    M.toast({html: message});
  }
}

/**
 * Удаляем класс ivalid с полей input при фокусе.
 */
function onFocusInvalidClassRemove() {
  document.querySelectorAll('input[type=text]').forEach(input => {
    input.onfocus = function() {
      this.classList.remove('invalid');
    };
  }); 
}

/**
 * Удаляем класс invalid с полей input при нажатии на кнопку выбота картинки.
 */
function onClicButtonClassRemove() {
  document.querySelectorAll('.ivalid-click-off').forEach(button => {
    button.onclick = () => {
      let fileInput = document.querySelector('.file-path-wrapper .invalid');
      if (fileInput) {
        fileInput.classList.remove('invalid');
      }
    };
  });
}

document.addEventListener('page:load', function() {
  toastActive();               // всплывающее сообщение, активируется если в url есть переменна message
  navbarDropdown();            // выпадающие меню
  onFocusInvalidClassRemove(); // снимаем с input класс invalid по фокусу на этом же поле
  onClicButtonClassRemove()    // снимаем с input класс invalid по нажатию на кнопку выбора картинки
});

document.addEventListener('turbolinks:load', function() {
  toastActive();               // всплывающее сообщение, активируется если в url есть переменна message
  navbarDropdown();            // выпадающие меню
  M.Modal._count = 0;          // иначе 
  onFocusInvalidClassRemove(); // снимаем с input класс invalid по фокусу на этом же поле
  onClicButtonClassRemove()    // снимаем с input класс invalid по нажатию на кнопку выбора картинки
});