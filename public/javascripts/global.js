Turbolinks.start();

$(document).on('turbolinks:load', function() {
  $('select.association').select2({
    theme: 'bootstrap',
    ajax: {
      url: "/autocomplete/association",
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          q: params.term,
          model: this.attr('data-model')
        };
      },
      tokenSeparators: [',', ' '],
      cache: true
    },
    minimumInputLength: 3
  });

  // Fix select2 dropdown position
  $('select').data('select2').on('results:message', function () {
    this.dropdown._positionDropdown();
  });
});
