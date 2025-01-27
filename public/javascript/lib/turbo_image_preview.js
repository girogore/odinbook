{
  document.addEventListener("turbo:frame-load", function (e) {
    let imageInput = document.querySelector(".imageInput");
    let imagePreview = document.querySelector(".imagePreview");
    let clearButton = document.querySelector(".clear");
    imageInput.onchange = evt => {
      if (imageInput.files) {
        const [file] = imageInput.files
        if (file) {
          imagePreview.src = URL.createObjectURL(file);
        }
        else {
          imagePreview.src = "/assets/empty-photo-9bc8f883.png";
        }
      }
    }

    clearButton.addEventListener("click", () => {
      if (imageInput.files) {
        imageInput.value = "";
        imageInput.dispatchEvent(new Event("change"));
      }
    })

  })
}