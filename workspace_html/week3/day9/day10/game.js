
let mole = document.getElementById("mole"); //두더지
let time = 30; //게심시간
let gameInterval; //inverval id
let score =0; //게임점수
let scoreSpan = document.getElementById("score"); //점수
let timeSpan =document.getElementById("time"); //시간
function randomPosition(){
    let x = Math.floor(Math.random() * 500); //500px 이내 x위치
    let y = Math.floor(Math.random() * 500); //500px 이내 y위치
    mole.style.left = x + "px";
    // javascript 템플릿 리터럴 (es6부터 사용)
    mole.style.top = `${y}px`; // 작은 따옴표가 아닌 숫1 왼족에 있는

}
//두더지가 나타나는 함수
function showMole(){
    randomPosition();
    mole.style.display = 'block';
    setTimeout(hideMole, 1000); // 1초뒤에 사라지도록
}
function hideMole(){
    mole.style.display = 'none';
}

mole.addEventListener('click', function(){
    score ++;
    scoreSpan.innerText = score;
    hideMole();
});

gameInterval =setInterval(showMole, 2000); //게임 시작 2초마다 나타나도록!

//시간 감소
let timeInterval = setInterval(()=>{
    time --;
    timeSpan.innerText =time;
    if(time < 0){
        clearInterval(gameInterval); // 두더지 나타남중지
        clearInterval(timeInterval); // 시간 감소중지
        alert(`게임 오버!! 당신의 점수는 ${score}`);
    }
}, 1000);
