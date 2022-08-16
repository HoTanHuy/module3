const intro = document.getElementById('intro');
const chap1 = document.getElementById('chap1');
const chap2 = document.getElementById('chap2');
const chap3 = document.getElementById('chap3');

function hideAll() {
    intro.style.display = "none";
    chap1.style.display = "none";
    chap2.style.display = "none";
    chap3.style.display = "none";
}

function switchIntro() {
    hideAll();
    return intro.style.display = "block";
}

function switchChap1() {
    hideAll();
    return chap1.style.display = "block";
}

function switchChap2() {
    hideAll();
    return chap2.style.display = "block";
}

function switchChap3() {
    hideAll();
    return chap3.style.display = "block";
}