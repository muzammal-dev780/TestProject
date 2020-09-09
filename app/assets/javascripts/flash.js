setTimeout(() => {
    $('.alert').fadeOut('slow', () => {
      $(this).remove()
    })
  }, 1500)