{
  let buttons = document.querySelectorAll('[id^="show_comment_"]');
  buttons.forEach(element => {
    element.addEventListener("click", () => {
      element.disabled = true;
    })
  })
}