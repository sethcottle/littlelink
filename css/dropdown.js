// to do:
// - menus need to be clicked twice to open
// - clicking on window does not result in menu closing

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
