using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeMarket
{
    public partial class Categories : System.Web.UI.Page
    {
        private HomeMarket.Models.Repository repository = new HomeMarket.Models.Repository();

        protected IEnumerable<HomeMarket.Models.category> GetCategories()
        {
            return repository.Categories;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}