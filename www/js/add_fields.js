var index=0;

//------------------------add course---------------------
//Add input by clicking 'plus' sign
function addCourse(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="course"><div class="form-group"><p>Course name</p>'+
  '<input type="text" id="inputLine" class="form-control mult-choice" name="coursesTaught[]" placeholder="Enter course name" aria-describedby="basic-addon2" required></div>'+
  '<p>Semester</p>'+
  '<div class="form-group mult-choice">'+
    '<select class="form-control" name="semestersTaught[]" required>'+
      '<option>Fall</option>'+
      '<option>Spring</option>'+
    '</select>'+
  '</div>'+
  '<p>Level</p>'+
  '<div class="form-group mult-choice">'+
    '<select class="form-control" name="levelsTaught[]" required>'+
      '<option>Bachelor</option>'+
      '<option>Master</option>'+
      '<option>PhD</option>'+
    '</select>'+
  '</div>'+
  '<p>Number of students</p>'+
  '<input type="text" id="inputLine" class="form-control mult-choice" name="studentsTaught[]" size="6" placeholder="Enter number of students" aria-describedby="basic-addon2" pattern="[0-9]+"required>'+
  '<button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addCourse('+"'courses'"+')" value="add">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeCourse(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#course').each(function(){
    index++;
    var newID="course"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeCourse(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add exams---------------------
function addExam(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="exam"><div class="form-group"><p>Courses</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" name="coursesExam[]" placeholder="Enter course name" aria-describedby="basic-addon2" required></div>'+
    '<p>Semester</p>'+
    '<div class="form-group mult-choice">'+
      '<select class="form-control" name="semestersExam[]" required>'+
        '<option>Fall</option>'+
        '<option>Spring</option>'+
      '</select>'+
    '</div>'+
    '<p>Kind of exam</p>'+
    '<div class="form-group mult-choice">'+
      '<select class="form-control" name="exams[]" required>'+
        '<option>Repetition exam</option>'+
        '<option>Final exam</option>'+
      '</select>'+
    '</div>'+
    '<p>Number of students</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" name="studentsExam[]" placeholder="Enter number of students" aria-describedby="basic-addon2" pattern="[0-9]+" required>'+
    '<button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addExam('+"'exams'"+')" value="add">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeExam(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#exam').each(function(){
    index++;
    var newID="exam"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeExam(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add supervised students---------------------
function addStudSup(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="studSup"><div class="form-group"><p>Student name</p>'+
  '<input type="text" id="inputLine" class="form-control mult-choice" name="studentsName[]" placeholder="Enter students name" aria-describedby="basic-addon2" pattern="[A-Za-zА-Яа-яЁё,.`'+"'"+' ]+" required>'+
  '</div><p>Nature of work</p>'+
  '<div class="form-group mult-choice">'+
    '<select class="form-control" name="workNature[]" required>'+
      '<option>Bachelors thesis</option>'+
      '<option>Master thesis</option>'+
      '<option>Summer internship</option>'+
    '</select>'+
  '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addStudSup('+"'studSups'"+')" value="add">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeStudSup(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#studSup').each(function(){
    index++;
    var newID="studSup"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeStudSup(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add reports---------------------
function addReport(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="report"><div class="form-group">'+
  '<p>Student name</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" name="studentReport[]" placeholder="Enter students name" aria-describedby="basic-addon2" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+" required>'+
  '</div>'+
  '<p>Title of report</p>'+
  '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter title of report" aria-describedby="basic-addon2" name="reportTitles[]" required>'+
  '<button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addReport('+"'reports'"+')" value="add">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeReport(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#report').each(function(){
    index++;
    var newID="report"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeReport(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add grants---------------------
function addGrant(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="grant"><div class="form-group">'+
    '<p>Title of project</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter title of project" aria-describedby="basic-addon2" name="grantsTitle[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Grant agency</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of grant agency" aria-describedby="basic-addon2" name="grantsAgency[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Receiveing date</p>'+
    '<input type="date" class="form-control mult-choice" name="receive[]" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Ending date</p>'+
    '<input type="date" class="form-control mult-choice" name="ending[]" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Grant amount</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter the amount of grant" aria-describedby="basic-addon2" name="grantsAmoun[]" pattern="[0-9]+" required>'+
  '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addGrant('+"'grants'"+')">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeGrant(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#grant').each(function(){
    index++;
    var newID="grant"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeGrant(sender){
  var div = document.getElementById(sender);
  div.remove();
}


function addResearch(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="research"><div class="form-group">'+
    '<p>Title of research</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter title of research" aria-describedby="basic-addon2" name="researchesTitle[]" size="6" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+'0-9 ]+"required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Research start </p>'+
    '<input type="date" class="form-control mult-choice" name="researchStart[]" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Research end </p>'+
    '<input type="date" class="form-control mult-choice" name="researchEnd[]" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Source of financing</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter source of financing" aria-describedby="basic-addon2" name="financing[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+"required>'+
  '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new research"'+
  'onClick="addResearch('+"'researches'"+')">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeResearch(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#research').each(function(){
    index++;
    var newID="research"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeResearch(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add publication---------------------
function addPublications(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="publication"><div class="form-group">'+
    '<p>Title of publication</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter title of publication" aria-describedby="basic-addon2" name="publications[]" pattern="[A-Za-zА-Яа-яЁё.,'+"'"+'0-9 ]+" required>'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Type of publications</p>'+
    '<div class="form-group mult-choice">'+
      '<select class="form-control" name="publicationsType[]" required>'+
        '<option>Conference</option>'+
        '<option>Journal</option>'+
      '</select>'+
    '</div>'+
  '</div><div class="form-group">'+
    '<p>Date of publication</p>'+
  '<input type="date" class="form-control mult-choice" name="publicationDate[]" required>'+
  '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new publication"'+
  'onClick="addPublications('+"'publicationsss'"+')">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removePublication(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#publication').each(function(){
    index++;
    var newID="publication"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removePublication(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add patent---------------------
function addPatent(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="patent"><div class="form-group">'+
    '<p>Name of patent</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of patent" aria-describedby="basic-addon2" name="patents[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Country of patent office</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of the country, given patent" aria-describedby="basic-addon2" name="patentsCountries[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
    '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new patent"'+
  'onClick="addPatent('+"'patents'"+')">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removePatent(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#patent').each(function(){
    index++;
    var newID="patent"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removePatent(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add license---------------------
function addLicense(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="license"><div class="form-group">'+
    '<p>License</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of license" aria-describedby="basic-addon2" name="licensesGranted[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+'0-9 ]+">'+
  '</div><button type="button"'+
  'style="background-color: #FFF; border: 0px;"title="Add new license"'+
  'onClick="addLicense('+"'licenses'"+')">'+
  '<i class="material-icons">add</i></button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeLicense(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#license').each(function(){
    index++;
    var newID="license"+index;
    $(this).attr('id',newID);
  });
}

//Remove input by clicking 'cross' sign
function removeLicense(sender){
  var div = document.getElementById(sender);
  div.remove();
}

//------------------------add award---------------------
function addAward(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="article"><div class="form-group">'+
    '<p>Title of article</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter title of article" aria-describedby="basic-addon2" name="articlesDone[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Author of article</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of author" aria-describedby="basic-addon2" name="articleAuthors[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Awarding conference or journal</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of conference or journal" aria-describedby="basic-addon2" name="articlesPublishers[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Wording of award</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter words of award" aria-describedby="basic-addon2" name="awardWords[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Date of award</p>'+
    '<input type="date" class="form-control mult-choice" aria-describedby="basic-addon2" name="awardDate[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
  '</div>'+
    '<button type="button" id="addPublication" style="background-color: white;'+
  'border: 0px;" title="Add new award" onClick="addAward('+"'articles'"+')">'+
    '<i class="material-icons">add</i>'+
  '</button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeLicense(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#article').each(function(){
    index++;
    var newID="article"+index;
    $(this).attr('id',newID);
  });
}

//------------------------add member---------------------
function addMember(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="member"><div class="form-group">'+
    '<p>Name of member</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter member name" aria-describedby="basic-addon2" name="membersName[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Date of membership</p>'+
    '<input type="date" class="form-control mult-choice" aria-describedby="basic-addon2" name="membershipDate[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+']+">'+
  '</div>'+
    '<button type="button" id="addPublication" style="background-color: white;'+
  'border: 0px;" title="Add new membership" onClick="addMember('+"'members'"+')">'+
    '<i class="material-icons">add</i>'+
  '</button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeLicense(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#member').each(function(){
    index++;
    var newID="member"+index;
    $(this).attr('id',newID);
  });
}

//------------------------add prize---------------------
function addPrize(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="prize"><div class="form-group">'+
    '<p>Recipient</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter recipient" aria-describedby="basic-addon2" name="prizeRecipient[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Name of prize</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of prize" aria-describedby="basic-addon2" name="prizeNames[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Granting institution</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of granting institution" aria-describedby="basic-addon2" name="prizeInstitution[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Date of prize</p>'+
    '<input type="date" class="form-control mult-choice" aria-describedby="basic-addon2" name="prizeDate[]">'+
  '</div>'+
    '<button type="button" id="addPublication" style="background-color: white;'+
  'border: 0px;" title="Add new prize" onClick="addPrize('+"'prizes'"+')">'+
    '<i class="material-icons">add</i>'+
  '</button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeLicense(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#prize').each(function(){
    index++;
    var newID="prize"+index;
    $(this).attr('id',newID);
  });
}

//------------------------add collobaration---------------------
function addCompanyCollaboration(container){
  var newDiv = document.createElement('div');
  newDiv.innerHTML='<div id="collaboration"><div class="form-group">'+
    '<p>Name of collaboration company</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter name of company" aria-describedby="basic-addon2" name="companyName[]" pattern="[A-Za-zА-Яа-яЁё0-9.,'+"'"+' ]+">'+
  '</div>'+
  '<div class="form-group">'+
    '<p>Nature of collaboration</p>'+
    '<input type="text" id="inputLine" class="form-control mult-choice" placeholder="Enter nature of collaboration" aria-describedby="basic-addon2" name="colloborationNature[]" pattern="[A-Za-zА-Яа-яЁё,.'+"'"+' ]+" >'+
  '</div>'+
    '<button type="button" id="addPublication" style="background-color: white;'+
  'border: 0px;" title="Add new prize" onClick="addCompanyCollaboration('+"'collaborations'"+')">'+
    '<i class="material-icons">add</i>'+
  '</button><button type="button" style="background-color: #FFF; border: 0px;"'+
  'onClick="removeLicense(this.parentNode.id)"><i class="material-icons">clear</i></button></div>';
  document.getElementById(container).appendChild(newDiv);

  //Change id of the new div
  $('#collaboration').each(function(){
    index++;
    var newID="collaboration"+index;
    $(this).attr('id',newID);
  });
}
