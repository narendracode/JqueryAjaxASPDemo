<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JQueryTableAjaxDatabaseDemo.aspx.cs" Inherits="JQueryTableAjaxDatabaseDemo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type = "text/javascript" src="Scripts/jQuery.js"></script>
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

            fillTable(stationaries);
            $('#rejectButton').click(function () {
                var rejectArray = new Array();
                $('.check').each(
      function () {
          if ($(this).is(':checked'))
          //StationaryId
              var stId = new StationaryId($(this).attr('id'));
         // rejectArray.push($(this).attr('id'));
          rejectArray.push(stId);
      }
      );

                alert("total checked items:" + rejectArray.length);
                /*
                for(var i = 0;i<rejectArray.length;i++){
                $.each(stationaries,function(i,stationary){
                if(stationary.id===rejectArray[i]){
                alert("stationary id::"+stationary.id+" Reject id:"+rejectArray[i]);
                stationaries.splice(i,1);
                return false;
                }
                }   
                );
                }//outer loop 
                */
                var myStationary = stationaries;
                for (var a = 0; a < rejectArray.length; a++) {
                    for (var b = 0; b < stationaries.length; b++) {
                        var stationary = stationaries[b];
                        if (stationary.id === rejectArray[a]) {
                            //			alert("Found:"+rejectArray[a]);
                            myStationary.splice(b, 1);
                            break;
                        }
                    } //inner
                } //outer
                removeRowsFromTable($('stationaryTable'));
                fillTable(myStationary);
            }
); //rejectButton

            function removeRowsFromTable(myTable) {
                //     document.getElementById('stationaryTable').innerHTML='<table id="stationaryTable">'+
                //'<thead><tr><td><input type="checkbox" id="checkAll"></td><td>Stationary</td><td>Quantity</td></tr></thead><tbody></tbody></table>';

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

        function fillTable(data) {
            $.each(data, function (i, stationary) {
                var tableRow = "<tr>"
	   + "<td><input class='check' type='checkbox' id='" + stationary.id + "'>" + "</td>"
	   + "<td>" + stationary.stationary + "</td>"
	   + "<td>" + stationary.quantity + "</td></tr>"
	   ;
                $(tableRow).appendTo("#stationaryTable tbody");
            }

   );
        } //fillTable
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<h3>Testing for Check box check and uncheck all</h3>
<div><input id='approveButton' type='submit' value='Approve'/><input id='rejectButton'type='submit' value='reject'/> </div>
<table id="stationaryTable">
<thead>
<tr>
<td><input type="checkbox" id="checkAll"></td><td>Stationary</td><td>Quantity</td></tr></thead>
<tbody></tbody>
</table>

    </div>
    </form>
</body>
</html>
