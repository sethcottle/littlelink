// to do:
// - clicking on window does not result in menu closing
// - have menu items shift when drop down is open

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      //IF STATEMENT IS NOT EXECUTING
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

function PRlist() {
  var click = document.getElementById("PR");
  if(click.style.display ==="none") {
    click.style.display ="block";
  } else {
    click.style.display ="none";
  }
}

function PLTlist() {
  var click = document.getElementById("PLT");
  if(click.style.display ==="none") {
    click.style.display ="block";
  } else {
    click.style.display ="none";
  }
}

document.getElementById('PR').addEventListener("click", PRlist);
document.getElementById('PLT').addEventListener("click", PLTlist);
