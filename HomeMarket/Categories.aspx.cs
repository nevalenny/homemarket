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
        private Models.Repository repository = new Models.Repository();

        protected IEnumerable<Models.category> GetCategories()
        {
            return repository.Categories;
        }

        protected Models.category GetCategorieById(int Id)
        {
            return (from category in repository.Categories where category.ID==Id select category).First();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            rptCategories.DataSource = repository.Categories.ToList<Models.category>();
            rptCategories.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "<script>$('#editCategoryModal').modal('show');</script>", false);
        }

    }
}