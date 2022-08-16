const asideFilm= document.querySelectorAll("aside section")
const mainFilm= document.querySelectorAll("article section")
const btSearch= document.querySelector("header button");
const notFound= document.querySelector("article div:last-child");

for (let i=0; i< asideFilm.length; i++){
    asideFilm[i].onclick= function (){
        hideAll()
        mainFilm[i].style.display= "block";
    }
}

function hideAll(){
    mainFilm.forEach(e=>{
        e.style.display= "none";
    });

    notFound.style.display= "none";
}

btSearch.onclick= function (){
    hideAll();
    const val= document.querySelector("header input");
    let res= false;
    mainFilm.forEach(e=>{
        if(e.getAttribute("title").includes(val.value)){
            res= true;
            e.style.display= "block";
        }
    })

    if(!res){
        notFound.style.display= "block";
    }

    val.value= "";
};