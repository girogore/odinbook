{
  let buttons = document.querySelectorAll('[id^="show_comment_"]');
  buttons.forEach(element => {
    element.addEventListener("click", () => {
      const regex = /Show Comments/;
      const match = element.innerHTML.match(regex);
      if (element.dataset.val == undefined) element.dataset.val = element.innerHTML;
      if (match) {
        const regex2 = /id="show_comment_([^"]+)"/;
        const match2 = element.outerHTML.match(regex2);
        post_name = match2[1];
        element.innerHTML = "Hide Comments";
        element.href = "posts/"+post_name+"/comments";
        //post_comments_path(post_id: post.id)
      }
      else {
        element.innerHTML = element.dataset.val;
        turbo_frame = element.dataset.turboFrame;    
        element.href = "javascript:void(0)";    
        let frame = document.querySelector('#'+turbo_frame)
        frame.innerHTML = "";
        // post_comments_path(post_id: post.id)
      }
    })
  })
}