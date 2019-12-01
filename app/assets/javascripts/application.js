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
//= require turbolinks
//= require rails-ujs
//= require activestorage

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
    let arrayMessage = window.location.hash.split('=');
    if (arrayMessage[0] == '#message') {
      let message = decodeURI(arrayMessage[1]);
      M.toast({html: message, completeCallback: () => {
        window.location.hash = '';
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

/**
 * Активируем автозаполнение для поля поиска.
 */
function seachFieldAutocomplete(params) {
  let searchField = document.querySelector('.autocomplete');
  if (searchField) {
    let searchFieldInstance = M.Autocomplete.init(searchField, {
      limit: 10,
      onAutocomplete: () => {
        Rails.ajax({
          type: 'POST', 
          url: `${params.url}/${searchField.value}`,
          success: (response) => {
            document.querySelector(params.outputBodyIdSelector).innerHTML = response.body.innerHTML;
            if (params.outputRequestIdSelector) {
              document.querySelector(params.outputRequestIdSelector).innerHTML = `Поиск по "${searchField.value}"`;
            }
            if (params.getMethod) {
              history.pushState(null, null, `/shop/search-products/${searchField.value}`)
            }
          },
          error: function(response) {
            console.log(response);
          }
        });
      }
    });
    Rails.ajax({
      type: 'POST', 
      url: params.url,
      success: (response) => {
        let data = {};
        response.forEach(item => {
          data[item.name] = null
        });
        searchFieldInstance.updateData(data);
      },
      error: function(response) {
        console.log(response);
      }
    });
  }
}

document.addEventListener('turbolinks:load', function() {
  navbarDropdown();            // выпадающие меню
  M.Modal._count = 0;          // иначе 
  onFocusInvalidClassRemove(); // снимаем с input класс invalid по фокусу на этом же поле
  onClicButtonClassRemove()    // снимаем с input класс invalid по нажатию на кнопку выбора картинки
});

document.addEventListener('turbolinks:before-cache', () => {
  Turbolinks.clearCache();
});