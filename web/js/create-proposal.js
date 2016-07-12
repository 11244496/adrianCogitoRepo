var tableinput = [];
var componentvalues = [];
var materialstable = [];
var materialvalues = [];
var values = [];
var tasksTemp = [];
var tasksFinal = [];
var schedulevalue = [];
var taskValue = [];



$(function () {
    $('#proposalForm').stepy({
        backLabel: 'Previous',
        block: true,
        nextLabel: 'Next',
        titleClick: true,
        titleTarget: '.stepy-tab'
    });
});

$(document).on("change", "#subcategory", function () {
    if ($('#subcategory').val() == "Others") {
        document.getElementById('OtherSub').style.display = 'block';
    } else
        document.getElementById('OtherSub').style.display = 'none';
});


$(document).on("change", "#subcategory", function () {
    if ($('#subcategory').val() != "Others") {
        $.ajax({
            type: 'POST',
            url: 'getmaterialtable',
            dataType: 'json',
            data: {subcategory: $('#subcategory').val(), maincategory: $('#maincategory').val()},
            cache: false,
            success: function (material) {
                $("#generalbody").empty();
                drawTable(material);
            }
        });
    }
});

function drawTable(data) {
    for (var i = 0; i < data.length; i++) {

        var tableID = "general";
        var table = document.getElementById(tableID);
        var rowCount = table.rows.length;

        var row = table.insertRow(-1);
        var cell1 = row.insertCell(-1);
        var cell2 = row.insertCell(-1);
        var cell3 = row.insertCell(-1);
        var cell4 = row.insertCell(-1);
        var cell5 = row.insertCell(-1);


        var material = document.createElement('input');
        material.type = "text";
        material.name = "material";
        material.value = data[i].name;
        material.style.width = "100%";
        material.style.height = "100%";
        material.style.border = "none";
        material.setAttribute("readOnly", "true");

        var percentage = document.createElement('input');
        percentage.type = "text";
        percentage.name = "percentage";
        percentage.style.width = "100%";
        percentage.style.height = "100%";
        percentage.style.border = "none";

        var unitprice = document.createElement('input');
        unitprice.type = "text";
        unitprice.name = "unitprice";
        unitprice.value = data[i].unitprice;
        unitprice.style.width = "100%";
        unitprice.style.height = "100%";
        unitprice.style.border = "none";
        unitprice.class = "unitprice";
        unitprice.setAttribute("readOnly", "true");

        var quantity = document.createElement('input');
        quantity.value = data[i].quantity;
        quantity.type = "text";
        quantity.name = "quantity";
        quantity.style.width = "100%";
        quantity.style.height = "100%";
        quantity.style.border = "none";
        quantity.class = "quantity";

        var unit = document.createElement('input');
        unit.type = "text";
        unit.name = "unit";
        unit.value = data[i].unit.unit;
        unit.style.width = "100%";
        unit.style.height = "100%";
        unit.style.border = "none";
        unit.setAttribute("readOnly", "true");


        cell1.appendChild(material);
        cell2.appendChild(percentage);
        cell3.appendChild(quantity);
        cell4.appendChild(unit);
        cell5.appendChild(unitprice);

        materialstable.push(material);
        materialstable.push(percentage);
        materialstable.push(quantity);
        materialstable.push(unit);
        materialstable.push(unitprice);
    }
}

$(document).on("change", "#keywords", function () {
    $.ajax({
        type: 'POST',
        url: 'gettestimonialdropdown',
        dataType: 'json',
        data: {keywords: $('#keywords').val()},
        cache: false,
        success: function (testimonial) {
            $("#citizentestimonial").empty();
            $("#citizentestimonial").append($("<option></option>").text("Select Option"));
            $.each(testimonial, function (i) {
                $("#citizentestimonial").append(
                        $("<option></option>")
                        .text(testimonial[i].title)
                        .val(testimonial[i].id)
                        )
                        ;
            });
        }
    });
    return false;
});

$(document).on("change", "#citizentestimonial", function () {
    $.ajax({
        type: 'POST',
        url: 'gettestimonialtable',
        dataType: 'json',
        data: {testimonialid: $('#citizentestimonial').val()},
        cache: false,
        success: function (files) {
            $("#testimonialbody").empty();
            drawTableC(files);
        }
    });
});

function drawRowC(files) {
    var row = $("<tr />");
    $("#testimonialbody").append(row);
    row.append($("<td> <input type='checkbox' class='filetid' name='filetid' value='" + files.id + "'> </td>"));
    row.append($("<td>" + files.fileName + "</td>"));
    row.append($("<td>" + files.dateUploaded + "</td>"));
    row.append($("<button type='button' value=" + files.id + " class = 'btn btn-info btn-sm' onclick='getTestimonial(" + files.id + ")'>View Testimonial</button>"));
}

function getTestimonial(id) {
    $.ajax({
        type: 'POST',
        url: 'gettestimonial',
        dataType: 'json',
        data: {testId: id},
        cache: false,
        success: function (f) {
            $('#fDisplay').empty();
            var url = f.testimonial.folderName + "/" + f.fileName;
            if (f.type === "Video") {
                $("<div data-p=\"144.50\"><video><source src=" + url + " type=\"video/mp4\"><source src=" + url + " type=\"video/ogg\"></video></div>").appendTo("#fDisplay");

            }
            else if (f.type === "Image") {
                $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#fDisplay");

            }

            else if (f.type === "Document") {
                $("#docH").remove();
                $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + f.fileName + "</a> </header>").appendTo("#abcd");
            }
            $('#testTitle').text("Title: " + f.testimonial.title);
            $('#testDate').text("Date Uploaded: " + f.testimonial.dateUploaded);
            $('#testLoc').text("Location Details: " + f.testimonial.location + " + " + f.testimonial.locationdetails);
            $('#testDesc').text("Description: " + f.testimonial.message);
            $('#testModal').modal();
        }
    });
}
;

function drawTableC(data) {
    for (var i = 0; i < data.length; i++) {
        drawRowC(data[i]);
    }
}

function addRowGeneral() {
    //debugger;
    var tableID = "general";
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;


    var row = table.insertRow(-1);
    var cell1 = row.insertCell(-1);
    var cell2 = row.insertCell(-1);
    var cell3 = row.insertCell(-1);
    var cell4 = row.insertCell(-1);
    var cell5 = row.insertCell(-1);


    var material = document.createElement('input');
    material.type = "text";
    material.name = "material";
    material.style.width = "100%";
    material.style.height = "100%";
    material.style.border = "none";

    var percentage = document.createElement('input');
    percentage.type = "text";
    percentage.name = "percentage";
    percentage.style.width = "100%";
    percentage.style.height = "100%";
    percentage.style.border = "none";

    var unitprice = document.createElement('input');
    unitprice.type = "text";
    unitprice.name = "unitprice";
    unitprice.style.width = "100%";
    unitprice.style.height = "100%";
    unitprice.style.border = "none";
    unitprice.class = "unitprice";

    var quantity = document.createElement('input');
    quantity.type = "text";
    quantity.name = "quantity";
    quantity.style.width = "100%";
    quantity.style.height = "100%";
    quantity.style.border = "none";
    quantity.class = "quantity";

    var array = ["N/A", "pcs", "kg", "ft", "lbs", "cm", "lot", "cu.m", "sq.m"];
    var unit = document.createElement("select");
    unit.setAttribute("id", "myunitSelect");
    unit.name = "unit";

    for (var i = 0; i < array.length; i++) {
        var option = document.createElement("option");
        option.setAttribute("value", array[i]);
        option.text = array[i];
        unit.appendChild(option);
    }
    unit.style.width = "100%";
    unit.style.height = "100%";
    unit.style.border = "none";

    cell1.appendChild(material);
    cell2.appendChild(percentage);
    cell3.appendChild(quantity);
    cell4.appendChild(unit);
    cell5.appendChild(unitprice);

    //set the components into material array
    materialstable.push(material);
    materialstable.push(percentage);
    materialstable.push(quantity);
    materialstable.push(unit);
    materialstable.push(unitprice);
}


//Add Function for total Here
//$(document).on("change", $('input.unitprice[class="unitprice"],input.quantity[class="quantity"]'), function () {
//});


function addRowPW() {                 //debugger;
    var tableID = "programworks";
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;


    var row = table.insertRow(-1);
    var cell1 = row.insertCell(-1);
    var cell2 = row.insertCell(-1);
    var cell3 = row.insertCell(-1);

    var component = document.createElement('input');
    component.id = "componentid";
    component.type = "text";
    component.name = "component";
    component.style.width = "100%";
    component.style.height = "100%";
    component.style.border = "none";
    tableinput.push(component);


    var duration = document.createElement('input');
    duration.id = "durationid";
    duration.type = "text";
    duration.name = "duration";
    duration.style.width = "100%";
    duration.style.height = "100%";
    duration.style.border = "none";
    tableinput.push(duration);


    var unit = document.createElement('select');
    var arr = ["Day/s", "Week/s", "Month/s"];
    unit.name = "powUnit";
    unit.id = "unitid";
    unit.style.width = "100%";
    unit.style.height = "100%";
    unit.style.border = "none";
    for (var i = 0; i < arr.length; i++) {
        var option = document.createElement("option");
        option.value = arr[i];
        option.text = arr[i];
        unit.appendChild(option);
    }
    tableinput.push(unit);

    document.getElementById("PWsave").disabled = true;

    cell1.appendChild(component);
    cell2.appendChild(duration);
    cell3.appendChild(unit);

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

function delBtn(btn) {
    var row = btn.parentNode.parentNode;
    row.parentNode.removeChild(row);
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

function saveDraft() {
    var location;
    var details;
    var materials;
    var schedule;
    var upload;
    $.ajax({
        type: 'POST',
        url: 'saveasdraft',
        dataType: 'json',
        data: {details: details, location: location, materials: materials,
            schedule: schedule, upload: upload},
        cache: false,
        success: function (sched) {
            //servlet that redirects to list of projects
        }
    });

}

function submitProposal() {

    while (0 < materialstable.length) {

        var material = {
            material: materialstable[materialstable.length - 5].value,
            percentage: materialstable[materialstable.length - 4].value,
            quantity: materialstable[materialstable.length - 3].value,
            unit: materialstable[materialstable.length - 2].value,
            unitprice: materialstable[materialstable.length - 1].value
        };
        materialvalues.push(material);
        materialstable.pop();
        materialstable.pop();
        materialstable.pop();
        materialstable.pop();
        materialstable.pop();
    }

    while (0 < tableinput.length) {

        var component = {
            component: tableinput[tableinput.length - 3].value,
            duration: tableinput[tableinput.length - 2].value,
            unit: tableinput[tableinput.length - 1].value
        };
        componentvalues.push(component);
        tableinput.pop();
        tableinput.pop();
        tableinput.pop();
    }


    for (x = 0; x < tasksFinal.length; x++) {

        var task = {
            Activity: tasksFinal[x][0],
            Task: tasksFinal[x][1],
            Description: tasksFinal[x][2],
            StartDate: tasksFinal[x][3],
            EndDate: tasksFinal[x][4],
            PersonInCharge: tasksFinal[x][5],
            Status: tasksFinal[x][6],
            Index: tasksFinal[x][7]
        };
        taskValue.push(task);
    }

    var subcategory;

    if ($('#subcategory').val() == "Others") {
        subcategory = $('#OtherSub').val();
    } else
        subcategory = $('#subcategory').val();

    var files = $('input[type="checkbox"].filetid:checked').map(function () {
        return $(this).val();
    }).toArray();
    $.ajax({
        type: 'post',
        url: 'GS_SubmitProposal',
        dataType: 'json',
        data:
                {
                    projectid: $('#projectID').val(),
                    projectname: $('#projectname').val(),
                    projectdescription: $('#projectdescription').val(),
                    category: $('#maincategory').val(),
                    subcategory: subcategory,
                    hiddenlocation: $('#location').val(),
                    materialvalues: JSON.stringify(materialvalues),
                    componentvalues: JSON.stringify(componentvalues),
                    eventvalues: JSON.stringify(schedulevalue),
                    tfilevalues: JSON.stringify(files),
                    actionI: $('#actionI').val()
                },
        cache: false,
        success: function (data) {
            alert("Project has been submitted");
            window.location = data.url;
        }
    });
}
