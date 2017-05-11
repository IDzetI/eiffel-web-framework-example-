var xmlhttp;
var array=[];

initializeRequest();

function initializeRequest(){

  if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
     xmlhttp=new XMLHttpRequest();
  }
  else
  {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
}

function toReport(){
  window.location.href="../index.html";
}

function toAdmin(){
  window.location.href="/templates/admin.html";
}

function checkAdmin(){
  var login = document.getElementById('login').value;
  var pass = document.getElementById('pass').value;
  //alert(pass);
  $.ajax({
  	type:"POST",
  	url:"/test/admin.txt",
    data:{"login":login,"pass":pass},
  	success: function(data){
		alert(data);
  		if(data=="true"){
        window.location.href="/templates/main_admin.html";
      } else{
        //alert("Wrong login and/or password");
      }
  	}
  });
}

function getStudentsNumber(){
  var select = document.getElementById('labs1');
  var lab = select.options[select.selectedIndex].text;
  $.ajax({
  	type:"POST",
  	url:"/test/get_students.txt",
    data:{"name":lab},
  	success: function(data){
  		document.getElementById('responses').innerHTML="There are "+data+" students supervised by "+lab;
  	}
  });
}

function getAllPublications(){
  $.ajax({
  	type:"POST",
  	url:"/test/get_publications.txt",
  	success: function(data){
      var array = data.split(';');
      var el = document.getElementById('responses');
      el.innerHTML="These are all publications by today:</br>"
      $.each(array, function(index, value){
        el.innerHTML = el.innerHTML + value + "</br>";
      });
  	}
  });
}

function getCollaborationNumber(){
  var select = document.getElementById('labs2');
  var lab = select.options[select.selectedIndex].text;
  $.ajax({
  	type:"POST",
  	url:"/test/get_collaborations.txt",
    data:{"name":lab},
  	success: function(data){
  		document.getElementById('responses').innerHTML="There are "+data+" research collaborations done by "+lab;
  	}
  });
}

function getCouresByDate(){
  var select = document.getElementById('labs3');
  var lab = select.options[select.selectedIndex].text;
  var startDate = document.getElementById('courseIn').value;
  var endDate = document.getElementById('courseEnd').value;
  $.ajax({
    type:"POST",
    url:"/test/get_coursesbydate.txt",
    data:{"name":lab,"in":startDate,"end":endDate},
    success: function(data){
      var array = data.split(';');
      var answer = document.getElementById('responses');
      answer.innerHTML="There are courses tought by "+lab+" between "+startDate+" and "+endDate+":</br>";
      $.each(array, function(index, value){
        answer.innerHTML = answer.innerHTML + value + "</br>";
      });
    }
  });
}

function getCumulativeInfo(){
  var select = document.getElementById('labs4');
  var lab = select.options[select.selectedIndex].text;
  $.ajax({
    type:"POST",
    url:"/test/get_cumulativeinfo.txt",
    data:{"name":lab},
    success: function(data){
      var array = data.split(';');
      var answer = document.getElementById('responses');
      answer.innerHTML="There is cumulative info about "+lab+":</br>";
      $.each(array, function(index, value){
        answer.innerHTML = answer.innerHTML + value + "</br>";
      });
    }
  });
}

function getPublicationsByDate(){
  var startDate = document.getElementById('publicationIn').value;
  var endDate = document.getElementById('publicationEnd').value;
  $.ajax({
  	type:"POST",
  	url:"/test/get_allpublications.txt",
    data:{"in":startDate,"end":endDate},
  	success: function(data){
      var array = data.split(';');
      var el = document.getElementById('responses');
      el.innerHTML="These are all publications between "+startDate+" and "+endDate+":</br>"
      $.each(array, function(index, value){
        el.innerHTML = el.innerHTML + value + "</br>";
      });
  	}
  });
}

function getAllStudents(){
  $.ajax({
  	type:"POST",
  	url:"/test/get_allstudents.txt",
  	success: function(data){
  		document.getElementById('responses').innerHTML="There are "+data+" supervised students in IU by now.";
  	}
  });
}

function getLabs(){
  $.ajax({
    type:"POST",
    url:"/test/get_labs.txt",
    success: function(data){
      array = data.split(';');
    }
  });
}

function loadLabs(labs){
  var select = document.getElementById(labs);
  $.each(array, function(index,value){
    var newOpt = document.createElement('option');
    newOpt.innerHTML=value;
    select.appendChild(newOpt);
  });
}
