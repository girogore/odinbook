import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["imagePreview", "imageInput"]

  update() {    
    console.log("*****");
    
    let imageInput = this.imageInputTarget
    let imagePreview = this.imagePreviewTarget   
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

  clearImage() {
    let imageInput = this.imageInputTarget
    if (imageInput.files) {
      imageInput.value = "";
      this.update();
    }
  }

  clear() {
    this.imagePreviewTarget.src = "/assets/empty-photo-9bc8f883.png";
    this.element.reset();
  }
}