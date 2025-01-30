import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  newForm() {
    const regex_create = /Create Comment/;
    const match_create = this.element.innerHTML.match(regex_create);
    if (match_create) {
      const regex_post = /id="create_comment_button_([^"]+)"/;
      let post_name = this.element.outerHTML.match(regex_post)[1];
      this.element.innerHTML = "Stop Commenting";
      this.element.href = "/posts/"+post_name+"/comments/new";
    } 
    else {
    // Set button text, stop the redirect, clear frame
    this.element.innerHTML = "Create Comment";
    this.element.href = "javascript:void(0)";
    let turbo_frame = this.element.dataset.turboFrame;
    let frame = document.querySelector("#"+turbo_frame)
    frame.innerHTML = "";
    }
  }
  showAll() {
    const regex_show = /Show Comments/;
    const match_show = this.element.innerHTML.match(regex_show);
    if (match_show) {
      const regex_post = /id="show_comment_([^"]+)"/;
      let post_name = this.element.outerHTML.match(regex_post)[1];
      this.element.innerHTML = "Hide Comments";
      this.element.href = "/posts/"+post_name+"/comments";
    }
    else {
      let turbo_frame = this.element.dataset.turboFrame;    
      let frame = document.querySelector("#"+turbo_frame)
      let number_comments = frame.childElementCount-1;
      
      // Set button text, stop the redirect, clear frame
      this.element.innerHTML = "Show Comments ("+number_comments+")";
      this.element.href = "javascript:void(0)";
      frame.innerHTML = "";
    }
  }
}