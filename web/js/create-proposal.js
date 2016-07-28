var powNumber = 1;
var taskName = [];
var taskSchedule = [];
var finalTasks = [];
var taskDetails;

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
$(function () {
    $('#proposalForm').stepy({
        backLabel: 'Previous',
        block: true,
        nextLabel: 'Next',
        titleClick: true,
        titleTarget: '.stepy-tab'
    });
});
$('.viewbutton').click(function () {
    $.ajax({
        type: 'post',
        url: 'AJAX_GS_ViewTestimonialDetails',
        dataType: 'json',
        data:
                {
                    testimonialID: $(this).val()
                },
        cache: false,
        success: function (data) {

            $('#tVideoDisplay').empty();
            $('#tImageDisplay').empty();
            $('#tDocumentUploads').empty();
            $('#testTitle').text("Title: " + data.title);
            $('#testDate').text("Date Uploaded: " + data.dateUploaded);
            $('#testCategory').text("Category: " + data.category);
            $('#testMessage').text("Message: " + data.message);
            $.each(data.files, function (i) {
                var url = data.folderName + data.title + "/" + data.files[i].fileName;
                if (data.files[i].type === "Video") {
                    $("<video width='100%' height='100%' controls><source src=\"" + url + "\" type='video/mp4'></video>").appendTo("#tVideoDisplay");
                }
                else if (data.files[i].type === "Image") {
                    $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#tImageDisplay");
                }

                else if (data.files[i].type === "Document") {
                    $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + data.files[i].fileName + "</a> </header>").appendTo("#tDocumentUploads");
                }
            });
        }
    });
    //Ajax Call here and change modal fields

    $('#viewdetails').modal();
});

//Select Main Testimonial and Referenced Projects
var mainTestimonial = [];
var detachedMainRow;
var tablerow;
var Testimonialmarkers = [];
var referencedProjects = [];

//Select Testimonial from Testimonial List as Main Testimonial and append labels.
$('.selectmainbtn').click(function () {
    detachedMainRow = $(this).closest('tr').detach();
    var testimonial = {id: $(this).val()};
    mainTestimonial.push(testimonial);
    $.ajax({
        type: 'post',
        url: 'AJAX_GS_SelectMainTestimonial',
        dataType: 'json',
        data: {mainTestimonial: JSON.stringify(mainTestimonial)},
        cache: false,
        success: function (data) {
            //Place the object in the Main Testimonial Div
            $("#TestiTitle").text("You have selected " + data[0].title + " as your main testimonial");
            //Set Testimonial Locaiton on map markers
            $.each(data[0].tlocation, function (i) {
                Testimonialmarkers.push(data[0].tlocation[i]);
            });
            initMap();
            $("#MainTestimonial").show();
            $('.selectmainbtn').hide();
        }
    });
    $('#maintestimonial').val($(this).val());
});
$('#maincategory').change(function () {
    $.ajax({
        type: 'post',
        url: 'AJAX_GS_GenerateProjectID',
        dataType: 'json',
        data: {category: $('#maincategory').val()},
        cache: false,
        success: function (data) {
            $('#projectID').val(data);
        }
    });
});
$('.deselectmainbtn').click(function () {
    mainTestimonial.length = 0;
    $("#TestimonialTableBody").append(detachedMainRow);
    $('.selectmainbtn').show();
    $("#MainTestimonial").hide();
    //Map Functions
    Testimonialmarkers.length = 0;
    allPosition.length = 0;
    document.getElementById("location").value = allPosition;
    initMap();
});
//Transfer from Testi List to Referenced Table List via detach
$(document).on('click', '.selectprojectbtn', function () {

    $("#selectedprojectTable").show();
    var PID = {id: $(this).val()};
    referencedProjects.push(PID);
    var Rt = $(this).closest('tr').detach();
    $("#selectedprojectlistTable").append(Rt);
    $(this).removeClass('btn btn-success btn-sm selectprojectbtn').addClass('btn btn-danger btn-sm unselectprojectbtn');
    $(this).text("Remove");


});
//Transfer from Referenced Table back to Testi list
$(document).on('click', '.unselectprojectbtn', function () {
    for (var x = 0; x < referencedProjects.length; x++) {
        if (referencedProjects[x].id == $(this).val()) {
            referencedProjects.splice(x, 1);
        }
    }

    if (referencedProjects.length == 0) {
        $("#selectedprojectTable").hide();
    }

    var detached = $(this).closest('tr').detach();
    $("#projectlistTable").append(detached);
    $(this).removeClass('btn btn-danger btn-sm unselectprojectbtn').addClass('btn btn-success btn-sm selectprojectbtn');
    $(this).text("Select Project");

});
$.fn.searchableTable = function () {
    return this.each(function () {
        var data = $(this).data(), $rows = $(this).find('tbody > tr'),
                $searchField = $(data.searchField),
                $rowsCount;
        if (data.searchRows) {
            $rowsCount = $(data.searchRows);
        }
        $searchField.keyup(function () {
            var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
            var $filtered = $rows.show().filter(function () {
                var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                return !~text.indexOf(val);
            }).hide();
            if ($rowsCount)
                $rowsCount.text($rows.length - $filtered.length);
        })
                .trigger('keyup');
    });
};
// Initialize
$('.table').searchableTable();
var map;
var markers = [];
var allPosition = [];
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 14.45, lng: 120.98},
        zoom: 14
    });
    google.maps.event.addListener(map, 'click', function (event) {
        placeMarker(event.latLng);
    });
    function placeMarker(location) {
        var marker = new google.maps.Marker({
            position: location,
            map: map
        });
        markers.push(marker);
        latitude = marker.position.lat();
        longitude = marker.position.lng();
        var string = latitude + "&" + longitude;
        allPosition.push(string);
        document.getElementById("location").value = allPosition;
    }

    Testimonialmarkers.forEach(function (coor) {
        var geocoder = new google.maps.Geocoder;
        var latLng = new google.maps.LatLng(coor.latitude, coor.longitude);
        var latitude = coor.latitude;
        var longitude = coor.longitude;
        var string = latitude + "&" + longitude;
        allPosition.push(string);
        document.getElementById("location").value = allPosition;
        var marker = new google.maps.Marker({
            position: latLng,
            map: map
        });
        var infowindow = new google.maps.InfoWindow;
        marker.addListener('click', function () {
            geocodeLatLng(geocoder, map, infowindow, latLng);
        });
    });
}

function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
    allPosition = [];
}

var powNumber = 1;
function addRowForWorks() {
    //debugger;

    var table = document.getElementById("powTable");
    var row = table.insertRow(-1);
    var cell2 = row.insertCell(-1);
    var cell3 = row.insertCell(-1);
    var sel = document.createElement('select');
    sel.setAttribute("id", "worksSelect-" + powNumber);
    sel.setAttribute("class", "worksSelect");
    sel.setAttribute("class", "form-control");
    sel.setAttribute("name", "works");
    var ok = document.createElement('button');
    sel.setAttribute("id", "worksOk-" + powNumber);
    var button = document.createElement('button');
    button.setAttribute("id", "worksButton-" + powNumber);
    button.setAttribute("class", "form-control finalWorks");
    button.setAttribute("name", "works");
    button.setAttribute("type", "button");
    var newWork = document.createElement('input');
    newWork.setAttribute("id", "newWork-" + powNumber);
    newWork.setAttribute("class", "form-control");
    newWork.setAttribute("type", "text");
    var delBtn = document.createElement('button');
    delBtn.setAttribute("id", "worksDel-" + powNumber);
    delBtn.setAttribute("class", "btn btn-danger btn-sm");
    delBtn.innerHTML = "-";
    delBtn.addEventListener("click", function () {
        var row = delBtn.parentNode.parentNode;
        row.parentNode.removeChild(row);
        for (var x = 0; x < taskName.length; x++) {
            var task = taskName[x];
            if (task === $(this).val()) {
                taskName.splice(x, 1);
            }
        }

        console.log(taskName);
        $('#componentsDiv-' + (getIdNum(delBtn.id))).remove();
    });
    var option = document.createElement("option");
    option.setAttribute('hidden', true);
    option.text = 'Select Works';
    sel.appendChild(option);
    for (var i = 0; i < worksList.length; i++) {
        option = document.createElement("option");
        option.setAttribute("value", worksList[i].name);
        option.text = worksList[i].name;
        sel.appendChild(option);
    }

    option = document.createElement("option");
    option.setAttribute("value", "new");
    option.text = "New...";
    sel.appendChild(option);
    powTableFc(button, sel, powNumber, newWork);
    cell2.appendChild(sel);
    cell2.appendChild(button);
    cell2.appendChild(newWork);
    cell3.appendChild(delBtn);
    powNumber++;
}

function createTble(works, id) {
    var div = $('<div id="componentsDiv-' + id + '"></div>');
    var header = $('<header class="panel-heading no-border"> Components - ' + works + '</header>');
    var table = $('<table class="table table-bordered table-striped table-condensed" id="comp-' + id + '"></table>');
    var tableHeader = $('<thead><tr><th style="width: 20%">Component</th><th style="width: 10%">Qty/Area</th><th style="width: 12%">Unit</th><th style="width: 20%">Unit Cost</th><th style="width: 20%">Amount</th></tr></thead>');
    var tableBody = $('<tbody></tbody>');
    var tableFoot = $('<tfoot><tr id="totalTR"><td colspan="3"></td><td style="font-weight: bold;">Subtotal</td><td style="font-weight: bold; border-bottom: 3px double;"> <input type="text" class="form-control" name="subtotal" id="subtotal-"' + id + ' readonly style="background: transparent"></td></tr></tfoot>');
    var deleteBtn = $('<button class="btn btn-danger btn-sm pull-right" type="button" onclick="delBtn(this)" id="componentsDelete-' + id + '"><i class="fa fa-times"></i> Delete </button>');
    var addBtn = $('<button class="btn btn-success btn-sm pull-right" type="button" onclick="addComponentsRow(this)" id="componentsAdd-' + id + '" style="margin-right: 5px"><i class="fa fa-plus"></i> Add </button>');
    var brk = $('<br><br><br>');
    $('#compMain').append(div);
    $(div).append(header);
    $(div).append(table);
    $(table).append(tableHeader);
    $(table).append(tableBody);
    $(table).append(tableFoot);
    $(div).append(deleteBtn);
    $(div).append(addBtn);
    $(div).append(brk);
}

function powTableFc(button, sel, num, work) {
    $(button).hide();
    $(work).hide();
    $(sel).change(function () {
        if ($(sel).val() === "new") {
            $(work).show();
            $(work).keypress(function (e) {
                var key = e.which;
                if (key === 13) {
                    $(work).hide();
                    $(sel).hide();
                    $(button).text($(work).val());
                    $(button).show();
                    $('#compMain div').each(function () {
                        $(this).hide();
                    });
                    $(button).val($(work).val());
                    createTble(button.innerHTML, num);
                    $('#worksDel-' + num).val($(sel).val());
                }
            });
        }
        else {
            $(sel).hide();
            $(button).text($(sel).val());
            $(button).val($(sel).val());
            $(button).show();
            $('#compMain div').each(function () {
                $(this).hide();
            });
            createTble(button.innerHTML, num);
            $('#worksDel-' + num).val($(sel).val());
        }
    });
    $(button).dblclick(function () {
        $(button).hide();
        $(sel).show();
    });
    $(button).click(function () {
        $('#compMain div').each(function () {
            if (this.id === "componentsDiv-" + num) {
                $('#componentsDiv-' + num).show();
            }
            else {
                $(this).hide();
            }
        });
    });
}

function getIdNum(string) {
    var spl = string.split('-', 2);
    return spl[1];
}

function delBtn(btn) {
    var row = btn.parentNode.parentNode;
    row.parentNode.removeChild(row);
}

function addComponentsRow(btn) {
    var id = getIdNum(btn.id);
    var tableId = "comp-" + id;
    var row = $('<tr></tr>');
    var x = 1;
    var componenttd = $('<td></td>');
    var component = $('<input type="text" name="component" class="form-control" id="component"> ');
    componenttd.append(component);
    var quantitytd = $('<td></td>');
    var quantity = $('<input type="text" name="quantity" class="form-control" id="quantity"> ');
    quantitytd.append(quantity);
    var unittd = $('<td></td>');
    var select = $('<select type="text" name="unit" class="form-control" id="unit" ></select>');
    for (var i = 0; i < unitList.length; i++) {
        $(select).append($("<option></option>").val(unitList[i].unit).html(unitList[i].unit));
    }
    $(unittd).append(select);
    var unitCosttd = $('<td></td>');
    var unitCost = $('<input type="text" name="unitCost" class="form-control" id="unitCost">');
    unitCosttd.append(unitCost);
    var amounttd = $('<td></td>');
    var amount = $('<input readonly type="text" name="amount" class="form-control amount" style="background: white">');
    amounttd.append(amount);
    $(row).append(componenttd);
    $(row).append(quantitytd);
    $(row).append(unittd);
    $(row).append(unitCosttd);
    $(row).append(amounttd);
    onchanges(quantity, unitCost, amount, id);
    $("#" + tableId).append(row);
}

function onchanges(quantity, unitcost, amount, id) {
    var cost;
    $(quantity).change(function () {
//if unitcost is not empty set amount
        if ($(unitcost).val() !== "") {
            cost = parseFloat($(quantity).val() * $(unitcost).val());
            $(amount).val(cost.toFixed(2));
            var total;
            $('#comp-' + id + ' .amount').each(function () {
                total += $(this).val();
            });
            $('#subtotal-' + id).val(total.toFixed(2));
        }
    });
    $(unitcost).change(function () {
        if ($(quantity).val() !== "") {
            cost = parseFloat($(quantity).val() * $(unitcost).val());
            $(amount).val(cost.toFixed(2));
            var total = 0;
            $('#comp-' + id + ' .amount').each(function () {
                total = total + parseFloat($(this).val());
            });
            $('#comp-' + id + ' tfoot input').val("PHP " + numberWithCommas(total.toFixed(2)));
        }
    });
}

var works = [];
var pw, comps, compList = [], pworks;
var n, q, u, c;
function insertWorks() {

    for (var x = 1; x < powNumber; x++) {
        pw = $('#worksButton-' + x).text();
        $('#comp-' + x + ' tbody tr').each(function (row, tr) {

            n = $(tr).find('#component').val();
            q = $(tr).find('#quantity').val();
            u = $(tr).find('#unit').val();
            c = $(tr).find('#unitCost').val();
            comps = {cname: n, qty: q, unit: u, cost: c};
            compList.push(comps);
        });
        pworks = {name: pw, component: compList};
        works.push(pworks);
        compList = [];
    }

//    JSON.stringify(works);
    $('#pworks').val(JSON.stringify(works));

    $('#schedule').val(JSON.stringify(finalTasks));
//    console.log(JSON.stringify(finalTasks));

}

//SCRIPTS FOR SCHEDULE SECTION
$(document).ready(function () {
    var isExisting;
    $('#proposalForm-title-4 div').click(function () {
        $('.finalWorks').each(function () {
            if (taskName.length > 0) {
                for (var x = 0; x < taskName.length; x++) {
                    if (taskName[x] !== $(this).text()) {
                        isExisting = false;
                    }
                    else {
                        isExisting = true;
                        break;
                    }
                }
                if (!isExisting) {
                    taskName.push($(this).text());
                }
            }
            else {
                taskName.push($(this).text());
            }
        });
        setTasksTable();
    });
});
function setTasksTable() {


    var taskDet;
    $('#taskTable tbody > tr').remove();
    for (var x = 0; x < taskName.length; x++) {
        if (taskName.length > 0) {
            var task = taskName[x];
            var tr = $('<tr></tr>');
            var buttontd = $('<td></td>');
            var button = $('<button type="button" class="btn btn-white form-control" value="' + task + '" data-toggle="modal" onclick="addScheduleModal(this)">' + task + '</button>');
//            var deltd = $('<td></td>');
//            var del = $('<button class = "btn btn-danger btn-sm" type="button" value="' + task + '" onclick="deleteForSchedule(this)"> - </button>');
            buttontd.append(button);
//            deltd.append(del);
            tr.append(buttontd);
//            tr.append(deltd);
            $('#taskTable tbody').append(tr);
            var schedDetails = [];
            taskDet = {name: task, details: schedDetails};
            finalTasks.push(taskDet);
        }
    }
}



function addScheduleModal(btn) {
    $('#schedModal > .modal-header > h4').html($(btn).val());
    $('#taskNameMod').val($(btn).val());
    $('#schedModal').modal();
}

var tempTasks = [];

function addScheduleToArray() {
    var name = $('#taskNameMod').val();
    var start = $('#startDate').val();
    var end = $('#endDate').val();
    var det = {start: start, end: end};

    for (var x = 0; x < finalTasks.length; x++) {
        if (finalTasks[x].name === name) {
            finalTasks[x].details.push(det);
            break;
        }
    }

    $('#startDate').val("");
    $('#endDate').val("");

    renderChart(JSON.stringify(finalTasks));
}

function finalizeTasks() {
    for (var x = 0; x < tempTasks.length; x++) {
        var exists = false;
        var index;
        //insert into array {name, details}
        //loop through said array and check names
        //if same, push into one details array
        //
        if (finalTasks.length > 0) {
            for (var y = 0; y < finalTasks.length; y++ && !exists) {
                if (tempTasks[x].name === finalTasks[y].name) {
                    exists = true;
                    index = y;
                }
            }
            if (exists) {
                finalTasks[y].details.push(tempTasks[x].details[0]);
            } else {

            }

        } else {
            finalTasks.push(tempTasks[x]);
        }
    }
}

function deleteForSchedule(btn) {
    var row = btn.parentNode.parentNode;
    row.parentNode.removeChild(row);
    for (var x = 0; x < taskName.length; x++) {
        var task = taskName[x];
        if (task === $(btn).val()) {
            taskName.splice(x, 1);
        }
    }
    console.log(taskName);
}

//FOR THE GANTT CHARTS
var chartD;
var chartVal = Object.create(null);
var chart = AmCharts.makeChart("chartdiv", {
    "type": "gantt",
    "period": "DD",
    "theme": "dark",
    "valueAxis": {
        "type": "date"
    },
    "brightnessStep": 10,
    "graph": {
        "fillAlphas": 1,
        "balloonText": "[[open]] - [[value]]"
    },
    "rotate": true,
    "categoryField": "name",
    "segmentsField": "details",
    "dataDateFormat": "YYYY-MM-DD",
    "startDateField": "start",
    "endDateField": "end",
    "chartCursor": {
        "valueBalloonsEnabled": false,
        "cursorAlpha": 0,
        "valueLineBalloonEnabled": true,
        "valueLineEnabled": true,
        "valueZoomable": true,
        "zoomable": false
    },
    "valueScrollbar": {
        "position": "top",
        "autoGridCount": true,
        "color": "#000000"
    },
});


//Event method: click item
//Once you click one of the bars in the gantt chart, this method will execute
var index = 0;

//var index = 0;
var addSegment = function (event) {
    $.map(event.item.dataContext, function (val, i) {

        //When the index is referring to the category of the selected value
        if (i == "name") {

            //Place the name of the selected value on the textfield 
            $("#category").val(event.item.dataContext.category);


        }
        //Else, if the index is referring to the segments of that particular value selected
        else {


            var name = i.indexOf("start") != -1 ? "start" : "end";
            var labelName = i.indexOf("start") != -1 ? "Start date: " : "End date: ";
            var divInd = "#" + "div-" + index;

            //Creates a div that will store the start date and end date for a particular Task   
            if (i.indexOf("start") != -1) {
                //Creates a div and then pushes it  to the div
                var div = $("<div></div>");
                div.prop("id", "div-" + index);
                div.prop("class", "divinput");
                div.appendTo("#submitEntryEdit");
            }

            //Creates a label and then pushes it  to the div
            var label = $("<label/>");
            label.html(labelName);
            label.prop("id", name + index);
            label.appendTo("#" + "div-" + index);
            //Creates a label then puts it to the div
            var newStart = $("<input type='text'/>");
            newStart.prop("id", name + index);
            newStart.appendTo("#" + "div-" + index);
            newStart.val(new Date(val));
            $("<br>").appendTo("#" + "div-" + index);


            if (i.indexOf("end") != -1) {
                index++;

            }
        }
    });

};

//This will draw the chart
var renderChart = function (data) {

    //Sets the data source    
    chart.dataProvider = data;

    //This method should be called after data in your data provider changed or a new array was set to dataProvider. 
    chart.validateData();

    //Adds event listener to the object.
    //chart.addListener("clickGraphItem", clickItemEvent);


}

function formatDate(date) {
    var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;

    return [year, month, day].join('-');
}

function getId(str) {
    var spl = str.split("-");
    return spl[1];
}
;

function getUpdatedChartVal() {
    return chartVal;
}
;

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


