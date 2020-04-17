function getLang() { return (navigator.language || navigator.languages[0]||'en')};  //get browser language, default to english is nothing found


function formatAsCurrency(value =0, currency) {
   if(currency !== ''){
  
       var locale = getLang();
  
  return  value.toLocaleString( locale, {    //set input to currency with locale set to language from getLang()
    style: 'currency',
    currency: currency,
    minimumFractionDigits: 0
    })
   };
};

function addChangeEvent(p_code){
    document.getElementById(p_code).setAttribute("onchange", "currCodeChange(this.id);");  //add JS to that when the currency code field is updated the field will update automatically
};
    
    
function currCodeChange(p_code) {
  
    var x = document.querySelectorAll('input[currfield]');
    var i;
    for (i = 0; i < x.length; i++) {
        
        var currCode = document.getElementById(x[i].name).getAttribute("currcodeitem");
        
        if (currCode == p_code){
                apex.item(x[i].name).setValue(runFormat(x[i].name, p_code));   //check if currency code is changed, if so update the value
            };
        };
};

function runFormat(p_value, p_code){
    

    var currencyString = apex.item(p_value).getValue(); //Get value of whatever is in the currency field

    var currencyNumber = currencyString.replace(/[^-\d*[0-9]/g,''); //format string value to take out any non-numeric characters excluding negative sign.

    if(currencyNumber == ''){
        currencyNumber='0';
    }

    var currencyCode = apex.item(p_code).getValue(); //get value of currency code selected
    
    if(currencyCode == ''){   //default to USD for Currency
        currencyCode='USD';
    }
    
    return formatAsCurrency(parseInt(currencyNumber),currencyCode); //set the value for the item using the JS function. 
                                                                    //ParseInt needed as currencyNumber is still technically a string before parseInt
};

function submitAsNumber(){
    
    var x = document.querySelectorAll('input[currfield]');
    
    var i;
    
    for (i = 0; i < x.length; i++) {
        
        var p_value = document.getElementById(x[i].name).getAttribute("name");
            
        var myString = apex.item(p_value).getValue();
		      
        var y = myString.replace(/\D/g,''); //change back into number
			
        apex.item(p_value).setValue(y);  //set value 
        
        };
   
};


function getLastNumberIdx(input) {
  
  var dgts = input.replace(/\D/g,'');  //turn into number
  
  var last_num = dgts.substring(dgts.length, dgts.length-1);  //get value of last number in dgts
  
  var n = input.lastIndexOf(last_num);  //find last position of value from above
  
    return n+1;
  
};

function setSelectionRange(input, selectionStart, selectionEnd) {
  if (input.setSelectionRange) {
    input.focus();
    input.setSelectionRange(selectionStart, selectionEnd);
  }
  else if (input.createTextRange) {
    var range = input.createTextRange();
    range.collapse(true);
    range.moveEnd('character', selectionEnd);
    range.moveStart('character', selectionStart);
    range.select();
  }
}

function setCaretToPos (input, pos) {
   setSelectionRange(input, pos, pos);
}
