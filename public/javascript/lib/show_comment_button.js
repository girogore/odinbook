{
  let buttons = document.querySelectorAll('[id^="show_comment_"]');
  buttons.forEach(element => {
    element.addEventListener("click", () => {
      const regex_show = /Show Comments/;
      const match_show = element.innerHTML.match(regex_show);
      if (match_show) {
        const regex_post = /id="show_comment_([^"]+)"/;
        post_name = element.outerHTML.match(regex_post)[1];
        element.innerHTML = "Hide Comments";
        element.href = "posts/"+post_name+"/comments";
      }
      else {
        turbo_frame = element.dataset.turboFrame;    
        let frame = document.querySelector("#"+turbo_frame)
        number_comments = frame.childElementCount-1;
        
        // Set button text, stop the redirect, clear frame
        element.innerHTML = "Show Comments ("+number_comments+")";
        element.href = "javascript:void(0)";
        frame.innerHTML = "";
      }
    })
  })
}