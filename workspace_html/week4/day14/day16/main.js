function SetCookie(name,val,expireDate){
    let cookieStr = name + "=" +escape(val) +
    // 날자가 없으면 "" 있으면 ()내용
    ((expireDate ==null)? "" : ("; expires"+expireDate.toUTCString()));
    document.cookie =cookieStr;
}
function GetCookie(name){
    let str = name + "=";
    //쿠키는 속성별 구분됨 ; <-- 로함
    let pairs = document.cookie.split(";");
    for(let i =0; i < pairs.length; i++){
        let pair = pairs[i].trim();
        // key =value <--로 저장되어 있기 때문에 =로분리
        let unit = pair.split("=");
        if(unit[0] == name){
            return unescape(unit[1]);
        } 
    
    
    }
}