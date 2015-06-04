using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NLog;

namespace HomeMarket
{
    public partial class Categories : System.Web.UI.Page
    {
        private Models.Repository repository = new Models.Repository();
        private static Logger logger { get; set; }
        public Models.category emptyCategory = new Models.category();

        protected Categories() 
        { 
            logger = LogManager.GetCurrentClassLogger(); 
        }
        
        protected IEnumerable<Models.category> GetCategories()
        {
            return repository.Categories;
        }

        protected Models.category GetCategorieById(int Id)
        {
            try
            {
                return (from category in repository.Categories where category.ID == Id select category).First();
            }
            catch (Exception ex)
            {
                logger.ErrorException("Error occured on accessing DataBase", ex);
            }
            return emptyCategory;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                rptCategories.DataSource = repository.Categories.ToList<Models.category>();
                rptCategories.DataBind();
            }
            catch (Exception ex)
            {
                logger.ErrorException("Error occured on accessing DataBase", ex);                
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "<script>$('#editCategoryModal').modal('show');</script>", false);
        }

    }
}