function init(language)
{
  let keyboard = document.querySelector("#keyboard");
  let i = 0;
  if (language == "en")
  {
    for (i = 0; i < 26; i++)
      keyboard.appendChild(create_key(i, true, language));
    let s = document.querySelector("#s_key");
    s.style.marginLeft = "45px";
  }
  else
  {
    for (i = 0; i < 32; i++)
        keyboard.appendChild(create_key(i, false));
    for(i = 0; i < 11; i++)
    {
      let top_row_key = document.querySelector("#key_" + i);
      top_row_key.style.marginTop = "30px"
    }
    let ts = document.querySelector("#key_22");
    ts.style.marginLeft = "45px"
  }
}

function create_key(i, is_en, lan)
{
  let key = document.createElement("button");
  key.className = "key";
  key.className += " button";
  let char;
  if (is_en)
  {
    key.className += " en";
    char = String.fromCharCode("A".charCodeAt(0) + i).toUpperCase();
    key.id = char + "_key"
  }

  else
  {
    key.className += " ru";
    char = String.fromCharCode("А".charCodeAt(0) + i).toUpperCase();
    key.id = "key_" + i;
  }

  key.innerHTML += char;
  //key.innerHTML += lan;
  key.type = "button";
  key.disabled = false;
  key.onclick = function()
  {
    this.className += " used_letter";
    this.disabled = true;
  }
  return key;
}

let ii = 1;

function hang()
{
  let progress = document.getElementById("progress");
  if (ii > 8)
    ii = 1;
  progress.className = "hangman" + ii++;
}

document.addEventListener("click", hang);
