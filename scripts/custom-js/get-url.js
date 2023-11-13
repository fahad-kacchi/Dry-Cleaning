function getURL(){
	var URL = window.location.href;
	var splitURLByQuestionMark = URL.split("?");
	return splitURLByQuestionMark[1];
}