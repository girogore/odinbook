import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets= ["likeButton", "likeForm", "likeText"]

  toggleLike() {    
    const regex_likes = /Likes: (\d+)/;
    const match_likes = this.likeTextTarget.innerHTML.match(regex_likes);
    let num_likes = parseInt(match_likes[1]);
    if (this.likeButtonTarget.value == "Like!") {
      this.likeButtonTarget.value = "Unlike!"
      this.likeFormTarget.method = "delete"
      this.likeTextTarget.innerHTML = "Likes: " + (num_likes+1).toString();
    }
    else {
      this.likeButtonTarget.value = "Like!"
      this.likeFormTarget.method = "post"
      this.likeTextTarget.innerHTML = "Likes: " + (num_likes-1).toString();
    }
  }
}
