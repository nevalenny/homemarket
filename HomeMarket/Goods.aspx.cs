using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;

namespace HomeMarket
{
    public partial class Goods : System.Web.UI.Page
    {
        private Models.Repository repository = new Models.Repository();
        public int iCategoryID = 0;
        public string sCategoryName = "No Category";

        protected IEnumerable<Models.Good> GetGoodsByCategoryID(int Id)
        {
            return (from good in repository.Goods orderby good.Name where good.CategoryID == Id select good);
        }

        protected Models.Good GetGoodByID(int Id)
        {
            try
            { return (from good in repository.Goods where good.ID == Id select good).First(); }
            catch (System.InvalidOperationException e)
            { }

            Models.Good goodEmpty = new Models.Good();
            goodEmpty.Available = 0;
            goodEmpty.Price = 0;

            return goodEmpty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
      
            try // CategoryID should be valid Int32
            { 
                iCategoryID = Int32.Parse(RouteData.Values["CategoryID"].ToString().Equals("") ? "0" : RouteData.Values["CategoryID"].ToString());
                sCategoryName = (from category in repository.Categories where category.ID == iCategoryID select category).First().Name;
            }
            catch (Exception ex)
            { }
            
            rptGoods.DataSource = GetGoodsByCategoryID(iCategoryID);
            rptGoods.DataBind();
        }
    }
}