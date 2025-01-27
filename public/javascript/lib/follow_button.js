{
  let buttons = document.querySelectorAll("follow_button");
  buttons.forEach(element => {
    element.addEventListener("click", () => {
      element.disabled = true;
    })
  })
}