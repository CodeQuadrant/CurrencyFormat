function getLang() { return (navigator.language || navigator.languages[0]||'en')};


function formatAsCurrency(value =0, currency) {
   if(currency !== ''){
  
  var locale = getLang();
  
  return  value.toLocaleString( locale, {
    style: 'currency',
    currency: currency,
    minimumFractionDigits: 0
    })
   };
};

function addChangeEvent(p_code){
    document.getElementById(p_code).setAttribute("onchange", "currCodeChange(this.id);"); //how do I dynamically set the value of the curr code field?
};
    
    
function currCodeChange(p_code) {
  
    var x = document.querySelectorAll('input[currfield]');
    var i;
    for (i = 0; i < x.length; i++) {
        
        var currCode = document.getElementById(x[i].name).getAttribute("currcodeitem");
        
        if (currCode == p_code){
                apex.item(x[i].name).setValue(runFormat(x[i].name, p_code));
            };
        };
};

function runFormat(p_value, p_code){
    

    var currencyString = apex.item(p_value).getValue(); //Get value of whatever is in the currency field

    var currencyNumber = currencyString.replace(/\D/g,''); //format string value to take out any non-numeric characters. Still is a string but without any letters/symbols

    if(currencyNumber == ''){
        currencyNumber='0';
    }

    var currencyCode = apex.item(p_code).getValue(); //get value of currency code selected
    
    if(currencyCode == ''){
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
		      
        var y = myString.replace(/\D/g,'');
			
        apex.item(p_value).setValue(y);
        
        };
   
};