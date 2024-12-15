function jpostal() {
  $('#zipcode').jpostal({
    postcode: ['#zipcode'],
    address: {
      '#prefecture': '%3',
      '#city': '%4',
      '#town': '%5'
    }
  });
}
$(document).on('turbolinks:load', jpostal);