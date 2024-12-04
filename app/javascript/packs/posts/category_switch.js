document.addEventListener("turbolinks:load", () => {
  const categories = document.querySelectorAll(".category-item");

  categories.forEach(categoryElement => {
    const categoryValue = parseInt(categoryElement.dataset.category, 10); 

    switch (categoryValue) {
      case 0: // "buy"
        categoryElement.classList.add("category-buy");
        break;
      case 1: // "sale"
        categoryElement.classList.add("category-sale");
        break;
      case 2: // "rental"
        categoryElement.classList.add("category-rental");
        break;
      case 3: // "local_information"
        categoryElement.classList.add("category-local-information");
        break;
      default:
        categoryElement.classList.add("category-unknown");
    }
  });
});
