{
  let imageInput = document.querySelector(".imageInput");
  let imagePreview = document.querySelector(".imagePreview")
  imageInput.onchange = evt => {
    const [file] = imageInput.files
    if (file) {
      imagePreview.src = URL.createObjectURL(file)
    }
  }
}