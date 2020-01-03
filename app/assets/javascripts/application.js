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
        history.pushState(null, null, window.location.pathname);
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

function deleteSerchedProduct() {
  let products = document.querySelectorAll('.delete-searched-product');
  if (products) {
    products.forEach(product => {
      product.onclick = function(event) {
        this
          .parentElement
          .parentElement
          .parentElement
          .removeChild(this.parentElement.parentElement);
      }
    });
  }
}

/* ********* ПРЕЛОАДЕРЫ ********* */

// function lazyLoadImageForCardProduct() {
//   const imageObserver = new IntersectionObserver((entries, imgObserver) => {
//     entries.forEach((entry) => {
//         if (entry.isIntersecting) {
//           const lazyImage = entry.target
//           console.log("lazy loading ", lazyImage)
//           lazyImage.src = lazyImage.dataset.src
//           lazyImage.classList.remove("lzy_img");
//           imgObserver.unobserve(lazyImage);
//         }
//     })
//   });
//   const arr = document.querySelectorAll('img.lzy_img')
//   arr.forEach((v) => {
//       imageObserver.observe(v);
//   })
// }


/**
 * Прелоадер для картинок карточек товаров
 */
function productCardImagePreloader() {
  const imageObserver = new IntersectionObserver((entries, imgObserver) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const lazyImage = entry.target;
          console.log(lazyImage.src);
          lazyImage.src = lazyImage.dataset.src;
          if (lazyImage.complete) {
            lazyImage.nextElementSibling.classList.add('preloader-box--hidden');
          } else {
            lazyImage.onload = () => {
              lazyImage.nextElementSibling.classList.add('preloader-box--hidden');
            }
          }
          lazyImage.classList.remove("lzy_img");
          lazyImage.removeAttribute('data-src');
          imgObserver.unobserve(lazyImage);
        }
    })
  });
  const images = document.querySelectorAll('.lzy_img');
  if (images) {
    images.forEach((image) => {
      imageObserver.observe(image);
    });
  }
}

/**
 * Прелоадер для картинки демонстрации товара 
 */
function productShowImagePreloader() {
  const imageBlock = document.querySelector('.show-product-image');
  if (imageBlock) {
    let img = imageBlock.firstElementChild;
    if (img.complete) {
      imageBlock.lastElementChild.classList.add('preloader-box--hidden');
    } else {
      img.onload = () => {
        imageBlock.lastElementChild.classList.add('preloader-box--hidden');
      }
    }
  }
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
              let pagination = document.querySelector('.product-pagination');
              if (pagination) {
                pagination.remove();
              }
            }
            if (params.getMethod) {
              history.pushState(null, null, `/shop/search-products/${searchField.value}`);
            }
            productCardImagePreloader();
            setTimeout(() => {
              deleteSerchedProduct();
            }, 1000);
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
      error: (error) => {}
    });
  }
}

document.addEventListener('turbolinks:load', function() {
  // lazyLoadImageForCardProduct();

  toastActive();
  navbarDropdown();            // выпадающие меню
  M.Modal._count = 0;          // иначе 
  onFocusInvalidClassRemove(); // снимаем с input класс invalid по фокусу на этом же поле
  onClicButtonClassRemove()    // снимаем с input класс invalid по нажатию на кнопку выбора картинки
});

document.addEventListener('turbolinks:before-cache', () => {
  Turbolinks.clearCache();
});