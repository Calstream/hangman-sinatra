function init()
{
  let keyboard = document.querySelector("#keyboard");
  let i = 0;
  for (i = 0; i < 26; i++)
    {
      let key = document.createElement("div");
      key.className = "key";
      let char = String.fromCharCode(97 + i).toUpperCase();
      key.id = char + "_key"
      key.innerHTML += char;
      key.onclick = function() {
        // TODO
      }
      keyboard.appendChild(key);
    }
  let s = document.querySelector("#s_key");
  s.style.marginLeft = "45px"
}

init();
