using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Collections;
using Newtonsoft.Json;
public partial class index : System.Web.UI.Page
{
    static ArrayList stationaryList = new ArrayList() { new Stationary("check1", "pen1", "1"),
     new Stationary("check2", "pen2", "1"),
     new Stationary("check3", "pen3", "3"),
     new Stationary("check4", "pen4", "3"),
     new Stationary("check5", "pen5", "3"),
     new Stationary("check6", "pen6", "3"),
     new Stationary("check7", "pen7", "3")};
    
    protected void Page_Load(object sender, EventArgs e)
    {

       /*
         stationaryList = new ArrayList();

        Stationary stationary1 = new Stationary();
        stationary1.Id = "check1";
        stationary1.StationaryName = "pen1";
        stationary1.Quantity = "1";

        Stationary stationary2 = new Stationary();
        stationary2.Id = "check2";
        stationary2.StationaryName = "pen2";
        stationary2.Quantity = "1";

        Stationary stationary3 = new Stationary();
        stationary3.Id = "check3";
        stationary3.StationaryName = "pen3";
        stationary3.Quantity = "1";

        Stationary stationary4 = new Stationary();
        stationary4.Id = "check4";
        stationary4.StationaryName = "pen4";
        stationary4.Quantity = "1";

        Stationary stationary5 = new Stationary();
        stationary5.Id = "check5";
        stationary5.StationaryName = "pen5";
        stationary5.Quantity = "1";

        Stationary stationary6 = new Stationary();
        stationary6.Id = "check6";
        stationary6.StationaryName = "pen6";
        stationary6.Quantity = "1";

        Stationary stationary7 = new Stationary();
        stationary7.Id = "check7";
        stationary7.StationaryName = "pen7";
        stationary7.Quantity = "7";

        stationaryList.Add(stationary1);
        stationaryList.Add(stationary2);
        stationaryList.Add(stationary3);
        stationaryList.Add(stationary4);
        stationaryList.Add(stationary5);
        stationaryList.Add(stationary6);
        stationaryList.Add(stationary7);*/
    }

    public class Stationary
    {

        private string _id;
        private string _stationaryName;
        private string _quantity;

        public Stationary(String _id, String _stationaryName, string _quantity)
        {
            this._id = _id;
            this._stationaryName = _stationaryName;
            this._quantity = _quantity;
        }//

        public string Id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string StationaryName
        {
            get { return _stationaryName; }
            set { _stationaryName = value; }
        }

        public string Quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }
      
    }//Stationary

    [WebMethod]
    public static string GetAllStationaries(){

        System.Diagnostics.Debug.WriteLine(" inside getAllStationaries  current count: " + stationaryList.Count);
        
        JavaScriptSerializer js = new JavaScriptSerializer();
        String str = js.Serialize(stationaryList);
        //stationaryList
        return str;
    }

    [WebMethod]
      public static void deleteStationaries(List<StationaryID> jsonParam) {
    //public static void deleteStationaries(Object jsonParam) {
        System.Diagnostics.Debug.WriteLine(" count json param ::"+jsonParam.Count);


        System.Diagnostics.Debug.WriteLine("1111count stationary List: " + stationaryList.Count);

       // System.Diagnostics.Debug.WriteLine(" dont give up::" + st.Id);
        ArrayList myStList = stationaryList;
        for (int i = 0; i < jsonParam.Count; i++)
        {
            StationaryID stI = jsonParam[i];
            for (int j = 0; j < myStList.Count; j++)
            {
                Stationary stJ = (Stationary)myStList[j];
                if (stJ.Id == stI.Id) {
                    System.Diagnostics.Debug.WriteLine("FOUNDDDD::" + stJ.Id+ "  "+ stI.Id);
                    stationaryList.RemoveAt(0);
                }
            }//innerloops
        }//outerloop

        System.Diagnostics.Debug.WriteLine(" 2222 count stationary List: " + stationaryList.Count);



      /* 
        StationaryID[] stArr = getStationaryIdArray(jsonParam);
        ArrayList myStList = stationaryList;
        for (int i = 0; i<stArr.Length;i++ ) {
        StationaryID stId = stArr[i];
        Console.WriteLine("STID:"+stId.Id);

        for (int j=0;j< myStList.Count;j++)
        {
            stationaryList.RemoveAt(j);
        }//inner


        }//outerList*/

    }


    public static StationaryID[] getStationaryIdArray(Object idArray)
    {
        

        System.Diagnostics.Debug.WriteLine(" inside getStationaryIdArray");

        string myString = idArray.ToString();
        System.Diagnostics.Debug.WriteLine(" check json data::" + myString);
        ArrayList idList = new ArrayList();
      //  var listOfId = new JavaScriptSerializer().Deserialize<List<StationaryID>>(idArray.ToString()).ToDictionary(x => x.Id);
        StationaryID[] result = JsonConvert.DeserializeObject<StationaryID[]>(myString);
        return result;
    } //getEmployeeArray
    

    public class StationaryID
    {
        private string id;
        public string Id
        {
            get { return id; }
            set { id = value; }
        }
    }//StationaryID

    

}