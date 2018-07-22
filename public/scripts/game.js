function init_en()
{
  let keyboard = document.querySelector("#keyboard");
  let i = 0;
  for (i = 0; i < 26; i++)
    {
      let key = document.createElement("input");
      key.className = "key";
      key.className += " button";
      key.className += " en";
      let char = String.fromCharCode("A".charCodeAt(0) + i).toUpperCase();
      key.id = char + "_key"
      key.innerHTML += char;
      key.onclick = function() {
        this.classList.toggle("used_letter");
        this.disabled = true;
      }
      keyboard.appendChild(key);
    }
  let s = document.querySelector("#s_key");
  s.style.marginLeft = "45px"
}

function init_ru()
{
  let keyboard = document.querySelector("#keyboard");
  let i = 0;
  for (i = 0; i < 32; i++)
    {
      let key = document.createElement("input");
      key.className = "key";
      key.className += " button";
      key.className += " ru";
      let char = String.fromCharCode("А".charCodeAt(0) + i).toUpperCase();
      key.id = "key_" + i;
      key.value += char;
      key.type = "button";
      key.enabled = true;
      key.onclick = function() {
        this.classList.toggle("used_letter");
        this.disabled = true;
      }
      keyboard.appendChild(key);
    }
  for(i = 0; i < 11; i++)
  {
    let top_row_key = document.querySelector("#key_" + i);
    top_row_key.style.marginTop = "30px"
  }
  let ts = document.querySelector("#key_22");
  ts.style.marginLeft = "45px"
}

init_ru();

let ii = 1;

function hang()
{
  let progress = document.getElementById("progress");
  if (ii > 8)
    ii = 1;
  progress.className = "hangman" + ii++;
}

document.addEventListener("click", hang);
