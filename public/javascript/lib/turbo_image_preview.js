{
  document.addEventListener("turbo:frame-load", function (e) {
    let imageInput_buttons = document.querySelectorAll('[id^="imageInput_"]');

    imageInput_buttons.forEach(imageInput => {
      const regex = /id="imageInput_([^"]+)"/;
      const match = imageInput.outerHTML.match(regex);
      let button_name = "";
      if (match) {
        button_name = match[1];
      }
      imageInput.onchange = evt => {
        if (imageInput.files) {
          const [file] = imageInput.files
          let imagePreview = document.querySelector("#imagePreview_"+button_name);
          if (file) {
            imagePreview.src = URL.createObjectURL(file);
          }
          else {
            imagePreview.src = "/assets/empty-photo-9bc8f883.png";
          }
        }
      }

      let clearButton = document.querySelector("#clearPreview_"+button_name);
      clearButton.addEventListener("click", () => {
        if (imageInput.files) {
          imageInput.value = "";
          imageInput.dispatchEvent(new Event("change"));
        }
      })
    })
  })
}