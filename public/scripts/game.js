function init(language)
{
  let keyboard = document.querySelector("#keyboard");
  let i = 0;
  if (language == "en")
  {
    for (i = 1; i <= 26; i++)
    {
      /*let form = document.createElement("form");
      form.action = "/game";
      form.method = "get";
      let child = create_key(i, true);
      form.id = "form" + child.id;
      form.appendChild(child);
      keyboard.appendChild(form);*/
      keyboard.appendChild(create_key(i, true));
    }
    let s = document.querySelector("#key_19");
    s.style.marginLeft = "45px";
  }
  else
  {
    for (i = 1; i <= 32; i++)
        keyboard.appendChild(create_key(i, false));
    for(i = 1; i <= 11; i++)
    {
      let top_row_key = document.querySelector("#key_" + i);
      top_row_key.style.marginTop = "30px"
    }
    let ts = document.querySelector("#key_23");
    ts.style.marginLeft = "45px"
  }
}

function create_key(i, is_en)
{
  let key = document.createElement("input");
  key.className = "key";
  key.className += " button";
  key.name = "letter";
  let char;
  if (is_en)
  {
    key.className += " en";
    char = String.fromCharCode("A".charCodeAt(0) + i - 1).toUpperCase();
    key.id = "key_" + i;
  }

  else
  {
    key.className += " ru";
    char = String.fromCharCode("А".charCodeAt(0) + i - 1).toUpperCase();
    key.id = "key_" + i;
  }

  //key.innerHTML += char;
  //key.setAttribute("href", "http://www.google.com");
  key.value += char;
  key.type = "submit";
  key.disabled = false;
  key.onclick = function()
  {
    this.className += " used_letter";
    this.disabled = true;
    //document.getElementById("form" + this.id).submit();
    let url = "/game?letter=" + i
    $('#game').load(url + ' #game');
    //location.href = "/game?letter=" + i;
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

//document.addEventListener("click", hang);
