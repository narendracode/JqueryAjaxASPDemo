<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <script type = "text/javascript" src="Scripts/jQuery.js"></script>
    <script type = "text/javascript" src="Scripts/json.js"></script>
   <!--  <script type = "text/javascript" src="Scripts/jquery-1.6.2.min.js"></script>-->
<script type="text/javascript">
    $(document).ready(function () {

        //StationaryID Class
        var StationaryId = function (stId) { this.StationaryId = stId }


        $('#checkAll').click(
   function () {
       // alert("Check all is clicked");

       if ($(this).is(':checked')) {
           $('.check').prop('checked', true);
       } //checked
       else {
           $('.check').removeAttr('checked');
       }

   }
  ); //checkAll

        loadStationaries();
        // fillTable(stationaries);

        $('#rejectButton').click(function () {
            var rejectArray = [];
            var jsonRejectArray = [];

            $('.check').each(
      function () {
          if ($(this).is(':checked')) {
              //var stId = new StationaryId($(this).attr('id'));
              rejectArray.push($(this).attr('id'));

              var stId = { "id": $(this).attr('id') };

              jsonRejectArray.push(stId);

          } //if
      }
      ); //each

            // alert("json array:"+$.toJSON(jsonRejectArray));
            // deleteStationary($.toJSON(jsonRejectArray));

            ///%%%%%%%%%%%%%%%%%%%
            alert("Ajax fired:  " + $.toJSON(jsonRejectArray));

            $.ajax(
        {
            type: "POST",
            url: "index.aspx/deleteStationaries",
            data: "{'jsonParam' : " + $.toJSON(jsonRejectArray) + "}",
            // data: $.toJSON(jsonRejectArray),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                //DoSomething may be a popup or alert to show successful deletion..
                alert("successful deletion");
            }, error: function (x, e) {


                $("#error").text("Error occured" + x.responseText);
                alert("Error occured" + x.responseText);
            }
            // alert("check point ..after deletion");
        }

        );
            alert("Ajax fired end");
            ///%%%%%%%%%%%%%%%%%%%%%

        }
); //rejectButton

        function removeRowsFromTable(myTable) {
            var elementTable = document.getElementById('stationaryTable');
            var tableRows = elementTable.getElementsByTagName('tr');
            var rowCount = tableRows.length;
            alert("Row Count:" + rowCount);
            for (var x = rowCount - 1; x > 0; x--) {
                //	elementTable.removeChild(tableRows[x]);
                tableRows[x].parentNode.removeChild(tableRows[x]);
            }

        } //removeRowsFromTable

        $('#approveButton').click(function () {
            var approveArray = new Array();
            $('.check').each(
      function () {
          if ($(this).is(':checked'))
              approveArray.push($(this).attr('id'));
          //change colors of selected
          $(this).css('color', 'blue');
      }
      );
            alert("Total Checked items:" + approveArray.length);
        });
    });


    
    function deleteStationary(idArray) {

        alert("My Deleted checkss " + idArray);
        var pp = "hello";
        $.ajax(
        {
            type: "POST",
            url: "index.aspx/deleteStationaries",
           // data: "{'jsonParam' : " + pp + "}",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
            //DoSomething may be a popup or alert to show successful deletion..
            alert("successful deletion");
            },error:function(x,e){


                $("#error").text("Error occured" + x.responseText);
                 alert("Error occured" + x.responseText);
            }
           // alert("check point ..after deletion");
        }
        
        );

        //after deleting load the stationaries again
        loadStationaries();
    }//deleteStationary



    function loadStationaries() {
       
        $.ajax(
        {
            type: "POST",
            url: "index.aspx/GetAllStationaries",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                // $('#myDiv').text(msg.d);
               // alert("AAA message is :" + msg.d);
                var jsonObj = $.parseJSON(msg.d);
                //alert(jsonObj);

                for (var x = 0; x < jsonObj.length; x++) {
                    // alert("O " + x + ": " + jsonObj[x]);
                    var tableRow = "<tr>"
                + "<td><input class='check' type='checkbox' id='" + jsonObj[x].Id + "'>" + "</td>"
                + "<td>" + jsonObj[x].StationaryName + "</td>"
                + "<td>" + jsonObj[x].Quantity + "</td></tr>"
                ;
                   // alert(tableRow);
                    $(tableRow).appendTo("#stationaryTable tbody");
                }

            }

        }

        );
    
    }//loadStationaries


    function fillTable(data) {
        alert("inside fill Table:"+data);

        $.each(data, function (i, stationary) {
            alert("helloooo do not give up");
            var tableRow = "<tr>"
	   + "<td><input class='check' type='checkbox' id='" + stationary.Id + "'>" + "</td>"
	   + "<td>" + stationary.StationaryName + "</td>"
	   + "<td>" + stationary.Quantity + "</td></tr>"
	   ;
            alert("tableRow:" + tableRow);
            $(tableRow).appendTo("#stationaryTable tbody");
        }
   );
    } //fillTable
</script>
</head>
<body>
    <form  runat="server">
    <div>
    <div><input id='approveButton' type='submit' value='Approve'/><input id='rejectButton'type='submit' value='reject'/> </div>
    <table id="stationaryTable">
<thead>
<tr>
<td><input type="checkbox" id="checkAll"></td><td>Stationary</td><td>Quantity</td></tr></thead>
<tbody></tbody>
</table>
    </div>
    <p>
        &nbsp;</p>
    <p>
       <input type="text" id="error" />
    </p>
    </form>
</body>
</html>
