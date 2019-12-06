/**
 * Слайдер с картинами в header на клиентской части сайта.
 */
function headerCarousel() {
  const carousel = document.querySelector('.carousel');
  if (carousel) {
    const carouselInstances = M.Carousel.init(carousel, {
      duration: 700
    });
    setInterval(() => {
        carouselInstances.next(1);
    }, 4000);
  }
}

/**
 * Активируем с низу выезжающее окно корзины.
 */
function modalFooter() {
  const modalFooter = document.querySelector('#bottom-modal-cart');
  if (modalFooter) {
    M.Modal.init(modalFooter, {
      inDuration: 500,
      outDuration: 500
    });
  }
}

/**
 * Активируем плагин Feature Discovery (круглая форма в нижнем правом углу).
 */
function featureDiscoveryCreate() { 
  const featureDiscovery = document.querySelector('#fdpage');
  if (featureDiscovery) {
    M.TapTarget.init(featureDiscovery, {
      onOpen: function() { // Callback: меняем значек кнопки на крестик.
        document.querySelector('.tap-target-origin i').innerHTML = 'close';
        insertTimeZoneInInput('#timezone-tap-target');
      },
      onClose: function() { // Callback: меняем значек кнопки на телефон.
        document.querySelector('.tap-target-origin i').innerHTML = 'phone_in_talk';
      }
    });
  }
}

function insertTimeZoneInInput(id_selector) {
  document.querySelector(id_selector).value = new Date().toString().split(' ')[6].slice(1, -1);
}


/**
 * Открыть окно Feature Discovery.
 */
function openFeatureDiscovery() {
  const featureDiscovery = document.querySelector('#fdpage');
  if (featureDiscovery) {
    M.TapTarget.getInstance(featureDiscovery).open();
  }
}

/**
 * Закртыть окно Feature Discovery.
 */
function closeFeatureDiscovery(callback) {
  const featureDiscovery = document.querySelector('#fdpage');
  if (featureDiscovery) {
    M.TapTarget.getInstance(featureDiscovery, {onClose: callback()}).close();
  }
}

/**
 * Включаем Sidebar.
 */
function sidebar() {
  const sidebar = document.querySelector('.sidenav');
  if (sidebar) {
    M.Sidenav.init(sidebar);
  }
}

/*
 * Открытие Sidebar'а.
 */
function openSidebar() {
  const sidebar = document.querySelector('.sidenav');
  if (sidebar) {
    let sidebarInstance = M.Sidenav.getInstance(sidebar);
    document.querySelector('.sidenav-click').onclick = function(event) {
      event.preventDefault();
      sidebarInstance.open();
    }
  }
}

/**
 * Закрытие Sidebar'а.
 */
function closeSidebar() {
  const sidebar = document.querySelector('.sidenav');
  if (sidebar) {
    let instance = M.Sidenav.getInstance(sidebar);
    instance.close();
  }
}

/**
 * Включаем слайдер с выполненными работами.
 */
function serveceSlider() {
  const serveceSlider = document.querySelector('.service-slider');

  if (serveceSlider && serveceSlider.children.length != 0) {
    const serveceSliderInstance = M.Carousel.init(serveceSlider, {
      fullWidth: true,
      duration: 400
    });
    setInterval(() => {
      serveceSliderInstance.next(1);
    }, 5000);
  }
}

/**
 * Включаем параллакс.
 */
function parallax() {
  const parallax = document.querySelectorAll('.parallax');
  M.Parallax.init(parallax);
}

/**
 * Отправка круглой формы.
 */
function callCreateAjaxSend(event) {
  if (event.detail[0]['controller'] == 'call#create') {
    closeFeatureDiscovery(function() {
      toastActive('Запрос отправлен');
      
      // чистим поля
      event.target[2].value = '';
      event.target[3].value = '';
      event.target[4].checked = false;

      // перезагружаем формы
      M.updateTextFields();
    });
  }
}

/**
 * Выводим ошибки валидации при отправке круглой формы.
 */
function callCreateValidateError(event) {
  if (event.detail[0]['controller'] == 'call#create') {
    let nameErrorMessage = event.detail[0]['errors']['name'];
    let telephoneErrorMessage = event.detail[0]['errors']['telephone'];
    let confirmErrorMessage = event.detail[0]['errors']['confirm'];
    
    if (nameErrorMessage) {
      document.querySelector('#name').classList.add('invalid');
      document.querySelector('#errors-call-name').setAttribute('data-error', nameErrorMessage[0]);
    }
    if (telephoneErrorMessage) {
      document.querySelector('#telephone').classList.add('invalid');
      document.querySelector('#errors-call-telephone').setAttribute('data-error', telephoneErrorMessage[0]);
    }
    if (confirmErrorMessage) {
      document.querySelector('#errors-call-confirm').style.color = 'red';
    }
  }
}

/**
 * Меняем цвет на чекбоксе в круглой форме после ошибки при нажатии.
 */
function checkBoxErrorOff(id, color) {
  let checkbox = document.querySelector(id);
  if (checkbox) {
    checkbox.onclick = function() {
      if (this.style.color == 'red') {
        this.style.color = color;
      }
    }
  }
}

/* ********* КОРЗИНА ********* */

/**
 * Добавить в корзину
 */
function addProductSuccess(event) {
  if (event.detail[0]['action'] == 'add_product') {
    let message = `Товар "${event.detail[0]['name']} добавлен в корзину`;
    toastActive(message);
  }
}


/**
 * Минус 1 продукт
 */
function minusProduct() {
  const minusButtons = document.querySelectorAll('.minus-product');
  if (minusButtons) {
    minusButtons.forEach(button => {
      button.onclick = function(event) {
        event.preventDefault();
        Rails.ajax({
          type: 'POST',
          url: this.getAttribute('href'),
          success: (response) => {
            document.querySelector('#tottal-price').innerHTML = response['tottal_price'];
            if (response['count'] == 0) {
              this.closest('.product-flexbox').remove();
            } else {
              this.nextElementSibling.innerHTML = response['count'];
              document.querySelector('#tottal-price').innerHTML = response['tottal_price'];
            }
          },
          error: (error) => {}
        });
      }
    });
  }
}

/**
 * Плюс 1 продукт
 */
function plusProduct() {
  const plusButtons = document.querySelectorAll('.plus-product');
  if (plusButtons) {
    plusButtons.forEach(button => {
      button.onclick = function(event) {
        event.preventDefault();
        Rails.ajax({
          type: 'POST',
          url: this.getAttribute('href'),
          success: (response) => {
            this.previousElementSibling.innerHTML = response['count'];
            document.querySelector('#tottal-price').innerHTML = response['tottal_price'];
          },
          error: (error) => console.error(error)
        });
      }
    });
  }
}

/**
 * Удалеение всего количества товара одного вида
 */
function removeProducts() {
  let removeButton = document.querySelectorAll('.remove_products');
  if (removeButton) {
    removeButton.forEach(element => {
      element.onclick = function(event) {
        event.preventDefault();
        Rails.ajax({
          type: 'POST', 
          url: this.getAttribute('href'),
          success: (response) => {
            document.querySelector('#tottal-price').innerHTML = response['tottal_price'];
            this.closest('.product-flexbox').remove();
          },
          error: (error) => console.error(error)
        });
      }
    });
  }
}

/**
 * Подгружаем товары в корзину AJAX'ом
 */
function loadAjaxProducts() {
  Rails.ajax({
    type: 'POST', 
    url: '/cart',
    success: function(response) {
      document.querySelector('#bottom-modal-cart .container').innerHTML = response.body.innerHTML
    },
    error: function(response) {
      console.log(response);
    }
  });
}

/**
 * Отслеживающая состояние DOM-элемента корзины
 */
function onEmptyCart() {
  let cart = document.querySelector('#cart');
  if (cart) {
    let modal = document.querySelector('.modal-cart');
    let html = [
      '<i class="small material-icons modal-close">clear</i>',
      '<h3>Корзина пуста</h3>',
      '<p class="empty-cart-message">Но у нас много классных изделий :-)</p>',
    ];
    cart.onclick = function() {
      setInterval(() => {
        if (this.childElementCount == 0) {
          modal.innerHTML = html.join('');
        }
      }, 200);
    }
  }
}

/**
 * Активируем с низу выезжающее окно корзины
 */
function modalFooter() {
  const modalFooter = document.querySelector('#bottom-modal-cart');
  if (modalFooter) {
    M.Modal.init(modalFooter, {
      inDuration: 500,
      outDuration: 500,
      onOpenStart: function() {
        loadAjaxProducts();
      }, 
      onOpenEnd: function() {
        minusProduct();    // устанавливаем события клика на значек -
        plusProduct();     // уствнавливаем событие клика на зеачек +
        removeProducts();  // устанавливаем на собыите клика значек trash
        onEmptyCart();     // отслеживание DOM-элементов товаров в корзине
      },
      inDuration: 600,
    });
  }
}

/* ********* ЗАЯВКА НА ПОКУПКУ УНИКАЛЬНОГО ТОВАРА ********* */

/**
 * Модальное окно заказа для уникального товара
 */
function orderModal() {
  const orderModal = document.querySelector('#order-modal');
  M.Modal.init(orderModal, {
    onOpenStart: function() {
      insertTimeZoneInInput('#timezone-order-modal');
    }
  });
}

/**
 * Отправка формы с заказам на уникальный товар.
 */
function orderCallCreateAjaxSend(event) {
  if (event.detail[0]['controller'] == 'order_call#create') {
    closeModal(function() {
      toastActive('Запрос отправлен');

      // чистим поля
      event.target[4].value = '';
      event.target[5].value = '';
      event.target[6].checked = false;

      // перезагружаем формы
      M.updateTextFields();
    });
  }
}

/**
 * Выводим ошибки валидации при отправке формы с заказам на уникальный товар.
 */
function orderCallCreateValidateError(event) {
  if (event.detail[0]['controller'] == 'order_call#create') {
    let nameErrorMessage = event.detail[0]['errors']['name'];
    let telephoneErrorMessage = event.detail[0]['errors']['telephone'];
    let confirmErrorMessage = event.detail[0]['errors']['confirm'];
    if (nameErrorMessage) {
      document.querySelector('#name_order_call').classList.add('invalid');
      document.querySelector('#errors-order-call-name').setAttribute('data-error', nameErrorMessage[0]);
    }
    if (telephoneErrorMessage) {
      document.querySelector('#telephone_order_call').classList.add('invalid');
      document.querySelector('#errors-order-call-telephone').setAttribute('data-error', telephoneErrorMessage[0]);
    }
    if (confirmErrorMessage) {
      document.querySelector('#errors-order-call-confirm').style.color = 'red';
    }
  }
}

/**
 * Закртыть модальное окно.
 */
function closeModal(callback) {
  const modal = document.querySelector('#order-modal');
  if (modal) {
    M.Modal.getInstance(modal, { onClose: callback() }).close();
  }
}

document.addEventListener('ajax:success', function(event) {
  callCreateAjaxSend(event);      // отправляем круглую форму
  addProductSuccess(event);
  orderCallCreateAjaxSend(event);
});

document.addEventListener('ajax:error', function(event) {
  callCreateValidateError(event); // выводим ошибки для круглой формы
  orderCallCreateValidateError(event);
});

document.addEventListener('turbolinks:load', function() {
  headerCarousel();                                          // слайдере с картинами
  modalFooter();                                             // модальное окно корзины
  featureDiscoveryCreate();                                  // включаем круглую форму в нижнем правом угле
  sidebar();                                                 // включаем sidebar
  openSidebar();
  closeSidebar();
  parallax();                                                // включаем параллакс
  serveceSlider();                                           // слайдер с демонстрационными работами
  checkBoxErrorOff('#errors-call-confirm', 'white');         // снимаем с чекбокса красное выделение
  checkBoxErrorOff('#errors-order-call-confirm', '#9e9e9e');
  document.querySelectorAll('.side-link').forEach(element => {
    element.onclick = (event) => {
      event.stopPropagation();
      closeSidebar();
    };
  });
  document.querySelector('#menu').onclick = (event) => {
    event.stopPropagation();
    openFeatureDiscovery();
  };
  orderModal();
  seachFieldAutocomplete({
    url: '/shop/search-products', 
    outputBodyIdSelector: '#search-result-client', 
    outputRequestIdSelector: '#search-request-client',
    getMethod: true
  });
  removeProducts(); // только для страницы заказа
});

