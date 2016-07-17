var tableinput = [];
var componentvalues = [];
var materialstable = [];
var materialvalues = [];
var values = [];
var tasksTemp = [];
var tasksFinal = [];
var schedulevalue = [];
var taskValue = [];

var powNumber = 1;


$(function () {
    $('#proposalForm').stepy({
        backLabel: 'Previous',
        block: true,
        nextLabel: 'Next',
        titleClick: true,
        titleTarget: '.stepy-tab'
    });
});

function addRowForWorks() {
    //debugger;

    var table = document.getElementById("powTable");
    var rowCount = table.rows.length;
    var row = table.insertRow(-1);
    var cell1 = row.insertCell(-1);
    var cell2 = row.insertCell(-1);

    var sel = document.createElement('select')
    sel.setAttribute("id", "worksSelect-" + powNumber);
    sel.setAttribute("class", "worksSelect");
    sel.setAttribute("name", "works");
    var ok = document.createElement('button');
    sel.setAttribute("id", "worksOk-" + powNumber)

    var button = document.createElement('button');
    button.setAttribute("id", "worksButton-" + powNumber);
    button.setAttribute("class", "worksSelect");
    button.setAttribute("name", "works");
    
    $(button).hide();
    
    $(sel).change(function () {
        $(sel).hide();
        $(button).show();
    });
    
    $(button).dblclick(function(){
       $(button).hide();
       $(sel).show();
    });
    
    var t = document.createTextNode(powNumber);

    var option2 = document.createElement("option");
    option2.setAttribute('hidden', true);
    option2.text = 'Select Works';
    sel.appendChild(option2);


    for (var i = 0; i < worksList.length; i++) {
        var option = document.createElement("option");
        option.setAttribute("value", worksList[i].id);
        option.text = worksList[i].name;
        sel.appendChild(option);
    }

    var option = document.createElement("option");
    option.setAttribute("value", "new");
    option.text = "New...";
    sel.appendChild(option);

    cell1.appendChild(t);
    cell2.appendChild(sel);
    cell2.appendChild(button);
    powNumber++;

}

$(document).ready(function () {
    var form = $("#wizard-validation-form");
    form.validate({
        errorPlacement: function errorPlacement(error, element) {
            element.after(error);
        }
    });
    form.children("div").steps({headerTag: "h3",
        bodyTag: "section",
        transitionEffect: "slideLeft",
        onStepChanging: function (event, currentIndex, newIndex) {
            form.validate().settings.ignore = ":disabled,:hidden";
            return form.valid();
        },
        onFinishing: function (event, currentIndex) {
            form.validate().settings.ignore = ":disabled";
            return form.valid();
        },
        onFinished: function (event, currentIndex) {
            alert("Submitted!");
        }
    });
});

$('#maincategory').change(function () {
    $.ajax({
        type: 'GET',
        url: 'AJAX_GS_GenerateProjectID',
        dataType: 'json',
        data: {
            category: $('#maincategory').val()
        },
        success: function (id) {
            $('#projectID').val(id);
            console.log(id);
        }
    });
});


function delBtn(btn) {
    switch(btn.id){
        case ("#addWorks"):{
                
        }
        case 
    }
}

function myCreateFunction() {
    var table = document.getElementById("costtable");
    var row = table.insertRow(-1);
    var cell1 = row.insertCell(-1).contentEditable = true;
    var cell2 = row.insertCell(-1).contentEditable = true;
    var cell3 = row.insertCell(-1).contentEditable = true;
    var cell4 = row.insertCell(-1).contentEditable = true;

}

function myDeleteFunctionGeneral() {

    document.getElementById("general").deleteRow(-1);
    for (x = 0; x < 5; x++) {
        materialstable.pop();
    }
}

function myDeleteFunctionPW() {

    document.getElementById("programworks").deleteRow(-1);

    for (x = 0; x < 3; x++) {
        tableinput.pop();
    }
}


function myDeleteFunction2() {

    document.getElementById("component").deleteRow(-1);

}

$(document).on("change", "#componentid,#descriptionid,#unitid", function () {

    if (verifytable() === "true") {
        document.getElementById("PWsave").disabled = false;

    }
    else
        document.getElementById("PWsave").disabled = true;

});


function verifytable() {
    var temp;

    for (x = 0; x < tableinput.length; x++) {

        if (tableinput[x].value.length > 0) {
            temp = "true";
        }
        else {
            temp = "false";
            return temp;
        }
    }

    return temp;
}

function setPWtocalendar() {
    //ajax call here
    while (values.length > 0) {
        values.pop();
    }

    for (x = 0; x < tableinput.length; x++) {
        values.push(tableinput[x].value);
    }
    var json = JSON.stringify(values);

    $.ajax({
        type: 'POST', url: 'getpwschedule',
        dataType: 'json',
        data: {tableinputs: json, targetimplementationdate: $('#targetimplementationdate').val()},
        cache: false,
        success: function (sched) {
            alert("programs are successfully saved");
            inputActivities(sched);
        }
    });

}

function showAddTaskForm() {
    $('#modalTitle2').html($('#eventTag').val());
    $('#displayTasks').modal();
    $('#addTaskB').text("Add");
    $("#addTaskB").click(function () {
        addTask();
    });
    $("#viewTasksB").click(function () {
        viewTasks();
    });
    $('#fullCalModal').modal('hide');
}

function addTask() {
    var task = [];
    if ($('#taskName').val() !== '') {
        task = [$("#eventTag").val(), $('#taskName').val(), $('#taskDesc').val(), $('#taskStart').val(), $('#taskEnd').val(), $('#taskPerson').val(), "Temporary", tasksTemp.length];
        tasksTemp.push(task);
    }
    $('#taskName').val('');
    $('#taskDesc').val('');
    $('#taskStart').val('');
    $('#taskEnd').val('');
    $('#taskPerson').val('');

    viewTasks();

}

function saveTask() {
    var task = [];
    $.each(tasksTemp, function (i) {
        task = [tasksTemp[0], tasksTemp[0], tasksTemp[0], tasksTemp[0], tasksTemp[0], tasksTemp[0], "Final", tasksFinal.length];

        tasksFinal.push(tasksTemp[i]);
    });
    $('#fullCalModalBody').empty();
    $('#displayTasks').modal('hide');
    $('#fullCalModal').modal('hide');
    tasksTemp.length = 0;
}

function closeModal() {
    if (tasksTemp.length > 0) {
        viewTasks();
        if (confirm("You have tasks that weren't saved. Are you sure you want to close this?")) {
            $('#fullCalModalBody').empty();
            $('#displayTasks').modal('hide');
            $('#fullCalModal').modal('hide');
            tasksTemp.length = 0;
        }
        else
            return false;

    }
    else {
        $('#fullCalModalBody').empty();
        $('#displayTasks').modal('hide');
        $('#fullCalModal').modal('hide');

    }


}

function viewTasks() {
    var event = $("#eventTag").val();
    if (getTaskCount(event) < 1) {
        $('#fullCalModalBody').empty();
        $("<center><header class=\"panel-heading\" id=\"noTask\">No tasks for this activity yet</header></center>").appendTo("#fullCalModalBody");
    }
    else {
        $('#fullCalModalBody').html('');
        $.each(tasksFinal, function (i) {
            if (tasksFinal[i][0] === event) {
                $("<span class=\"pull-right\" aria-hidden=\"true\"><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"editView(this)\" id=\"" + i + "-Final\"><i class=\"fa fa-pencil\"></i>&nbsp</button><button type=\"button\" class=\"btn btn-danger btn-sm\" onclick=\"deleteTask(this)\" id=\"" + i + "-Final\"><i class=\"fa fa-times\"></i></button></span>").appendTo("#fullCalModalBody");
                $("<b> <p class=\"control-label\" style=\" font-size: medium;\">Task: " + tasksFinal[i][1] + "</p></b>").appendTo("#fullCalModalBody");

                if (tasksFinal[i][2] !== "")
                    $("&nbsp <p class=\"control-label\">Description: " + tasksFinal[i][2] + "</p>").appendTo("#fullCalModalBody");

                if (tasksFinal[i][3] !== "")
                    $("&nbsp <p class=\"control-label\">Start: " + tasksFinal[i][3] + "</p>").appendTo("#fullCalModalBody");

                if (tasksFinal[i][4] !== "")
                    $("&nbsp <p class=\"control-label\">End: " + tasksFinal[i][4] + "</p>").appendTo("#fullCalModalBody");

                if (tasksFinal[i][5] !== "")
                    $("&nbsp <p class=\"control-label\">Person in Charge: " + tasksFinal[i][5] + "</p>").appendTo("#fullCalModalBody");
                $("<header class=\"panel-heading\"></header>").appendTo("#fullCalModalBody");

            }

        });

        $.each(tasksTemp, function (i) {
            if (tasksTemp[i][0] === event) {
                $("<span class=\"pull-right\" aria-hidden=\"true\"><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"editView(this)\" id=\"" + i + "-" + tasksTemp[i][6] + "\"><i class=\"fa fa-pencil\"></i>&nbsp</button><button type=\"button\" class=\"btn btn-danger btn-sm\" onclick=\"deleteTask(this)\" id=\"" + i + "-" + tasksTemp[i][6] + "\"><i class=\"fa fa-times\"></i></button></span>").appendTo("#fullCalModalBody");
                $("<b> <p class=\"control-label\" style=\" font-size: medium;\">Task: " + tasksTemp[i][1] + "</p></b>").appendTo("#fullCalModalBody");

                if (tasksTemp[i][2] !== "")
                    $("&nbsp <p class=\"control-label\">Description: " + tasksTemp[i][2] + "</p>").appendTo("#fullCalModalBody");

                if (tasksTemp[i][3] !== "")
                    $("&nbsp <p class=\"control-label\">Start: " + tasksTemp[i][3] + "</p>").appendTo("#fullCalModalBody");

                if (tasksTemp[i][4] !== "")
                    $("&nbsp <p class=\"control-label\">End: " + tasksTemp[i][4] + "</p>").appendTo("#fullCalModalBody");

                if (tasksTemp[i][5] !== "")
                    $("&nbsp <p class=\"control-label\">Person in Charge: " + tasksTemp[i][5] + "</p>").appendTo("#fullCalModalBody");
                $("<header class=\"panel-heading\"></header>").appendTo("#fullCalModalBody");

            }

        });

    }
    $('#modalTitle').html($('#eventTag').val());
    $('#fullCalModal').modal();
    $("#addTaskB").click(function () {
        addTask();
    });
    $("#showTaskMod").click(function () {
        showAddTaskForm();
    });
    $('#displayTasks').modal('hide');


}

function getTaskCount() {
    var counter = 0;
    var event = $("#eventTag").val();

    $.each(tasksTemp, function (i) {
        if (tasksTemp[i][0] === event) {
            counter++;
        }
    });

    $.each(tasksFinal, function (i) {
        if (tasksFinal[i][0] === event)
            counter++;
    });
    return counter;
}

function editView(button) {
    var taskNoStatus = button.id;
    var getSched = taskNoStatus.split('-');
    var task = [];
    if (getSched[1] === "Temporary") {
        task = tasksTemp[getSched[0]];
    }
    else if (getSched[1] === "Final") {
        task = tasksFinal[getSched[0]];
    }

    $('#modalTitle2').html($('#eventTag').val());
    $('#taskName').val(task[1]);
    $('#taskDesc').val(task[2]);
    $('#taskStart').val(task[3]);
    $('#taskEnd').val(task[4]);
    $('#taskPerson').val(task[5]);
    $('#displayTasks').modal();
    $('#addTaskB').text("Save Changes");
    $("#addTaskB").click(function () {
        editTask(taskNoStatus);
    });
    $("#viewTasksB").click(function () {
        viewTasks();
    });
    $('#fullCalModal').modal('hide');

    return getSched;
}

function draftbutton() {
    $('#actionI').val("draft");
}
function finishbutton() {
    $('#actionI').val("finish");
}

function editTask(taskNoStatus) {
    var getSched = taskNoStatus.split('-');
    var task = [];

    if (getSched[1] === "Temporary") {
        tasksTemp[getSched[0]] = task;
        if ($('#taskName').val() !== '') {
            task = [$("#eventTag").val(), $('#taskName').val(), $('#taskDesc').val(), $('#taskStart').val(), $('#taskEnd').val(), $('#taskPerson').val(), "Temporary", getSched[0]];
        }

    }
    else if (getSched[1] === "Final") {
        tasksFinal[getSched[0]] = task;
        if ($('#taskName').val() !== '') {
            task = [$("#eventTag").val(), $('#taskName').val(), $('#taskDesc').val(), $('#taskStart').val(), $('#taskEnd').val(), $('#taskPerson').val(), "Temporary", getSched[0]];
        }

    }

    $('#taskName').val('');
    $('#taskDesc').val('');
    $('#taskStart').val('');
    $('#taskEnd').val('');
    $('#taskPerson').val('');

    viewTasks();

}

function deleteTask(button) {
    var taskNoStatus = button.id;
    var getSched = taskNoStatus.split('-');
    if (getSched[1] === "Temporary") {
        tasksTemp.splice(getSched[0], 1);
    }
    else if (getSched[1] === "Final") {
        tasksFinal.splice(getSched[0], 1);
    }
    viewTasks();
}

//function saveDraft() {
//    var location;
//    var details;
//    var materials;
//    var schedule;
//    var upload;
//    $.ajax({
//        type: 'POST',
//        url: 'saveasdraft',
//        dataType: 'json',
//        data: {details: details, location: location, materials: materials,
//            schedule: schedule, upload: upload},
//        cache: false,
//        success: function (sched) {
//            //servlet that redirects to list of projects
//        }
//    });
//
//}
//
//function submitProposal() {
//
//    while (0 < materialstable.length) {
//
//        var material = {
//            material: materialstable[materialstable.length - 5].value,
//            percentage: materialstable[materialstable.length - 4].value,
//            quantity: materialstable[materialstable.length - 3].value,
//            unit: materialstable[materialstable.length - 2].value,
//            unitprice: materialstable[materialstable.length - 1].value
//        };
//        materialvalues.push(material);
//        materialstable.pop();
//        materialstable.pop();
//        materialstable.pop();
//        materialstable.pop();
//        materialstable.pop();
//    }
//
//    while (0 < tableinput.length) {
//
//        var component = {
//            component: tableinput[tableinput.length - 3].value,
//            duration: tableinput[tableinput.length - 2].value,
//            unit: tableinput[tableinput.length - 1].value
//        };
//        componentvalues.push(component);
//        tableinput.pop();
//        tableinput.pop();
//        tableinput.pop();
//    }
//
//
//    for (x = 0; x < tasksFinal.length; x++) {
//
//        var task = {
//            Activity: tasksFinal[x][0],
//            Task: tasksFinal[x][1],
//            Description: tasksFinal[x][2],
//            StartDate: tasksFinal[x][3],
//            EndDate: tasksFinal[x][4],
//            PersonInCharge: tasksFinal[x][5],
//            Status: tasksFinal[x][6],
//            Index: tasksFinal[x][7]
//        };
//        taskValue.push(task);
//    }
//
//    var subcategory;
//
//    if ($('#subcategory').val() == "Others") {
//        subcategory = $('#OtherSub').val();
//    } else
//        subcategory = $('#subcategory').val();
//
//    var files = $('input[type="checkbox"].filetid:checked').map(function () {
//        return $(this).val();
//    }).toArray();
//    $.ajax({
//        type: 'post',
//        url: 'GS_SubmitProposal',
//        dataType: 'json',
//        data:
//                {
//                    projectid: $('#projectID').val(),
//                    projectname: $('#projectname').val(),
//                    projectdescription: $('#projectdescription').val(),
//                    category: $('#maincategory').val(),
//                    subcategory: subcategory,
//                    hiddenlocation: $('#location').val(),
//                    materialvalues: JSON.stringify(materialvalues),
//                    componentvalues: JSON.stringify(componentvalues),
//                    eventvalues: JSON.stringify(schedulevalue),
//                    tfilevalues: JSON.stringify(files),
//                    actionI: $('#actionI').val()
//                },
//        cache: false,
//        success: function (data) {
//            alert("Project has been submitted");
//            window.location = data.url;
//        }
//    });
//}
