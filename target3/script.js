/ This is a closure function https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-closure-b2f0d2152b36
(function() {

  let input_fields = document.getElementsByTagName("input");
  let name_field = input_fields.item('name');
  let phno_field = input_fields[1];
  let email_field = input_fields[2];

  let select_fields = document.getElementsByTagName("select");
  let dept1_field = select_fields[0];
  let dept2_field = select_fields[1];

  var initialize = function() {
    /*
      1. Add all your event bindings here. Please avoid binding events inline and add your event listeners here.
      onSubmit callback
      disableDuplicateSecondaryDepartment callback,...
    */

    var reg_form = document.forms.item(0); 
    reg_form.addEventListener('submit', onSubmit);

    dept1_field.addEventListener('change', disableDuplicateSecondaryDepartment);
    
  };

  var disableDuplicateSecondaryDepartment = function() {
    // 2. in department2, Should disable the option selected in department1

    for(let i=0;i<dept2_field.length;i+=1)
    {
      if(dept2_field[i].value===dept1_field.value)
        {
          dept2_field[i].disabled=true;
        }
      else
        {
          dept2_field[i].disabled=false;
        }
    }
    
  }

  var constructData = function() {
    var data = {};

    // 3. Construct data from the form here. Please ensure that the keys are the names of input elements

    data[name_field.name]=name_field.value;
    data[phno_field.name]=phno_field.value;
    data[email_field.name]=email_field.value;
    data[dept1_field.name]=dept1_field.value;
    data[dept2_field.name]=dept2_field.value;

    return data;
  }

  var validateResults = function(data) {
    var isValid = true;

    // 4. Check if the data passes all the validations here
    var special_chars = /[ !#$%^&*()_+\-=\[\]{};':"\\|,<>\/?]/;

    if(data[name_field.name].length>100){
      isValid=false;
    } else if(data[phno_field.name].length>10){
      isValid=false;
    } else if(!data[email_field.name].endsWith("@college.edu")){
      isValid=false;
    } else if(special_chars.test(data[email_field.name])){
      isValid=false;
    } else if(dept1_field.value===dept2_field.value){
	    isValid=false;	
	  }

    return isValid;
  };

  var onSubmit = function() {

    event.preventDefault();
    var data = constructData();

    //console.log(data);

    if (validateResults(data)) {
      printResults(data);
    } else {
      var resultsDiv = document.getElementById("results");
      resultsDiv.innerHTML = '';
      resultsDiv.classList.add("hide");
    }
  };

  var printResults = function(data) {
    var constructElement = function([key, value]) {
      return `<p class='result-item'>${key}: ${value}</p>`;
    };

    var resultHtml = (Object.entries(data) || []).reduce(function(innerHtml, keyValuePair) {
      debugger
      return innerHtml + constructElement(keyValuePair);
    }, '');
    var resultsDiv = document.getElementById("results");
    resultsDiv.innerHTML = resultHtml;
    resultsDiv.classList.remove("hide");
  };

  /*
    Initialize the javascript functions only after the html DOM content has loaded.
    This is to ensure that the elements are present in the DOM before binding any event listeners to them.
  */
  document.addEventListener('DOMContentLoaded', initialize);
})();